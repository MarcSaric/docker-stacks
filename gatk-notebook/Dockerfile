# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/scipy-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    libmariadb-client-lgpl-dev \
    gfortran \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_USER

# Add tools from Bioconda
# Versions are latest from bioconda as of today
# pysamstats can't be installed with version number
# FIXME: Does not work so far. Incompatible packages
RUN conda install --quiet --yes \
    -c bioconda \
    'pysam' \
    'pysamstats' \
    'bwa' \
    'picard' \
    'gatk4' \
    'seqkit' \
    'biobambam' \
    'samtools'
 
RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR

USER $NB_USER

