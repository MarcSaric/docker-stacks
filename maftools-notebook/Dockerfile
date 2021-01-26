# Copyright (c) Marc Saric, Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/datascience-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# R pre-requisites 
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER
# Install collections
RUN R -e 'install.packages(c("mclust"), repo = "https://cloud.r-project.org")'

# Add maftools manually from GitHub to get the latest version.
# https://www.bioconductor.org/packages/release/bioc/html/maftools.html
RUN R -e 'if (!require("BiocManager")) install.packages("BiocManager")'
RUN R -e 'library(devtools);install_github("MarcSaric/maftools:PBV11")'
