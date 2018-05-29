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

# Testinstall the bash-kernel from https://github.com/takluyver/bash_kernel
RUN pip install bash_kernel \
    && python -m bash_kernel.install

# Add Biopython and other bioinformatics tools from Conda
RUN conda install --quiet --yes \
    -c bioconda \
    'pysam' \
    'pysamstats' \
    'bwa=0.7.17' \
    'picard=2.18.4' \
    'gatk4=4.0.4.0'

  
RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR

USER $NB_USER


