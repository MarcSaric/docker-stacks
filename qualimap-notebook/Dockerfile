# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
ARG TEST_ONLY_BUILD

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    openjdk-8-jre-headless \
    gfortran \
    gcc \
    unzip && \
    rm -rf /var/lib/apt/lists/*


# Need to disable some UI crap for Qualimap to work
# See e.g. https://askubuntu.com/questions/695560/assistive-technology-not-found-awterror
RUN sed -i -e '/^assistive_technologies=/s/^/#/' /etc/java-*-openjdk/accessibility.properties

USER $NB_UID

#installing deps
RUN R -e 'BiocManager::install(c("optparse", "NOISeq", "XML", "Repitools", "Rsamtools", "rtracklayer"))'

# Install Qualimap
RUN wget https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip
# Because download takes too long
RUN unzip qualimap_v2.2.1.zip && \
    rm qualimap_v2.2.1.zip 

# Install dependencies
ENV QUALIMAP_HOME /home/jovyan/qualimap_v2.2.1
