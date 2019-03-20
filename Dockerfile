FROM alpine:3.9 as rdkit-build

RUN apk add --no-cache \
    make g++ cmake \
    eigen-dev \
    python3 py3-numpy python3-dev py-numpy-dev \
    boost-dev

ARG RDKIT_VERSION=Release_2018_09_1
    
RUN cd opt \
    && wget https://github.com/rdkit/rdkit/archive/${RDKIT_VERSION}.zip \
    && unzip ${RDKIT_VERSION}.zip \
    && mv rdkit-${RDKIT_VERSION} rdkit \
    && rm ${RDKIT_VERSION}.zip

RUN cd /opt/rdkit \
    && mkdir build \
    && cd build \
    && cmake -DRDK_BUILD_PYTHON_WRAPPERS=ON -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_NUMPY_INCLUDE_PATH=/usr/lib/python3.6/site-packages/numpy/core/include/ .. \
    && make -j $(nproc) \
    && make install

FROM alpine:3.9 as rdkit-runtime

RUN apk add --no-cache \
    python3 py3-numpy boost-python3 libstdc++ boost-serialization

ENV RDBASE=/opt/rdkit
ENV PYTHONPATH=$RDBASE:$PYTHONPATH
ENV LD_LIBRARY_PATH=$RDBASE/lib:$LD_LIBRARY_PATH

COPY --from=rdkit-build /opt/rdkit/Data /opt/rdkit/Data
COPY --from=rdkit-build /opt/rdkit/lib/*so* /opt/rdkit/lib/
COPY --from=rdkit-build /opt/rdkit/rdkit /opt/rdkit/rdkit
