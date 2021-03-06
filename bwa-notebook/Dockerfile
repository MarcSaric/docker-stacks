# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# Pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    unzip \
    vim \
    zlib1g \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Install bwa and samtools using the commands from https://github.com/NCI-GDC/bwa_docker/commit/d7ccd79da3cf1106791a95278eaccd437a368fa8 
RUN wget https://github.com/NCI-GDC/bwa/archive/gdc_a.tar.gz && \
    tar xf gdc_a.tar.gz && \
    cd bwa-gdc_a && \
    make && \
    mv bwa /usr/local/bin/ && \
    cd ../ && \
    rm -rf bwa* && \
    wget https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2 && \
    tar xf samtools-1.8.tar.bz2 && \
    cd samtools-1.8 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd ../ && \
    rm -rf samtools-1.8 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
