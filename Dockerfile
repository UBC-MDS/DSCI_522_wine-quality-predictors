# Docker file for Wine Quality Predictors
# Created by Iris
# Code references:
# DSCI 522 lecture 7, https://github.ubc.ca/MDS-2018-19/DSCI_522_dsci-workflows_students/blob/master/lectures/07_lecture_writing_dockerfiles.ipynb
# https://github.com/Kaggle/docker-python/blob/master/Dockerfile

# use rocker/tidyverse as the base image
FROM rocker/tidyverse

# install the cowplot package
#RUN apt-get update -qq && apt-get -y --no-install-recommends install \
#  && install2.r --error \
#    --deps TRUE \
#    cowplot

RUN install2.r --error \
  cowplot

# install python3
#RUN sudo apt-get update
#RUN sudo apt-get install python3

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
