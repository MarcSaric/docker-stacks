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
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    unzip \
    vim \
    wget \
    zlib1g \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# Install variant-filteration-tool using the commands from https://github.com/NCI-GDC/varscan-tool/commit/5312b77a6138d124afa9364fef8794c358a038c6
RUN cd /tmp/ && \
    wget https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2 && \
    tar xf samtools-1.8.tar.bz2 && \
    cd samtools-1.8 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd ../ && \
    rm -rf samtools-1.8 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /tmp && \
    wget https://github.com/MarcSaric/variant-filtration-tool/archive/v1.0.3.tar.gz && \
    tar xvzf ./v1.0.3.tar.gz && \
    cd variant-filtration-tool-1.0.3/ && \
    pip install -r requirements.txt && \
    python setup.py install && \
    # Do this shit by hand then and skipt the test suite
    # cp -r ./build/lib/gdc_filtration_tools /opt/conda/lib/python3.7/site-packages && \
    cp ./bin/gdc_filtration_tools /usr/local/bin && \
    cd / && \
    rm -rf /tmp/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
