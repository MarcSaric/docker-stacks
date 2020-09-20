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
    automake \
    binutils \
    cmake \
    fonts-dejavu \
    git \
    g++ \
    libbz2-dev \
    liblzma-dev \
    libncurses-dev \
    libopenblas-base \
    libopenblas-dev \
    libnss-sss \
    unzip \
    vim \
    wget \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Install samtools latest
RUN cd /usr/local/ && \
    wget https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2 && \
    tar xf htslib-1.10.2.tar.bz2 && \
    mv htslib-1.10.2 htslib && \
    cd htslib && \
    ./configure --prefix=/usr/local && \
    make && \
    make install
# Install samtools latest
RUN cd /usr/local/ && \
    wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
    tar xf samtools-1.10.tar.bz2 && \
    mv samtools-1.10 samtools && \
    cd samtools && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# Install bcftools latest
RUN cd /usr/local/ && \
    wget https://github.com/samtools/bcftools/releases/download/1.10.2/bcftools-1.10.2.tar.bz2 && \
    tar xf bcftools-1.10.2.tar.bz2 && \
    mv bcftools-1.10.2 bcftools && \
    cd bcftools && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# FIXME: Maybe link the perl utilities to /usr/local/bin as well
    
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Clean up
RUN rm -rf /usr/local/htslib* /usr/local/samtools* /usr/local/bcftools*

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
