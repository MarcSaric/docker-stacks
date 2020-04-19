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
    cmake \
    fonts-dejavu \
    libncurses-dev \
    unzip \
    vim \
    wget \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Install SomaticSniper using the commands from https://github.com/NCI-GDC/somaticsniper-tool/commit/a9a45404318646ffd3d20b108f6adfaeb40f2a1b
RUN wget https://github.com/genome/somatic-sniper/archive/v1.0.5.0.tar.gz \
    && tar xvzf v1.0.5.0.tar.gz \
    && rm v1.0.5.0.tar.gz \
    && cd ./somatic-sniper-1.0.5.0 \
    && cmake . \
    && make deps \
    && make -j \
    && make install
    
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
