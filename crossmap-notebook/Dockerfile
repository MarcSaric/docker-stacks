# Choose your desired base image
FROM jupyter/scipy-notebook:82b978b3ceeb

# Create a Python 2.x environment using conda including at least the ipython kernel
# and the kernda utility. Add any additional packages you want available for use
# in a Python 2 notebook to the first line here (e.g., pandas, matplotlib, etc.)
#RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 ipython ipykernel kernda && \
#    conda clean -tipsy
#RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 -c conda-forge python=2.7 ipython kernda=0.2 ipykernel && \
#conda clean -tipsy

#USER root

# Create a global kernelspec in the image and modify it so that it properly activates
# the python2 conda environment.
#RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
#$CONDA_DIR/envs/python2/bin/kernda -o -y /usr/local/share/jupyter/kernels/python2/kernel.json

USER $NB_USER

# Add Biopython either from Conda or from scratch
RUN conda install --quiet --yes \
    -c bioconda crossmap

RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR
