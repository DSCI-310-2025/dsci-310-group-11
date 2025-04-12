#import statements
library(tidymodels)
library(readr)
library(docopt)
library(testthat)
library(pointblank)
source("R/clean_data.R")

# Cleaning the data

"This script cleans the `abalone_data` by reversing the scaling, creating a new age target variable, removing the old target variable and removing an unnecessary categorical variable. 
Then the script creates the training and testing sets. 
Usage: 02-clean_data.R --file_path=<file_path> --output_train_path=<output_train_path> --output_test_path=<output_test_path>
" -> doc 

opt <- docopt(doc)

# reading in data
abalone_data <- read_csv(opt$file_path)

# Data validation
# Create an agent for data validation
agent <- create_agent(tbl = abalone_data) |>

  # Check columns are properly scaled (> -1)
  col_vals_gt(columns = vars(length, diameter, height, whole_weight, shucked_weight, viscera_weight, shell_weight, rings), value = -1) |>  

  # Perform the interrogation
  interrogate()

# Halt if any pointblank validation fails
if (any(agent$validation_set$f_failed)) {
  stop("❌ Pre-clean validation failed: One or more pointblank checks did not pass.")
}

#  **Check that sex and rings are in the dataset still**
# If columns do not exist, test should PASS
expect_true("sex" %in% colnames(abalone_data))
expect_true("rings" %in% colnames(abalone_data))

# Calling abstracted clean data function
abalone_data <- clean_data(abalone_data)


# Data validation after cleaning
# Create an agent for data validation
agent <- create_agent(tbl = abalone_data) |>

  # Check columns are properly scaled (> -1)
  col_vals_gt(columns = vars(length, diameter, height, whole_weight, shucked_weight, viscera_weight, shell_weight), value = -1) |>  

  # Check that the "age" column exists
  col_exists("age") |>

  # Check that age is greater than 1.5
  col_vals_gt(columns = vars(age), value = 1.5) |>

  # Perform the interrogation
  interrogate()

if (any(agent$validation_set$f_failed)) {
  stop("❌ Post-clean validation failed: One or more pointblank checks did not pass.")
}

# **Check that sex and rings are NOT in the dataset**
# If columns do not exist, test should PASS
expect_false("sex" %in% colnames(abalone_data))
expect_false("rings" %in% colnames(abalone_data))


# Splitting the data into training and testing sets
set.seed(1234)
split_data(abalone_data)

abalone_train
abalone_test


# Creating the training and testing output files 
write_csv(abalone_train, opt$output_train_path)
write_csv(abalone_test, opt$output_test_path)

source("tests/testthat/test-clean_data.R")

print("finished cleaning and splitting the data")
# command to run: Rscript scripts/02-clean_data.R --file_path=data/raw/abalone_data.csv --output_train_path=data/clean/abalone_train.csv --output_test_path=data/clean/abalone_test.csv
