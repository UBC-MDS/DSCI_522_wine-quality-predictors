# run_all.#!/bin/sh
# Created by Iris

# This is the draft of shell script for generating the analysis

# example usage
# bash run_all.sh

# load and write the raw data
Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv' data/raw_red.csv
Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv' data/raw_white.csv

# clean the raw data to divide quality into low, med_low, med_high, high
Rscript src/load_clean_4_targets.R data/raw_red.csv data/clean_red_4_targets.csv
Rscript src/load_clean_4_targets.R data/raw_white.csv data/clean_white_4_targets.csv

# clean the raw data to divide quality into low, med, high
Rscript src/load_clean_3_targets.R data/raw_red.csv data/clean_red_3_targets.csv
Rscript src/load_clean_3_targets.R data/raw_white.csv data/clean_white_3_targets.csv

# create violin plots for the 3 targets data
Rscript src/plot_violin.R data/clean_red_3_targets.csv results/violin_red.png
Rscript src/plot_violin.R data/clean_white_3_targets.csv results/violin_white.png

# create histograms for raw and clean data sets
Rscript src/plot_hist.R data/raw_red.csv data/raw_white.csv data/clean_red_3_targets.csv data/clean_white_3_targets.csv results/hist_raw_red.png results/hist_raw_white.png results/hist_clean_red.png results/hist_clean_white.png

# create decision trees for the 4 targets data
Python src/draw_tree.py data/clean_red_4_targets.csv results/tree_red_4 results/tree_scores.csv results/red_4_imp.csv 4 false
Python src/draw_tree.py data/clean_red_4_targets.csv results/tree_red_4_bal results/tree_scores.csv results/red_4_bal_imp.csv 4 true
Python src/draw_tree.py data/clean_white_4_targets.csv results/tree_white_4 results/tree_scores.csv results/white_4_imp.csv 4 false
Python src/draw_tree.py data/clean_white_4_targets.csv results/tree_white_4_bal results/tree_scores.csv results/white_4_bal_imp.csv 4 true

# create decision trees for the 3 targets data
Python src/draw_tree.py data/clean_red_3_targets.csv results/tree_red_3 results/tree_scores.csv results/red_3_imp.csv 3 false
Python src/draw_tree.py data/clean_red_3_targets.csv results/tree_red_3_bal results/tree_scores.csv results/red_3_bal_imp.csv 3 true
Python src/draw_tree.py data/clean_white_3_targets.csv results/tree_white_3 results/tree_scores.csv results/white_3_imp.csv 3 false
Python src/draw_tree.py data/clean_white_3_targets.csv results/tree_white_3_bal results/tree_scores.csv results/white_3_bal_imp.csv 3 true

# make final report
Rscript -e "rmarkdown::render('doc/Report.Rmd')"
