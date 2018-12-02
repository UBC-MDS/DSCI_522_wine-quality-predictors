# DSCI 522 Project: Wine Quality Predictors

### Team Members
- Reza Bagheri (github ID: reza-bagheri)
- Luo Yang (github ID: lyiris22)

### Summary

In this project, we used the [Wine Quality Data Set](https://archive.ics.uci.edu/ml/datasets/Wine+Quality) to explore the effect of different parameters on wine quality. The main method we used is the decision tree from [scikit-learn](https://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html) to rank the importance of parameters, separately for red wine and white wine. We wrote R scripts to clean the data and make visualizations, and a Python script to generate decision tree.

Among the 11 features of wine, our result shows that *sulphates*, *alcohol*, and *volatile acidity* are the three top predictors to red wine quality respectively. For white wine, the three top predictors are *alcohol*, *free sulfur dioxide*, and	*volatile acidity*. Our final report include the details of analysis and how we came to the final conclusion.

### File Structure

`data/` folder contains csv files used for analysis, include raw data, clean data of two different patterns, for both red wine and red wine.

`doc/` folder contains final report file and original proposal draft.

`results/` folder contains exploratory bar plots and violin plots from data, and files related to decision tree used in the final report.

`src/` folder contains R and Python scripts for loading and cleaning data, plot graphs, and drawing decision trees.

In the root folder, `README.md` is an introduction to the project. `run_all.sh` is a draft of shell script that runs all the scripts to generate data and graphs.
And `Makefile` is used to build pipeline.

### Data Analysis

First, we used [load_write_raw_data.R](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/src/load_write_raw_data.R) to load the [Wine Quality Data Set](https://archive.ics.uci.edu/ml/datasets/Wine+Quality) from URL. The arguments it takes include a URL and a name for output file. The output file is a raw data csv file.
- Example usage: `Rscript src/load_write_raw_data.R 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'`

Secondly, we used [load_clean_3_targets.R](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/src/load_clean_3_targets.R) and [load_clean_4_targets.R](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/src/load_clean_4_targets.R) to re-organize the quality labels. The `load_clean_4_targets.R` combined the quality into "low", "med_low", "med_high" and "high", while the `load_clean_3_targets.R` combined into "low", "med", and "high". We have these two scripts because we need to check which method is a better way to balance the data and fit a decision tree. The arguments both scripts take include a input file of raw data, and a name for output file. The output is clean data csv file.
- Example usage: `Rscript src/load_clean_4_targets.R data/raw_red.csv data/clean_red_4_targets.csv`

Then, we used [plot_hist.R](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/src/plot_hist.R) to create visulizations for the clean data. We create bar plots that shows the distributions of different wine qualities. The script takes three arguments: input file name, output file name, and a keyword ("raw" for raw data, "3" for 3-target clean data, and "4" for 4-target clean data) that indicates which kind of data is in the input. The output is a bar plot png file.
- Example usage: `Rscript src/plot_hist.R data/raw_red.csv results/hist_raw_red.png raw`

We also used [plot_violin.R](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/src/plot_violin.R) to create violin plots for each feature that affects wine quality. The script also takes three arguments: input file name, output file name, and a keyword ("raw" for raw data, "3" for 3-target clean data, and "4" for 4-target clean data) that indicates which kind of data is in the input. The output is a violin plot png file.
- Example usage: `Rscript src/plot_violin.R data/clean_red_3_targets.csv results/violin_red.png 3`

After that, we used [draw_tree.py](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/src/draw_tree.py) to generate decision trees for the data sets. It takes two keywords, first one indicates the type of input, and second one indicates whether we use balanced method for the decision tree. For output, beside images and csv files, a text file that contains the information of decision tree is also produced as an reference.
- Input: data file, file names for outputs, input type keyword ("3" for 3-target clean data, and "4" for 4-target clean data), balanced keyword ("true" for using balance method, "false" for not using)
- Output: a png file for decision tree, a text file contains information of decision tree, a csv file containing the importance of each feature in this decision tree, also adding one record to the `tree_score.csv` file that shows the cross-validation score for this decision tree.
- Example usage: `Python src/draw_tree.py data/clean_red_4_targets.csv results/tree_red_4 results/tree_scores.csv results/red_4_imp.csv 4 false`

Finally, we summarized our results and made a rendered report [Report.md](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/doc/Report.md) in `doc` folder.

For the pipeline, we have an shell script [run_all.sh](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/run_all.sh) for reference. We also have a [Makefile](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/Makefile) in the root folder. The `make all` command can run all the scripts, generate graphs and csv files, and render the final report.

### Dependencies

- R packages:
  - dplyr (0.7.6)
  - tidyverse (1.2.1)
  - cowplot (0.9.3)

- Python packages:
  - numpy (1.14.3)
  - pandas (0.23.0)
  - sklearn (0.19.1)
  - graphviz (0.10.1)
  - argparse (1.1)
