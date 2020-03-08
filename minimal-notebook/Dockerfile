# Copyright (c) Jupyter Development Team.
# This is a fork of the notebooks from Jupyter Dev Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=marcsaric/base-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install -yq --no-install-recommends \
    aptitude \
    build-essential \
    emacs \
    git \
    git-annex \
    htop \
    inkscape \
    jed \
    less \
    libcurl4-openssl-dev \
    libsm6 \
    libssl-dev \
    libxext-dev \
    libxrender1 \
    libxml2-dev \
    lmodern \
    man \
    netcat \
    python-dev \
    # ---- nbconvert dependencies ----
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    # Optional dependency
    texlive-fonts-extra \
    # ----
    tzdata \
    unzip \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the bash-kernel from https://github.com/takluyver/bash_kernel
RUN pip install bash_kernel \
    && python -m bash_kernel.install

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
