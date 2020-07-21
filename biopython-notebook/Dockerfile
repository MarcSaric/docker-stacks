# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/minimal-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# R pre-requisites # FIXME: Those are already in the minimal notebook?
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# Add Biopython and other bioinformatics tools from source 
RUN pip install biopython

# Clean up
RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR

