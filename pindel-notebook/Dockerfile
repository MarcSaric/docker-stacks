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

# Install Pindel using the commands from https://github.com/genome/pindel/commit/509ee862d6ce3b79e35857b1ed8fcb47186e447d
RUN cd /usr/local/ && \
    wget https://github.com/samtools/htslib/releases/download/1.3.2/htslib-1.3.2.tar.bz2 && \
    tar xf htslib-1.3.2.tar.bz2 && \
    mv htslib-1.3.2 htslib && \
    cd htslib && \
    make && \
    make install
# And run pindel separate install, because this is fucking broken
RUN cd /usr/local/ && \
    git clone --recursive https://github.com/MarcSaric/pindel.git && \
    cd /usr/local/pindel/ && \
    ./INSTALL /usr/local/htslib && \
    ln -s /usr/local/pindel/pindel /usr/local/bin/pindel
# FIXME: Maybe link the perl utilities to /usr/local/bin as well
    
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
