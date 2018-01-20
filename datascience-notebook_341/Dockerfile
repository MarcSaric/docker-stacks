# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/scipy-notebook_341

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

# R packages including IRKernel which gets installed globally.
# Added order of channels as per https://bioconda.github.io/
# Adjusted versions to latest major and minor digits
RUN conda config --system --add channels r \
    conda config --system --add channels defaults \
    conda config --system --add channels conda-forge \
    conda config --system --add channels bioconda && \
    conda install --quiet --yes \
    'gcc_linux-64' \
    'gxx_linux-64' \
    'gfortran_linux-64' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    conda install --quiet --yes \
    'rpy2=2.9*' \
    'rstudio=1.1*' \
    'r-base=3.4.2' \
    'r-irkernel=0.8*' \
    'r-plyr=1.8*' \
    'r-devtools=1.13*' \
    'r-tidyverse=1.1*' \
    'r-shiny=1.0.5*' \
    'r-rmarkdown=1.6*' \
    'r-forecast=8.2*' \
    'r-rsqlite=2.0*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' \
    'r-dt=0.2' \
    'r-mvtnorm=1.0_6 ' \
    'r-exactranktests=0.8_29' \
    FIXME '-c bioconda bioconductor-zlibbioc=1.24.0' \
    FIXME '-c bioconda bioconductor-genomicalignments=1.14.0' \
    FIXME '-c bioconda bioconductor-geneplotter=1.56.0' \
    'r-rjson=0.2.15' \
    FIXME '-c conda-forge r-ggpubr=0.1.6' \
    FIXME '-c conda-forge r-maxstat=0.7_25' \
    FIXME '-c conda-forge r-cmprsk=2.2_7' \
    FIXME '-c bioconda bioconductor-xvector=0.18.0' \
    FIXME '-c bioconda bioconductor-biobase=2.38.0' \
    FIXME '-c bioconda bioconductor-shortread=1.36.0' \
    FIXME Which one? '-c bioconda bioconductor-deseq2=1.18.1' \
    FIXME Which one? '-c bioconda bioconductor-deseq=1.30.0' \
    FIXME '-c bioconda bioconductor-aroma.light=3.8.0' \
    FIXME '-c bioconda bioconductor-rsamtools=1.30.0' \
    FIXME '-c bioconda bioconductor-biostrings=2.46.0' \
    FIXME '-c bioconda bioconductor-annotationdbi=1.40.0' \
    FIXME '-c bioconda r-locfit=1.5_9.1' \
    FIXME '-c bioconda r-getoptlong=0.1.0' \
    FIXME '-c bioconda bioconductor-delayedarray=0.4.1' \
    FIXME '-c bioconda bioconductor-annotate=1.56.0' \
    FIXME Right package??? '-c bioconda bioconductor-all=1.20.0' \
    FIXME '-c bioconda r-rmysql=0.10.11' \
    FIXME '-c bioconda bioconductor-rtrackl=1.38.0' \
    FIXME '-c bioconda bioconductor-biocparallel=1.12.0' \
    FIXME '-c bioconda r-matrixstats=0.51.0' \
    FIXME '-c conda-forge r-survminer=0.4.1' \
    FIXME '-c bioconda bioconductor-genomicranges=1.30.0' \
    FIXME Right package??? '-c r r-xml=3.98_1.9' \
    FIXME '-c bioconda bioconductor-edaseq=2.12.0' \
    FIXME '-c bioconda bioconductor-edger=3.20.1' \
    FIXME '-c bioconda bioconductor-biomart=2.34.0' \
    FIXME '-c bioconda bioconductor-iranges=2.12.0' \
    FIXME '-c bioconda bioconductor-s4vectors=0.16.0' \
    FIXME '-c bioconda bioconductor-complexheatmap=1.17.1' \
    FIXME '-c bioconda bioconductor-summarizedexperiment=1.8.0' \
    FIXME '-c bioconda bioconductor-genefilter=1.60.0' \
    FIXME '-c bioconda bioconductor-consensusclusterplus=1.42.0' \
    FIXME '-c bioconda bioconductor-genomeinfodb=1.14.0' \
    FIXME '-c bioconda bioconductor-genomicfeatures=1.30.0' \
    FIXME '-c bioconda bioconductor-sva=3.26.0' \
    FIXME '-c bioconda bioconductor-limma=3.34.1' \
    FIXME '-c bioconda r-ggrepel=0.6.5' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

# FIXME: Add TCGAbiolinks from Bioconductor
RUN R -e 'source("https://bioconductor.org/biocLite.R");biocLite("TCGAbiolinks")'
