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

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
RUN ln -s /bin/tar /bin/gtar

USER $NB_USER

# FIXME: Add Biopython either from Conda or from scratch

# Add that database-tool as well: https://pythonhosted.org/cruzdb/

    conda clean -tipsy && \
    fix-permissions $CONDA_DIR




