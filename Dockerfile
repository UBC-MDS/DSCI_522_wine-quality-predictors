# Docker file for Wine Quality Predictors
# Created by Iris

# References
# General instruction, DSCI 522 lecture 7: https://github.ubc.ca/MDS-2018-19/DSCI_522_dsci-workflows_students/blob/master/lectures/07_lecture_writing_dockerfiles.ipynb
# Install graphviz: https://github.com/Kaggle/docker-python/blob/master/Dockerfile
# Base image: https://hub.docker.com/r/rocker/tidyverse/
# Make2graph from Tiffany: https://hub.docker.com/r/ttimbers/makefile2graph/~/dockerfile/

# use rocker/tidyverse as the base image
FROM rocker/tidyverse

# install the cowplot package
RUN install2.r --error \
  cowplot

# install python3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# get python package dependencies
RUN apt-get install -y python3-tk

# install numpy, pandas, sklearn, graphviz, argparse
RUN pip3 install numpy
RUN pip3 install pandas
RUN apt-get install -y graphviz && pip install graphviz
RUN apt-get update && \
    pip3 install sklearn && \
    pip3 install argparse && \
    rm -rf /var/lib/apt/lists/*

# below is code from makefile2graph:

# get OS updates and install build tools
RUN apt-get update
RUN apt-get install -y build-essential

# install graphviz
RUN apt-get install -y graphviz

# install git
RUN apt-get install -y wget
RUN apt-get install -y make git

# clone, build makefile2graph,
# then copy key makefile2graph files to usr/bin so they will be in $PATH
RUN git clone https://github.com/lindenb/makefile2graph.git

RUN make -C makefile2graph/.

RUN cp makefile2graph/makefile2graph usr/bin
RUN cp makefile2graph/make2graph usr/bin
