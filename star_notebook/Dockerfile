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
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Testinstall the bash-kernel from https://github.com/takluyver/bash_kernel
RUN pip install bash_kernel \
    && python -m bash_kernel.install

# Add tools as per ICGC RNS-Seq Align container
RUN apt-get update
RUN apt-get install -y curl wget g++ make python libboost-dev libboost-thread-dev libboost-system-dev zlib1g-dev ncurses-dev unzip gzip bzip2 libxml2-dev libxslt-dev python-dev python-pip
WORKDIR /opt

RUN		mkdir /opt/bin

#install samtools
RUN     wget http://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2
RUN     tar xvjf samtools-0.1.19.tar.bz2
RUN     cd /opt/samtools-0.1.19 && make
RUN     cp /opt/samtools-0.1.19/*.a /usr/local/lib/
RUN     mkdir /usr/local/include/bam
RUN     cp /opt/samtools-0.1.19/*.h /usr/local/include/bam/
RUN		cp /opt/samtools-0.1.19/samtools /opt/bin/

#install bowtie
RUN		wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.3/bowtie2-2.2.3-source.zip
RUN		unzip bowtie2-2.2.3-source.zip
RUN		cd /opt/bowtie2-2.2.3 && make && cp bowtie2* /opt/bin/

#install tophat
RUN     curl -O http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.12.tar.gz
RUN     tar xvzf tophat-2.0.12.tar.gz
RUN     cd /opt/tophat-2.0.12 && ./configure --prefix=/opt --with-boost-libdir=/usr/lib/x86_64-linux-gnu/ && make && make install

#install STAR
RUN     wget https://github.com/alexdobin/STAR/archive/STAR_2.4.0i.tar.gz
RUN     tar xvzf STAR_2.4.0i.tar.gz
RUN     cp /opt/STAR-STAR_2.4.0i/bin/Linux_x86_64/STAR /opt/bin/

#install python packages
RUN     pip install lxml


ENV	PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin

# Cleanup conda (may be unneccessary)  
USER $NB_USER

RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR

USER $NB_USER


