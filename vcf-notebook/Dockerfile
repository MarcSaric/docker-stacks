# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER root

# Just do a cleanup
RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Add vcf tooling and other bioinformatics tools from source 
RUN pip install biopython PyVCF vcfpy pysam

# Somethign is wrong with the permissions in the lower layers
USER root

RUN conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID
