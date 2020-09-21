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
    openjdk-8-jre-headless \
    unzip \
    vim \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix a bug in some R-packages, which want /bin/gtar instead of /bin/tar
# And try to fix https://github.com/r-lib/devtools/issues/1722
RUN ln -s /bin/tar /bin/gtar && export TAR=/bin/tar

# The horror
# Clone the forked GitHub repo containing the multi-mutect wrapper
RUN cd /usr/local/ && \
    # wget https://github.com/MarcSaric/mutect2-tool/archive/PBV11.tar.gz && \
    # tar xvzf ./PBV11.tar.gz && \
    wget https://github.com/MarcSaric/mutect2-tool/archive/master.zip && \
    unzip ./master.zip && \
    ls -a

# Add it
RUN cp /usr/local/mutect2-tool-master/docker/multi_mutect2/multi_mutect2_p3.py /usr/local/bin/ && \
    chmod ugo+x /usr/local/bin/multi_mutect2_p3.py

# Clean up
RUN rm -rf /usr/local/mutect2-tool-master* \
    /usr/local/master.zip #\
    /usr/local/PBV11.tar.gz 

# Install MuTECT from GATK 3.7 using the commands from https://github.com/NCI-GDC/mutect2-tool/commit/bd3492e8d2aba6c825de1c783bfe202e8f1a92f5
ADD GenomeAnalysisTK.jar /usr/local/bin/

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
