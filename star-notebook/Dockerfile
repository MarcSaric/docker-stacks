# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM marcsaric/scipy-notebook

LABEL maintainer="Marc Saric <marc.saric@gmx.de>"

USER root

# R pre-requisites # FIXME: Those are already in the minimal notebook?
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    libmariadb-client-lgpl-dev \
    gfortran \
    gcc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add tools as per ICGC RNS-Seq Align container
# FIXME: There may be duplicated packages here (but this has no negative consequences)
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    g++ \
    make \
    python \
    libboost-dev \
    libboost-thread-dev \
    libboost-system-dev \
    zlib1g-dev \
    ncurses-dev \
    unzip \
    gzip \
    bzip2 \
    libxml2-dev \
    libxslt-dev \
    python-dev \
    python-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN mkdir /opt/bin

# Install samtools
RUN wget http://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2 && \
    tar xvjf samtools-0.1.19.tar.bz2 && \
    cd /opt/samtools-0.1.19 && make && \
    cp /opt/samtools-0.1.19/*.a /usr/local/lib/ && \
    mkdir /usr/local/include/bam && \
    cp /opt/samtools-0.1.19/*.h /usr/local/include/bam/ && \
    cp /opt/samtools-0.1.19/samtools /opt/bin/

# Install STAR
RUN wget https://github.com/alexdobin/STAR/archive/STAR_2.4.0i.tar.gz && \
    tar xvzf STAR_2.4.0i.tar.gz && \
    cp /opt/STAR-STAR_2.4.0i/bin/Linux_x86_64/STAR /opt/bin/

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:$PATH

# Install the star wrapper from local
COPY star_align.py /opt/bin/star_align.py 

# Install python packages
RUN conda install -c anaconda lxml 
RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR

# Reset to jovian home
WORKDIR /home/$NB_USER
USER $NB_UID

# Finally fix the git access
# FIXME: We would also need to copy or link the .ssh and .gpg keys
RUN git config --global user.email "marc.saric@gmx.de"
RUN git config --global user.name "Marc Saric"
