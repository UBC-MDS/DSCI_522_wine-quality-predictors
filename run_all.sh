# run_all.#!/bin/sh
# Milestone 1

# some description

# example usage
# bash run_all.sh

# load and write the raw data
Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv' data/raw_red.csv
Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv' data/raw_white.csv

# clean the raw data
Rscript src/load_clean_data.R data/raw_red.csv data/clean_red.csv
Rscript src/load_clean_data.R data/raw_white.csv data/clean_white.csv

# create violin plots for the features
Rscript src/plot_violin.R data/clean_red.csv results/violin_red.png
Rscript src/plot_violin.R data/clean_white.csv results/violin_white.png

# create histograms for raw and clean data sets
Rscript src/plot_hist.R data/raw_red.csv data/raw_white.csv data/clean_red.csv data/clean_white.csv results/hist_raw_red.png results/hist_raw_white.png results/hist_clean_red.png results/hist_clean_white.png

# create decision trees
Python src/draw_tree.py data/clean_red.csv results/tree_red
Python src/draw_tree.py data/clean_white.csv results/tree_white
