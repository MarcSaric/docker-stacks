# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/scipy-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# R pre-requisites # FIXME: Those are already in the minimal notebook?
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    libmariadb-client-lgpl-dev \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER
############################

# Add folium and other bioinformatics tools from Conda
RUN conda install --quiet --yes \
    -c anaconda \
    'autopep8'

RUN conda install --quiet --yes \
    -c conda-forge \
    'pandas=0.22*' \
    'folium' \
    'gpxpy' \
    'jupyter_contrib_nbextensions' \
    'jupyter_nbextensions_configurator'

RUN conda install --quiet --yes \
    -c pyviz \
    'pyviz' 

RUN conda install -c damianavila82 rise
RUN jupyter-nbextension install rise --py --sys-prefix

# Activate nbextensions_configurator
RUN jupyter nbextensions_configurator enable --user

RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR


