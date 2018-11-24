# R script for loading wine data from URL
library(dplyr)


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
  # The wine qualitis of 5 and 6 will be named "med"
  # The wine qualitis of 7 or higher will be named "high"
  
  data <- data %>% mutate(target="med")
  data <- data %>%  mutate(target = ifelse(quality %in% c(3,4), "low", target))
  data <- data %>%  mutate(target = ifelse(quality >= 7, "high", target))
  
  
  # Save the output csv file
  write.csv(data, file=output_file, row.names=FALSE)
  
}

# The main function
main()
