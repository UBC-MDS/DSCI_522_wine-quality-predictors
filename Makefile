# Makefile
# Created by Iris

# run all and render the final report
all : doc/Report.md

# load raw data from URL and write to csv file
data/raw_red.csv : src/load_write_raw_data.R
	Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv' data/raw_red.csv
data/raw_white.csv : src/load_write_raw_data.R
	Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv' data/raw_white.csv

# clean the raw data, divide the quality into 4 targets: low, med_low, med_high, high
# this is used for comparison
data/clean_red_4_targets.csv : src/load_clean_4_targets.R data/raw_red.csv
	Rscript src/load_clean_4_targets.R data/raw_red.csv data/clean_red_4_targets.csv
data/clean_white_4_targets.csv : src/load_clean_4_targets.R data/raw_white.csv
	Rscript src/load_clean_4_targets.R data/raw_white.csv data/clean_white_4_targets.csv

# clean the raw data , divide the quality into 3 targets: low, med, high
# this is used for final result
data/clean_red_3_targets.csv : src/load_clean_3_targets.R data/raw_red.csv
	Rscript src/load_clean_3_targets.R data/raw_red.csv data/clean_red_3_targets.csv
data/clean_white_3_targets.csv : src/load_clean_3_targets.R data/raw_white.csv
	Rscript src/load_clean_3_targets.R data/raw_white.csv data/clean_white_3_targets.csv

# create violin plots for the 3 targets data
results/violin_red.png : src/plot_violin.R data/clean_red_3_targets.csv
	Rscript src/plot_violin.R data/clean_red_3_targets.csv results/violin_red.png 3
results/violin_white.png : src/plot_violin.R data/clean_white_3_targets.csv
	Rscript src/plot_violin.R data/clean_white_3_targets.csv results/violin_white.png 3

# create violin plots for the 4 targets data
results/old_violin_red.png : src/plot_violin.R data/clean_red_4_targets.csv
	Rscript src/plot_violin.R data/clean_red_4_targets.csv results/old_violin_red.png 4
results/old_violin_white.png : src/plot_violin.R data/clean_white_4_targets.csv
	Rscript src/plot_violin.R data/clean_white_4_targets.csv results/old_violin_white.png 4

# create bar plots for raw and clean data sets
results/hist_raw_red.png : src/plot_hist.R data/raw_red.csv
	Rscript src/plot_hist.R data/raw_red.csv results/hist_raw_red.png raw
results/hist_raw_white.png : src/plot_hist.R data/raw_white.csv
	Rscript src/plot_hist.R data/raw_white.csv results/hist_raw_white.png raw
results/old_hist_clean_red.png : src/plot_hist.R data/clean_red_4_targets.csv
	Rscript src/plot_hist.R data/clean_red_4_targets.csv results/old_hist_clean_red.png 4
results/old_hist_clean_white.png : src/plot_hist.R data/clean_white_4_targets.csv
	Rscript src/plot_hist.R data/clean_white_4_targets.csv results/old_hist_clean_white.png 4
results/hist_clean_red.png : src/plot_hist.R data/clean_red_3_targets.csv
	Rscript src/plot_hist.R data/clean_red_3_targets.csv results/hist_clean_red.png 3
results/hist_clean_white.png : src/plot_hist.R data/clean_white_3_targets.csv
	Rscript src/plot_hist.R data/clean_white_3_targets.csv results/hist_clean_white.png 3

# create decision trees for the 4 targets data

# red wine, imbalanced
results/tree_red_4.png results/tree_scores.csv results/red_4_imp.csv : src/draw_tree.py data/clean_red_4_targets.csv
	python src/draw_tree.py data/clean_red_4_targets.csv results/tree_red_4 results/tree_scores.csv results/red_4_imp.csv 4 false
# red wine, balanced
results/tree_red_4_bal.png results/red_4_bal_imp.csv : src/draw_tree.py data/clean_red_4_targets.csv
	python src/draw_tree.py data/clean_red_4_targets.csv results/tree_red_4_bal results/tree_scores.csv results/red_4_bal_imp.csv 4 true
# white wine, imbalanced
results/tree_white_4.png results/white_4_imp.csv : src/draw_tree.py data/clean_white_4_targets.csv
	python src/draw_tree.py data/clean_white_4_targets.csv results/tree_white_4 results/tree_scores.csv results/white_4_imp.csv 4 false
# white wine, balanced
results/tree_white_4_bal.png results/white_4_bal_imp.csv : src/draw_tree.py data/clean_white_4_targets.csv
	python src/draw_tree.py data/clean_white_4_targets.csv results/tree_white_4_bal results/tree_scores.csv results/white_4_bal_imp.csv 4 true

# create decision trees for the 3 targets data

# red wine, imbalanced
results/tree_red_3.png results/red_3_imp.csv : src/draw_tree.py data/clean_red_3_targets.csv
	python src/draw_tree.py data/clean_red_3_targets.csv results/tree_red_3 results/tree_scores.csv results/red_3_imp.csv 3 false
# red wine, balanced
results/tree_red_3_bal.png results/red_3_bal_imp.csv : src/draw_tree.py data/clean_red_3_targets.csv
	python src/draw_tree.py data/clean_red_3_targets.csv results/tree_red_3_bal results/tree_scores.csv results/red_3_bal_imp.csv 3 true
# white wine, imbalanced
results/tree_white_3.png results/white_3_imp.csv : src/draw_tree.py data/clean_white_3_targets.csv
	python src/draw_tree.py data/clean_white_3_targets.csv results/tree_white_3 results/tree_scores.csv results/white_3_imp.csv 3 false
# white wine, balanced
results/tree_white_3_bal.png results/white_3_bal_imp.csv : src/draw_tree.py data/clean_white_3_targets.csv
	python src/draw_tree.py data/clean_white_3_targets.csv results/tree_white_3_bal results/tree_scores.csv results/white_3_bal_imp.csv 3 true

# make final report
doc/Report.md : results/violin_red.png results/violin_white.png results/old_violin_red.png results/old_violin_white.png results/hist_raw_red.png results/hist_raw_white.png results/old_hist_clean_red.png results/old_hist_clean_white.png results/hist_clean_red.png results/hist_clean_white.png results/tree_red_4.png results/tree_red_4_bal.png results/tree_white_4.png results/tree_white_4_bal.png results/tree_red_3.png results/tree_red_3_bal.png results/tree_white_3.png results/tree_white_3_bal.png
	Rscript -e "rmarkdown::render('doc/Report.Rmd')"

# clean the outputs
clean :
	rm -f data/raw_red.csv
	rm -f data/raw_white.csv
	rm -f data/clean_red_4_targets.csv
	rm -f data/clean_white_4_targets.csv
	rm -f data/clean_red_3_targets.csv
	rm -f data/clean_white_3_targets.csv
	rm -f results/violin_red.png
	rm -f results/violin_white.png
	rm -f results/old_violin_red.png
	rm -f results/old_violin_white.png
	rm -f results/hist_raw_red.png
	rm -f results/hist_raw_white.png
	rm -f results/old_hist_clean_red.png
	rm -f results/old_hist_clean_white.png
	rm -f results/hist_clean_red.png
	rm -f results/hist_clean_white.png
	rm -f results/tree_red_4.png
	rm -f results/red_4_imp.csv
	rm -f results/tree_red_4_bal.png
	rm -f results/red_4_bal_imp.csv
	rm -f results/tree_white_4.png
	rm -f results/white_4_imp.csv
	rm -f results/tree_white_4_bal.png
	rm -f results/white_4_bal_imp.csv
	rm -f results/tree_red_3.png
	rm -f results/red_3_imp.csv
	rm -f results/tree_red_3_bal.png
	rm -f results/red_3_bal_imp.csv
	rm -f results/tree_white_3.png
	rm -f results/white_3_imp.csv
	rm -f results/tree_white_3_bal.png
	rm -f results/white_3_bal_imp.csv
	rm -f results/tree_red_3
	rm -f results/tree_red_3_bal
	rm -f results/tree_red_4
	rm -f results/tree_red_4_bal
	rm -f results/tree_white_3
	rm -f results/tree_white_3_bal
	rm -f results/tree_white_4
	rm -f results/tree_white_4_bal
	rm -f results/tree_scores.csv
	rm -f Rplots.pdf
	rm -f doc/Report.md
