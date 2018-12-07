# DSCI 522 Project: Wine Quality Predictors

## Team Members
- Reza Bagheri (github ID: reza-bagheri)
- Luo Yang (github ID: lyiris22)

## Summary

In this project, we tried to answer the question: **what are the top three predictors for wine quality?**

We used the [Wine Quality Data Set](https://archive.ics.uci.edu/ml/datasets/Wine+Quality) [1] from UCI Machine Learning Repository [2] to explore the effect of different parameters on both red and white wine quality. The main method we used is the decision tree from [scikit-learn](https://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html) to rank the importance of parameters, separately for red wine and white wine. We wrote R scripts to clean the data and make visualizations, and a Python script to generate decision tree.

Among the 11 features, our result shows that for red wine,  *sulphates*, *alcohol*, and *volatile acidity* are the three top predictors respectively. For white wine, the three top predictors are *alcohol*, *free sulfur dioxide*, and	*volatile acidity*.

Our report include the details of analysis and how we came to the final conclusion.

## File Structure

`data/` folder contains csv files used for analysis, include raw data, clean data of two different patterns, for both red wine and red wine.

`doc/` folder contains final report file and original proposal draft.

`results/` folder contains exploratory bar plots and violin plots from data, and files related to decision tree used in the final report.

`src/` folder contains R and Python scripts for loading and cleaning data, plot graphs, and drawing decision trees.

In the root folder, `README.md` is an introduction to the project. `run_all.sh` is a draft of shell script that runs all the scripts to generate data and graphs.
And `Makefile` is used to build pipeline.

## Data Analysis

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

[Makefile.png](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/Makefile.png), generated by makefile2graph, is a dependency diagram of our data analysis project.

For the pipeline, we have an shell script [run_all.sh](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/run_all.sh) for reference. We also have a [Makefile](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/Makefile) in the root folder. The `make all` command can run all the scripts, generate graphs and csv files, and render the final report.

In addition, we have a [Dockerfile](https://github.com/UBC-MDS/DSCI_522_wine-quality-predictors/blob/master/Dockerfile) which was used to generate the docker image for the project. The build of Dockerfile is based on [rocker](https://hub.docker.com/r/rocker/tidyverse/) and [makefile2graph](https://hub.docker.com/r/ttimbers/makefile2graph/).  

## Usage

The project can be reproduced with Make or using Docker. You can clone or download the project repository, navigate to the root folder, then run the example code provided below.

#### Make

- To generate the data analysis:
> `make all`

- To clean up the generated files:
> `make clean`

#### Docker

- To get the [docker image](https://hub.docker.com/r/luoyang2/dsci_522_wine-quality-predictors/) for this project:
> `docker pull luoyang2/dsci_522_wine-quality-predictors`

- To generate the data anlysis:
> `docker run --rm -v PATH_ON_YOUR_COMPUTER:/home/wine_quality_image luoyang2/dsci_522_wine-quality-predictors make -C '/home/wine_quality_image' all`

- To clean up the generated files:
> `docker run --rm -v PATH_ON_YOUR_COMPUTER:/home/wine_quality_image luoyang2/dsci_522_wine-quality-predictors make -C '/home/wine_quality_image' clean`

Note that you need to replace the `PATH_ON_YOUR_COMPUTER` with the absolute path to the root of this repository on your local computer. You can use `pwd` to find the current path.

## Dependencies

- R (version 3.5.1) packages:
  - dplyr (0.7.6)
  - tidyverse (1.2.1)
  - cowplot (0.9.3)

- Python (version 3.6.5) packages:
  - numpy (1.14.3)
  - pandas (0.23.0)
  - sklearn (0.19.1)
  - graphviz (0.10.1)
  - argparse (1.1)

- Make (version 3.81)

## References

- [1] P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis. Modeling wine preferences by data mining from physicochemical properties. In Decision Support Systems, Elsevier, 47(4):547-553, 2009.
- [2] Dua, D. and Karra Taniskidou, E. (2017). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science.
