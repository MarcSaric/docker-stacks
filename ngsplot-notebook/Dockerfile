# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    openjdk-8-jre-headless \
    gfortran \
    libmariadbclient-dev \
    libmariadb-client-lgpl-dev \
    libssl-dev \
    gcc \
    unzip && \
    rm -rf /var/lib/apt/lists/*


USER $NB_UID

# Add required packages from CRAN
# foreign is R 4 only, for older versions see a solution from https://stackoverflow.com/questions/61922375/foreign-package-in-r
RUN R -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/foreign/foreign_0.8-76.tar.gz")'
 

# Installing deps
RUN R -e 'BiocManager::install("trackViewer", version="3.10")'
RUN R -e 'BiocManager::install("RMariaDB")'
RUN R -e 'BiocManager::install("org.Hs.eg.db")'
RUN R -e 'BiocManager::install("ggbio")'
RUN R -e 'BiocManager::install("GenVisR")'

# Install collections
RUN R -e 'install.packages(c("collections", "rlist"), repo = "https://cloud.r-project.org")'