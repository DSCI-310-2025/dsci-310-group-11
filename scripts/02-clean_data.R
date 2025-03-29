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

abalone_data <- read_csv(opt$file_path)

# Calling abstracted clean data function 

abalone_data <- clean_data(abalone_data)

# # Reversing the scaling for readability purposes 
# abalone_data <- abalone_data |> 
#   mutate(length = length * 200,
#          diameter = diameter * 200,
#          height = height * 200,
#          whole_weight = whole_weight * 200,
#          shucked_weight = shucked_weight * 200,
#          viscera_weight = viscera_weight * 200,
#          shell_weight = shell_weight * 200)


# # Creating the new target variable (age)
# abalone_data <- abalone_data |> 
#   mutate(age = rings + 1.5)

# # Clean data - removing old target variable and removing unecessary categorical sex variable 
# abalone_no_sex <- abalone_data |> select(-sex, -rings)

# Data validation
create_agent(tbl = abalone_data)

abalone_data |> # checking columns and values are > -1 and not negative or still scaled 
  col_vals_gt(columns = vars(length, diameter, height, whole_weight, shucked_weight, viscera_weight, shell_weight), value = -1) |>
  interrogate()

abalone_data |> # checking for age (new target) column 
  col_exists("age")|>  
  interrogate()

abalone_data |> # checking age is greater than 1.5 
  col_vals_gt(columns = vars(age), value = 1.5) |>
  interrogate()

expect_error({
  abalone_data |> #checking sex and rings columns are not present 
    col_exists("sex") |>
    col_exists("rings") |>
    interrogate(),
}, regexp = "not found")


# Splitting the data into training and testing sets 
set.seed(1234)
split_data(abalone_data)

abalone_train
abalone_test

source("tests/testthat/test-clean-data.R")

# Creating the training and testing output files 
write_csv(abalone_train, opt$output_train_path)
write_csv(abalone_test, opt$output_test_path)

print("finished cleaning and splitting the data")
# command to run: Rscript scripts/02-clean_data.R --file_path=data/raw/abalone_data.csv --output_train_path=data/clean/abalone_train.csv --output_test_path=data/clean/abalone_test.csv
