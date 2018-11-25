#!/usr/bin/env python
# Created by Iris
#
# This script takes the clean red or white data
# Produces the decision tree of predicting wine quality
# Produces an csv file for the importance rank of the features
# Do analysis for 4 target clean data when target_num = 4
# And do for 3 target clean data when target_num = 3
# Use a balanced method when "balanced" set to "true"
# Use a imbalance method when "balanced" set to "false"

# example usage
# Python draw_tree.py input_file output_file output_result 3 true

# import packages
import pandas as pd
import numpy as np
from sklearn import tree
from sklearn.model_selection import cross_val_score
import graphviz
import argparse

# read in command line args
parser = argparse.ArgumentParser()
parser.add_argument('input_file')
parser.add_argument('output_file')  # a png file, with no suffix
parser.add_argument('output_result') # the csv file for tree cross val score
parser.add_argument('output_importance') # a csv file for feature importance
parser.add_argument('target_num') # 3 or 4
parser.add_argument('balanced') # true or false
args = parser.parse_args()

# main function
def main():
    # load data
    wine_data = pd.read_csv(args.input_file)

    # print the decision tree
    get_tree(wine_data)


# get the decision tree
def get_tree(wine_data):
    # generates and draw a decision tree

    # get the column names
    features = ["fixed.acidity", "volatile.acidity", "citric.acid", "residual.sugar", "chlorides",
               "free.sulfur.dioxide", "total.sulfur.dioxide", "density", "pH", "sulphates", "alcohol"]

    if args.target_num == "4":
        quality = ['low','med_low','med_high','high']
    elif args.target_num == "3" :
        quality = ['low', 'med', 'high']

    # get the features for X and y
    X = wine_data.loc[:, features]
    y = wine_data.target

    # fit the model
    if args.balanced == "true":
        wine_tree = tree.DecisionTreeClassifier(max_depth = 3, class_weight = "balanced")
    elif args.balanced == "false":
        wine_tree = tree.DecisionTreeClassifier(max_depth = 3)

    wine_tree.fit(X, y)
    tree_data = tree.export_graphviz(wine_tree, out_file=None,
                                    feature_names = features,
                                    class_names = quality,
                                    filled=True, rounded=True)
    # draw the tree
    graphviz.Source(tree_data, format = "png").render(args.output_file)

    # calculate the cross validation score
    scores = pd.DataFrame({'data_name': [args.input_file]})
    scores['balanced'] = [args.balanced]
    scores['cross_var_score'] = [np.mean(cross_val_score(wine_tree, X, y, cv = 10))]

    # write feature scores to an individual csv
    feature_imp = pd.DataFrame({'feature': features})
    feature_imp['importance'] = wine_tree.feature_importances_.tolist()
    feature_imp = feature_imp.sort_values(by = ['importance'], ascending = False)
    feature_imp.to_csv(args.output_importance)


    # add the scores to one result csv
    with open(args.output_result, 'a') as f:
        scores.to_csv(f, index = False, header = False)

# call main function
if __name__ == "__main__":
    main()
