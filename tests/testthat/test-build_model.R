library(testthat)
source("R/build_model.R")

# function input for tests for build_model
training_list <- c(1:40)
training_data_correct_format <- data.frame(age = c(1:10),
                                           diameter = c(1:10),
                                           height = c(1:10),
                                           shell_weight = c(1:10))

training_data_missing_column <- data.frame(age = c(1:10), 
                                           diameter = c(1:10),
                                           height = c(1:10))


test_that("`build_model` should throw an error when incorrect types are passed
          to the `training` argument", {
            expect_error(build_model(training_list))
          })

test_that("`build_model` should throw an error when the training data is missing
          a column that is expected", {
            expect_error(build_model(training_data_missing_column))
          })

test_that("`build_model` produces a `list` object with a length of 4 as the output", {
            expect_type(build_model(training_data_correct_format), "list")
            expect_length(build_model(training_data_correct_format), 4)
})