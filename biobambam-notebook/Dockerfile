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
    libtool \
    autotools-dev \
    automake \
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

# Install libmaus2
RUN wget https://gitlab.com/german.tischler/libmaus2/-/archive/2.0.243-release-20160802161754/libmaus2-2.0.243-release-20160802161754.tar.bz2 && \
    tar xvjf ./libmaus2-2.0.243-release-20160802161754.tar.bz2 && \
    cd /opt/libmaus2-2.0.243-release-20160802161754 && \
  	libtoolize && \
	aclocal && \
	autoreconf -i -f && \
	./configure --prefix=/opt/biobambam && \
	make

# Install biobambam
RUN wget https://gitlab.com/german.tischler/biobambam2/-/archive/2.0.54-release-20160802163650/biobambam2-2.0.54-release-20160802163650.tar.bz2 && \
    tar xvjf ./biobambam2-2.0.54-release-20160802163650.tar.bz2 && \
    cd /opt/biobambam2-2.0.54-release-20160802163650 && \
    autoreconf -i -f && \
    ./configure --with-libmaus2=/opt/biobambam \
        --prefix=/opt/biobambam && \
    make install && \
    cd .. && \
    rm -rf /opt/biobambam2-2.0.54-release-20160802163650

ENV PATH /opt/biobambam:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
