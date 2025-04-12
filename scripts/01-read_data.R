library(readr)
library(docopt)
library(testthat)
library(pointblank)
source("R/download_data.R")

"This script loads and cleans the data
Usage: 01-read_data.R --url=<file_path> --output_path=<output_path>
" -> doc

opt <- docopt(doc)

data_file <- download_data(opt$url)

# data validation validation
agent <- create_agent(tbl = data_file, tbl_name = "abalone_data") |>
  col_exists(vars(sex, length, diameter, height,
                  whole_weight, shucked_weight,
                  viscera_weight, shell_weight, rings)) |>
  col_is_numeric(vars(length, diameter, height,
                      whole_weight, shucked_weight,
                      viscera_weight, shell_weight, rings)) |>
  col_is_character(vars(sex)) |>
  col_vals_gt(vars(length, diameter, height,
                   whole_weight, shucked_weight,
                   viscera_weight, shell_weight), value = -1) |>
  col_vals_gt(vars(rings), value = 0) %>%  # assuming no negative values for 'rings'
  interrogate()

# inline tests for read_data
# test_results <- list(
#   test_that("`download_data` returns a data frame", {
#     expect_s3_class(data_file, "data.frame")
#   }),
  
#   test_that("`download_data` returns data with correct column names", {
#     expected_columns <- c("sex", 
#                           "length", 
#                           "diameter", 
#                           "height", 
#                           "whole_weight", 
#                           "shucked_weight", 
#                           "viscera_weight", 
#                           "shell_weight", 
#                           "rings")
#     expect_equal(colnames(data_file), expected_columns)
#   }),
  
#   test_that("`download_data` returns a non-empty dataset", {
#     expect_true(nrow(data_file) > 0, info = "Dataset should not be empty")
#   }),
  
#   test_that("`download_data` returns data with 9 columns", {
#     expect_equal(ncol(data_file), 9)
#   })
# )

# # Check if any tests failed and exit with an error if they did
# if (any(vapply(test_results, inherits, logical(1), "expectation_error"))) {
#   stop("One or more tests failed. Aborting execution.")
# }
source("tests/testthat/test-download_data.R")

write_csv(data_file, file = opt$output_path)

# command to run: Rscript 01-read_data.R --url="https://archive.ics.uci.edu/static/public/1/abalone.zip" --output_path=data/raw/abalone_data.csv
print("data loaded :P")
