#! /usr/bin/env Rscript 
# plot_hist.R
# Created by Iris
#
# This script make bar plots for raw or clean wine data sets.
# It takes input for raw and clean data sets for both red and white wine.
# The result will be save in four separate png files.
#
# Usage: Rscript plot_hist.R raw_red raw_white clean_red clean_white out_raw_red out_raw_white out_clean_red out_clean_white

# load libraries
library(tidyverse)

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
raw_red <- args[1]
raw_white <- args[2]
clean_red <- args[3]
clean_white <- args[4]
out_raw_red <- args[5]
out_raw_white <- args[6]
out_clean_red <- args[7]
out_clean_white <- args[8]

# main function
main <- function(){
  # plot four bar plots
  plot_raw(raw_red, "Red Wine Raw Data", out_raw_red)
  plot_raw(raw_white, "White Wine Raw Data", out_raw_white)
  plot_clean(clean_red, "Red Wine Clean Data", out_clean_red)
  plot_clean(clean_white, "White Wine Clean Data", out_clean_white)
}

# plot bar plots for raw data
plot_raw <- function(data, title, output){
  raw_data <- read.csv(data)
  raw_graph <- raw_data %>% 
    mutate(quality = factor(quality)) %>% 
    ggplot(aes(quality)) +
    geom_bar() +
    labs(x = "Quality", y = "Observations",
         title = title)
  ggsave(output, width = 4, height = 6, plot = raw_graph)
}

# plot bar plots for clean data
plot_clean <- function(data, title, output){
  clean_data <- read.csv(data)
  clean_graph <- clean_data %>% 
    mutate(target = factor(target)) %>% 
    mutate(target = fct_relevel(target, "low", "med", "high")) %>% 
    ggplot(aes(target)) +
    geom_bar() +
    labs(x = "Target", y = "Observations",
         title = title)
  ggsave(output, width = 4, height = 6, plot = clean_graph)
}

# call main function
main()