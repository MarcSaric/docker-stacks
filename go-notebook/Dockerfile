# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/deseq2-biocparallel-notebook 

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER $NB_UID

# Add the Bioconductor installer and install the base packages
RUN R -e 'if (!requireNamespace("BiocManager")) {install.packages("BiocManager")};\
          BiocManager::install("Rgraphviz", "GOsummaries", "GOSemSim", "GOSim", "GOexpress", "EnrichmentBrowser")'

# Add DESeq2 dependencies from Bioconductor
RUN R -e 'install.packages(c("ontologyPlot", "GOplot"), repo = "https://cloud.r-project.org")'

