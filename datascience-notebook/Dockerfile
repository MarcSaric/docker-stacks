# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER root

# R pre-requisites # FIXME: Those are already in the minimal notebook?
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && \
    rm -rf /var/lib/apt/lists/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
RUN ln -s /bin/tar /bin/gtar

USER $NB_UID

# R packages including IRKernel which gets installed globally.
# Adjusted versions to latest major and minor digits
RUN conda config --system --append channels r && \
    conda install --quiet --yes \
    'gcc_linux-64' \
    'gxx_linux-64' \
    'gfortran_linux-64' \
    'rpy2=2.9*' \
    'rstudio' \
    'r-base=3.5.1' \
    'r-irkernel=0.8*' \
    'r-plyr=1.8*' \
    'r-devtools=1.13*' \
    'r-tidyverse=1.2*' \
    'r-shiny=1.2*' \
    'r-rmarkdown=1.11*' \
    'r-forecast=8.2*' \
    'r-rsqlite=2.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=1.0*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' \
    'r-htmltools=0.3*' \
    'r-sparklyr=0.9*' \
    'r-htmlwidgets=1.2*' \
    'r-hexbin=1.27*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN R -e 'library("devtools");\
          install_github(c("jrnold/ggthemes"))'


# Install TCGAbiolinks from dev
RUN R -e 'if (!requireNamespace("BiocManager"))\
             install.packages("BiocManager")\
          BiocManager::install();'
RUN R -e 'library("devtools");\
          install_github("BioinformaticsFMRP/TCGAbiolinks")'

