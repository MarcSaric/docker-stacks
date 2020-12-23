# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/vep-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# Pre-requisites
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && apt-get upgrade -y && \
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

RUN cd /usr/local/ && \
    wget https://github.com/mskcc/vcf2maf/archive/v1.6.19.tar.gz && \
    tar xvzf v1.6.19.tar.gz && \
    mv vcf2maf-1.6.19 vcf2maf && \
    rm -rf v1.6.19.tar.gz

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
