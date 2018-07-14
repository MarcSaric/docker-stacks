# Copyright (c) Jupyter Development Team.
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

# Add ChAMP manually
# https://bioconductor.org/packages/release/bioc/html/ChAMP.html
RUN R -e 'source("https://bioconductor.org/biocLite.R");biocLite("ChAMP")'

