# R script for loading wine data from URL
library(tidyverse)


# Checking if there is any NA elements in the data sets 
#red_wine %>% filter(row.has.na)
#red_wine[rowSums(is.na(red_wine)) > 0,]
#white_wine[rowSums(is.na(white_wine)) > 0,]


# Reading the command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

# The main function
main <- function(){
  
  # read the dataset
  data <- read.csv(input_file)
  
  #  Combining and categorizing the wine quality to remove the imbalance
  
  # Red wine dataset:
  # The wine qualitis of 3 and 4 will be named "low"
  # The wine qualitis of 5 will be named "med_low"
  # The wine qualitis of 6 will be named "med_high"
  # The wine qualitis of 7 or higher will be named "high"
  
  data <- data %>% mutate(target="med_low")
  data <- data %>%  mutate(target = ifelse(quality == 6, "med_high", target))
  data <- data %>%  mutate(target = ifelse(quality %in% c(3,4), "low", target))
  data <- data %>%  mutate(target = ifelse(quality >= 7, "high", target))
  
  # give the target level order
  data <- data %>% 
    mutate(target = factor(target)) %>% 
    mutate(target = fct_relevel(target, "low", "med_low","med_high", "high"))
  
  # Save the output csv file
  write.csv(data, file=output_file, row.names=FALSE)
  
}

# The main function
main()
