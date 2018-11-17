# R script for loading wine data from URL

# read the data of red wine from URL
red_wine <- read.delim('https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv', 
                   sep = ";")
# print the head of red wine data for reference
head(red_wine)

# read the data of white wine from URL
white_wine <- read.delim('https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv', 
                         sep = ";")
# print the head of white wine data for reference
head(white_wine)
