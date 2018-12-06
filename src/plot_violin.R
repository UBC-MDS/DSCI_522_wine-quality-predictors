#! /usr/bin/env Rscript 
# plot_violin.R
# Created by Iris
#
# This script plot violin and jitter for each of the features and target
# for red or white wine datasets. The result will be save in one graph.
# The code for plotting refers to lab1 of DSCI 571.
#
# Example usage: Rscript plot_violin.R input_file output_file 3

# load libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(cowplot))

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]  # input csv file
output_file <- args[2] # output png file
target_num <- args[3] # "3" for 3-target data, "4" for 4-target data

# The main function
main <- function(){

  # read csv file
  wine_data <- read.csv(input_file)
  
  # give the target level order
  if (target_num == "3") {
    # reorder factor for 3-target data
    wine_data <- wine_data %>% 
      mutate(target = factor(target)) %>% 
      mutate(target = fct_relevel(target, "low", "med", "high"))
  } else if (target_num == "4") {
    # reorder factor for 4-target data
    wine_data <- wine_data %>% 
      mutate(target = factor(target)) %>% 
      mutate(target = fct_relevel(target, "low", "med_low", "med_high", "high"))
  }
  
  # fixed acidity
  plot_fixed_acidity <- wine_data %>% 
      group_by(target) %>% 
      summarise(mean = mean(fixed.acidity),
                n = length(fixed.acidity),
                se = sd(fixed.acidity) / sqrt(n)) %>% 
      ggplot(aes(x = target)) + 
      geom_violin(data = wine_data,
                mapping = aes(x = target, y = fixed.acidity)) + 
      geom_point(aes(y = mean), color = "red", size = 1) +
      geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                        ymax = mean + qnorm(0.025)*se),
                    color = "blue",
                    width = 0.2) +
      geom_jitter(data = wine_data,
                mapping = aes(x = target, y = fixed.acidity),
                alpha = 0.1, 
                size = 0.5) +
      labs(x = "Wine Quality", y = "Fixed Acidity")
  
  # volatile acidity
  plot_volatile_acidity <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(volatile.acidity),
              n = length(volatile.acidity),
              se = sd(volatile.acidity) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = volatile.acidity)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = volatile.acidity),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Volatile Acidity")
  
  # citric acid
  plot_citric_acid <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(citric.acid),
              n = length(citric.acid),
              se = sd(citric.acid) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = citric.acid)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = citric.acid),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Citric Acid")
  
  # residual sugar
  plot_residual_sugar <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(residual.sugar),
              n = length(residual.sugar),
              se = sd(residual.sugar) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = residual.sugar)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = residual.sugar),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Residual Sugar")
  
  # chlorides
  plot_chlorides <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(chlorides),
              n = length(chlorides),
              se = sd(chlorides) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = chlorides)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = chlorides),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Chlorides")
  
  # free sulfur dioxide
  plot_free_sulfur <- wine_data %>% 
      group_by(target) %>% 
      summarise(mean = mean(free.sulfur.dioxide),
                n = length(free.sulfur.dioxide),
                se = sd(free.sulfur.dioxide) / sqrt(n)) %>% 
      ggplot(aes(x = target)) + 
      geom_violin(data = wine_data,
                  mapping = aes(x = target, y = free.sulfur.dioxide)) + 
      geom_point(aes(y = mean), color = "red", size = 1) +
      geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                        ymax = mean + qnorm(0.025)*se),
                    color = "blue",
                    width = 0.2) +
      geom_jitter(data = wine_data,
                  mapping = aes(x = target, y = free.sulfur.dioxide),
                  alpha = 0.1, 
                  size = 0.5) +
    labs(x = "Wine Quality", y = "Free sulfur dioxide")
  
  # total sulfur dioxide
  plot_total_sulfur <- wine_data %>% 
      group_by(target) %>% 
      summarise(mean = mean(total.sulfur.dioxide),
                n = length(total.sulfur.dioxide),
                se = sd(total.sulfur.dioxide) / sqrt(n)) %>% 
      ggplot(aes(x = target)) + 
      geom_violin(data = wine_data,
                  mapping = aes(x = target, y = total.sulfur.dioxide)) + 
      geom_point(aes(y = mean), color = "red", size = 1) +
      geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                        ymax = mean + qnorm(0.025)*se),
                    color = "blue",
                    width = 0.2) +
      geom_jitter(data = wine_data,
                  mapping = aes(x = target, y = total.sulfur.dioxide),
                  alpha = 0.1, 
                  size = 0.5) +
    labs(x = "Wine Quality", y = "Total sulfur dioxide")
  
  # density
  plot_density <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(density),
              n = length(density),
              se = sd(density) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = density)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = density),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Density")
  
  # pH
  plot_ph <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(pH),
              n = length(pH),
              se = sd(pH) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = pH)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = pH),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "pH value")
  
  # sulphates
  plot_sulphates <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(sulphates),
              n = length(sulphates),
              se = sd(sulphates) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = sulphates)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = sulphates),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Sulphates")
  
  # alcohol
  plot_alcohol <- wine_data %>% 
    group_by(target) %>% 
    summarise(mean = mean(alcohol),
              n = length(alcohol),
              se = sd(alcohol) / sqrt(n)) %>% 
    ggplot(aes(x = target)) + 
    geom_violin(data = wine_data,
                mapping = aes(x = target, y = alcohol)) + 
    geom_point(aes(y = mean), color = "red", size = 1) +
    geom_errorbar(aes(ymin = mean - qnorm(0.025)*se,
                      ymax = mean + qnorm(0.025)*se),
                  color = "blue",
                  width = 0.2) +
    geom_jitter(data = wine_data,
                mapping = aes(x = target, y = alcohol),
                alpha = 0.1, 
                size = 0.5) +
    labs(x = "Wine Quality", y = "Alcohol")
  
  # put all the graphs together
  final_plot <- plot_grid(
    plot_fixed_acidity, plot_volatile_acidity, plot_citric_acid,
    plot_residual_sugar, plot_chlorides, plot_free_sulfur,
    plot_total_sulfur, plot_density, plot_ph, plot_sulphates,
    plot_alcohol, ncol = 2, align = 'v')
  
  # save the graph
  ggsave(output_file, width = 10, height = 20, plot = final_plot)
}

# Call main function
main()