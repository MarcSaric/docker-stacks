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

# Add ChAMP manually, as it is not in any of the conda repositories
# https://bioconductor.org/packages/release/bioc/html/ChAMP.html
RUN R -e 'Sys.setenv(R_MAX_NUM_DLLS = 512);source("https://bioconductor.org/biocLite.R");biocLite(c("minfi","ChAMPdata","Illumina450ProbeVariants.db","sva","IlluminaHumanMethylation450kmanifest","limma","RPMM","DNAcopy","preprocessCore","impute","marray","wateRmelon","goseq","plyr","GenomicRanges","RefFreeEWAS","qvalue","isva","doParallel","bumphunter","quadprog","shiny","shinythemes","plotly","RColorBrewer","DMRcate","dendextend","IlluminaHumanMethylationEPICmanifest","FEM","matrixStats","missMethyl","combinat"))'
RUN R -e 'Sys.setenv(R_MAX_NUM_DLLS = 512);source("https://bioconductor.org/biocLite.R");biocLite("ChAMP")'
