# Copyright (c) Jupyter Development Team, Marc Saric.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/minimal-notebook

MAINTAINER Marc Saric <marc.saric@gmx.de>

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# R packages
RUN conda install -c rdonnellyr \
     'r-essentials=1.6.0' --quiet --yes \
     && conda clean -tipsy
