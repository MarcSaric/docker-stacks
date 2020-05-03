# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# Pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    autoconf \
    autotools-dev \
    automake \
    curl \
    fonts-dejavu \
    libncurses5-dev \
    libtool \
    pkg-config \
    libgomp1 \
    unzip \
    vim \
    zlib1g \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Install libmaus2 and biobambam using the commands from https://github.com/NCI-GDC/biobambam_docker/commit/e2f64c73c2eaf0c2c803c8b77837e578caf33ea7
ENV LD_LIBRARY_PATH /usr/local/lib

RUN curl --silent https://gitlab.com/german.tischler/libmaus2/repository/archive.tar.gz\?ref\=2.0.610-release-20190328154814 -o libmaus2.tar.gz && \
    curl --silent https://gitlab.com/german.tischler/biobambam2/repository/archive.tar.gz\?ref\=2.0.95-release-20190320141403 -o biobambam2.tar.gz && \
    libmaus2files=$(tar -axvf libmaus2.tar.gz) && \
    libmaus2dir=$(echo ${libmaus2files} | cut -f1 -d" ") && \
    cd ${libmaus2dir} && \
    libtoolize && \
    aclocal && \
    autoreconf -i -f && \
    ./configure && \
    make -j4 && \
    make install && \
    cd ../ && \ 
    rm -rf ${libmaus2dir} libmaus2.tar.gz && \
    biobambam2files=$(tar -axvf biobambam2.tar.gz) && \
    biobambam2dir=$(echo ${biobambam2files} | cut -f1 -d" ") && \
    cd ${biobambam2dir} && \
    export LIBMAUSPREFIX=/usr/local && \
    autoreconf -i -f && \
    ./configure --with-libmaus2=${LIBMAUSPREFIX} && \
    make -j4 && \
    make install && \
    cd ../ && \
    rm -rf ${biobambam2dir} biobambam2.tar.gz && \
    apt-get remove --purge -y \
        autoconf \
        curl \
        g++ \
        libtool \
        pkg-config \
        zlib1g-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
