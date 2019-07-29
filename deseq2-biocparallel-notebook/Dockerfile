# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/datascience-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER $NB_UID

# R packages which gets installed globally.
RUN  conda install --quiet --yes \
    'r-gplots' \
    'r-ape' 

# Add the Bioconductor installer and install the base packages
RUN R -e 'if (!requireNamespace("BiocManager")) {install.packages("BiocManager")};\
          BiocManager::install()'

# Add DESeq2 dependencies from Bioconductor
RUN R -e 'install.packages(c("pheatmap", "fastcluster"), repo = "https://cloud.r-project.org")'

# # Add DESeq2 from Bioconductor and other packages
RUN R -e 'BiocManager::install(c("apeglm", \
                                 "BiocParallel", \
                                 "DESeq2", \
                                 "DEGreport", \
                                 "vsn", \
                                 "goseq", \
                                 "EnsDb.Hsapiens.v86", \
                                 "org.Hs.eg.db", \
                                 "Rsubread")\
                               )'
