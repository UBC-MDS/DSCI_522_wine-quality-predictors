# R script for loading wine data from URL
library(dplyr)
# read the data of red wine from URL
red_wine <- read.delim('https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv', 
                   sep = ";")
# print the head of red wine data for reference
head(red_wine)

# read the data of white wine from URL
white_wine <- read.delim('https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv', 
                         sep = ";")

# Checking if there is any NA elements in the data sets 
red_wine %>% filter(row.has.na)
red_wine[rowSums(is.na(red_wine)) > 0,]
white_wine[rowSums(is.na(white_wine)) > 0,]

#  Combining and categorizing the wine quality to remove the imbalance

# Red wine dataset:
# The wine qualitis of 3 and 4 will be named "low"
# The wine qualitis of 5 will be named "medium_low"
# The wine qualitis of 6 will be named "medium_high"
# The wine qualitis of 7 and 8 will be named "high"

red_wine1 <- red_wine %>% mutate(target="medium_low")
red_wine1 <- red_wine1 %>%  mutate(target = ifelse(quality == 6, "meduim_high", target))
red_wine1 <- red_wine1 %>%  mutate(target = ifelse(quality %in% c(3,4), "low", target))
red_wine1 <- red_wine1 %>%  mutate(target = ifelse(quality %in% c(7,8), "high", target))


# Whitewine dataset:
# The wine qualitis of 3 and 4 will be named "low"
# The wine qualitis of 5 will be named "medium_low"
# The wine qualitis of 6 will be named "medium_high"
# The wine qualitis of 7, 8 and 9 will be named "high"

white_wine1 <- white_wine %>% mutate(target="medium_low")
white_wine1 <- white_wine1 %>%  mutate(target = ifelse(quality == 6, "meduim_high", target))
white_wine1 <- white_wine1 %>%  mutate(target = ifelse(quality %in% c(3,4), "low", target))
white_wine1 <- white_wine1 %>%  mutate(target = ifelse(quality %in% c(7,8, 9), "high", target))
                                   


