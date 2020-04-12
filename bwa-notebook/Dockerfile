# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# Pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim \
    zlib1g \
    zlib1g-dev \
    libncurses5-dev \
    fonts-dejavu \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

WORKDIR /opt

# Install BWA Alignment - bwa 0.7.15
RUN wget https://sourceforge.net/projects/bio-bwa/files/bwakit/bwakit-0.7.15_x64-linux.tar.bz2 && \
    tar xvjf ./bwakit-0.7.15_x64-linux.tar.bz2

# Install samtools 1.3.1
RUN wget https://sourceforge.net/projects/samtools/files/samtools/1.3.2/htslib-1.3.2.tar.bz2 && \
    tar xvjf htslib-1.3.2.tar.bz2 && \
    cd /opt/htslib-1.3.2 && \
    ./configure --prefix=/opt/samtools && \
    make && \
    make install && \
    cd .. && \
    rm -rf /opt/htslib-1.3.2

WORKDIR /opt

RUN wget https://sourceforge.net/projects/samtools/files/samtools/1.3.1/samtools-1.3.1.tar.bz2 && \
    tar xvjf samtools-1.3.1.tar.bz2 && \
    cd /opt/samtools-1.3.1 && \
    ./configure --prefix=/opt/samtools && \
    make && \
    make install && \
    cd .. && \
    rm -rf /opt/samtools-1.3.1

WORKDIR /opt

RUN wget https://sourceforge.net/projects/samtools/files/samtools/1.3.1/bcftools-1.3.1.tar.bz2 && \
    tar xvjf bcftools-1.3.1.tar.bz2 && \
    cd /opt/bcftools-1.3.1 && \
    make && \
    make prefix=/opt/samtools install && \
    cd .. && \
    rm -rf /opt/bcftools-1.3.1

RUN rm *.tar.bz2

ENV PATH /opt/samtools/bin:/opt/bwa.kit:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
