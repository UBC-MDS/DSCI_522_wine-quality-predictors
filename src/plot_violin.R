#! /usr/bin/env Rscript 
# plot_violin.R
#
# This script plot violin and jitter for each of the features and target
# for red or white wine datasets. The result will be save in one graph.
#
# Usage: Rscript plot_violin.R inputfile outputfile

# load libraries
library(tidyverse)
library(cowplot)

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

# read csv file
wine_data <- read.csv(input_file)

# give the target level order
wine_data <- wine_data %>% 
  mutate(target = factor(target)) %>% 
  mutate(target = fct_relevel(target, "low", "med_low","med_high", "high"))

# fixed acidity
plot_fixed_acidity <- wine_data %>% 
  ggplot(aes(x = target, y = fixed.acidity)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Fixed Acidity")

# volatile acidity
plot_volatile_acidity <- wine_data %>% 
  ggplot(aes(x = factor(target), y = volatile.acidity)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Volatile Acidity")

# citric acid
plot_citric_acid <- wine_data %>% 
  ggplot(aes(x = factor(target), y = citric.acid)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Citric Acid")

# residual sugar
plot_residual_sugar <- wine_data %>% 
  ggplot(aes(x = factor(target), y = residual.sugar)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Residual Sugar")

# chlorides
plot_chlorides <- wine_data %>% 
  ggplot(aes(x = factor(target), y = chlorides)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Chlorides")

# free sulfur dioxide
plot_free_sulfur <- wine_data %>% 
  ggplot(aes(x = factor(target), y = free.sulfur.dioxide)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Free sulfur dioxide")

# total sulfur dioxide
plot_total_sulfur <- wine_data %>% 
  ggplot(aes(x = factor(target), y = total.sulfur.dioxide)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Total sulfur dioxide")

# density
plot_density <- wine_data %>% 
  ggplot(aes(x = factor(target), y = density)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Density")

# pH
plot_ph <- wine_data %>% 
  ggplot(aes(x = factor(target), y = pH)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "pH value")

# sulphates
plot_sulphates <- wine_data %>% 
  ggplot(aes(x = factor(target), y = sulphates)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Sulphates")

# alcohol
plot_alcohol <- wine_data %>% 
  ggplot(aes(x = factor(target), y = alcohol)) + 
  geom_violin() +
  geom_jitter(alpha = 0.1, size = 0.5) +
  labs(x = "Wine Quality", y = "Alcohol")

# put all the graphs together
final_plot <- plot_grid(
  plot_fixed_acidity, plot_volatile_acidity, plot_citric_acid,
  plot_residual_sugar, plot_chlorides, plot_free_sulfur,
  plot_total_sulfur, plot_density, plot_ph, plot_sulphates,
  plot_alcohol, ncol = 2, align = 'v')

# save the graph
ggsave(output_file, width = 10, height = 20, plot = final_plot)