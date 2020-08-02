# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# Pre-requisites
RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unzip \
    vim \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Add mosdepth binary from release and utility-plotting-script from source 
# We need to hack the python script a bit to add a proper header
RUN cd /usr/local/bin/ && \
    wget https://github.com/brentp/mosdepth/releases/download/v0.2.9/mosdepth && \
    chmod ugo+rx ./mosdepth && \
    wget https://github.com/brentp/mosdepth/archive/v0.2.9.tar.gz && \
    tar xvzf ./v0.2.9.tar.gz && \
    mv ./mosdepth-0.2.9/scripts/plot-dist.py . && \
    sed -i '1s;^;#!/usr/bin/env python3\n;' ./plot-dist.py && \
    chmod ugo+rx ./plot-dist.py && \
    rm -rf ./v0.2.9.tar.gz && \
    rm -rf ./mosdepth-0.2.9
 
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"

