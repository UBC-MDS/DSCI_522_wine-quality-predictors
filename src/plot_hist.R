#! /usr/bin/env Rscript 
# plot_hist.R
# Created by Iris
#
# This script make bar plots for raw or clean wine data sets.
# It takes input for raw and clean data sets for both red and white wine.
# The result will be save in four separate png files.
# Reference: https://stackoverflow.com/questions/12018499/
#
# Example usage: Rscript plot_hist.R input_file output_file raw

# load libraries
suppressPackageStartupMessages(library(tidyverse))

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]  # input csv file name
output_file <- args[2]  # output png file name
df_type <- args[3]  # "raw" if input is raw, "3" if 3-target, "4" if 4-target

# main function: plot the bar plot
main <- function(){
  # read csv file
  wine_data <- read.csv(input_file)
  
  # distinguish between data types
  if (df_type == "raw") {
    plot_raw(wine_data, output_file)
  } else if (df_type == "3") {
    # reorder the levels
    wine_data <- wine_data %>% 
      mutate(target = factor(target)) %>% 
      mutate(target = fct_relevel(target, "low", "med", "high"))
    plot_clean(wine_data, output_file)
  } else if (df_type == "4"){
    # reorder the levels
    wine_data <- wine_data %>% 
      mutate(target = factor(target)) %>% 
      mutate(target = fct_relevel(target, "low", "med_low", "med_high", "high"))
    plot_clean(wine_data, output_file)
  }
}

# plot bar plots for raw data
plot_raw <- function(data, output){
  raw_graph <- data %>% 
    mutate(quality = factor(quality)) %>% 
    # add count to bars
    group_by(quality) %>% 
    summarise(n = n()) %>% 
    ggplot(aes(x = quality, y = n)) +
    geom_bar(stat='identity') +
    geom_text(aes(label = n), position = position_dodge(width=0.2), 
              vjust=-0.1, color = "orange") +
    labs(x = "Quality", y = "Observations")
  ggsave(output, width = 4, height = 3, plot = raw_graph)
}

# plot bar plots for clean data
plot_clean <- function(data, output){
  clean_graph <- data %>% 
    # add count to bars
    group_by(target) %>% 
    summarise(n = n()) %>% 
    ggplot(aes(x = target, y = n)) +
    geom_bar(stat='identity') +
    geom_text(aes(label = n), position = position_dodge(width=0.2), 
              vjust=-0.1, color = "orange") +
    labs(x = "Target", y = "Observations")
  ggsave(output, width = 4, height = 3, plot = clean_graph)
}

# call main function
main()