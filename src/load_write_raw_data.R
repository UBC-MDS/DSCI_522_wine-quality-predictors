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
