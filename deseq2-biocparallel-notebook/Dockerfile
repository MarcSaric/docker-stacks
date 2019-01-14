# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/datascience-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER $NB_UID

# Add DESeq2 dependencies from Bioconductor
# For historic reasons DESeq2 is already in the datascience-notebook
RUN R -e 'source("https://bioconductor.org/biocLite.R");\
                 biocLite(c("apeglm", "BiocParallel", "DEGreport"))'



