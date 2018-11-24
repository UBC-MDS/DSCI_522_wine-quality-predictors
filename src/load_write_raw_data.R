#! /usr/bin/env Rscript 
# load_write_raw_data.R
# Created by Reza, Modified by Iris
#
# This script loads the wine data from online URL,
# and save as a raw csv file.
#
# Usage: Rscript load_write_raw_data.R URL output_file

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

# The main function
main <- function(){
  
  # read the dataset
  data <- read.delim(input_file, sep = ";")
  
  # Save the output csv file
  write.csv(data, file=output_file)
  
}

# The main function
main()
