#!/usr/bin/env python

# This script takes the clean red or wine data
# And produces the decision tree of predicting wine quality

# import packages
import pandas as pd
from sklearn import tree
import graphviz
import argparse

# read in command line args
parser = argparse.ArgumentParser()
parser.add_argument('input_file')
parser.add_argument('output_file')
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
    quality = ['low','med_low','med_high','high']

    # get the features for X and y
    X = wine_data.loc[:, features]
    y = wine_data.target

    # fit the model
    wine_tree = tree.DecisionTreeClassifier(max_depth = 3)
    wine_tree.fit(X, y)
    tree_data = tree.export_graphviz(wine_tree, out_file=None,
                                    feature_names = features,
                                    class_names = quality,
                                    filled=True, rounded=True)
    # draw the tree
    graphviz.Source(tree_data, format = "png").render(args.output_file)

# call main function
if __name__ == "__main__":
    main()
