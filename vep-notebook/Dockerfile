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
    git \
    libcgi-pm-perl \
    libwww-perl \
    libclass-dbi-perl \
    libarchive-extract-perl \
    libarchive-zip-perl \
    libjson-perl \
    libfile-copy-recursive-perl \
    libmodule-build-perl \
    unzip \
    vim \
    wget \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Install VEP using the commands from https://github.com/NCI-GDC/vep-tool/commit/b774e6fcc0f046d9155907ccc242e6e3c2449c6a

# There are lots of issues with v84 install. To mitigate the problems
# we first download bioperl, unpack and add to perl lib.
RUN mkdir -p /opt/lib/ \
    && cd /opt \
    && wget https://github.com/bioperl/bioperl-live/archive/release-1-6-924.zip \
    && unzip release-1-6-924.zip \
    && mv /opt/bioperl-live-release-1-6-924/Bio /opt/lib/ \
    && rm /opt/release-1-6-924.zip \
    && rm -rf /opt/bioperl-live-release-1-6-924
ENV PERL5LIB ${PERL5LIB}:/opt/lib/

# Next, we install VEP, but we must remove the test directory before installing
# because something is wrong with the test cache.
RUN cd /opt \
    && wget https://github.com/Ensembl/ensembl-tools/archive/release/84.zip \
    && unzip 84.zip \
    && mv ensembl-tools-release-84 ensembl-tools \
    && rm 84.zip \
    && cd /opt/ensembl-tools/scripts/variant_effect_predictor/ \
    && rm -rf /opt/ensembl-tools/scripts/variant_effect_predictor/t \
    && perl INSTALL.pl --AUTO a --TEST 0
ENV PATH ${PATH}:/opt/ensembl-tools/scripts/variant_effect_predictor/

# Set htslib path
ENV PATH ${PATH}:/opt/ensembl-tools/scripts/variant_effect_predictor/htslib/

# Add VEP plugins copied from https://github.com/MarcSaric/vep-tool
RUN mkdir -p /opt/vep-plugins/
ADD vep-plugins /opt/vep-plugins/
    
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
