# RDKit Docker Image

This Docker image provides [Python](https://www.python.org/) 3 with 
[RDKit](https://github.com/rdkit/rdkit) library.

The image is designed to be lightweight and provide only what is necessary 
to run Python scripts with RDKit.

## Running

Use following command to run an interactive shell:
```
docker run -it --rm skodapetr/rdkit:{TAG} /bin/sh
```
List of ```{TAG}``` values can be found at project's 
docker hub [pages](https://hub.docker.com/r/skodapetr/rdkit/tags).

## Related work

* [mcs07/docker-rdkit](https://github.com/mcs07/docker-rdkit)
