library(testthat)

source("R/get_summary.R")

# test input data
all_numeric_df <- tibble(
  age = c(5, 10, 15, 20),
  shell_weight = c(0.1, 0.2, 0.3, 0.4),
  diameter = c(0.5, 0.6, 0.7, 0.8),
  height = c(0.05, 0.06, 0.07, 0.08)
)

mixed_df <- tibble(
  age = c(5, 10, 15, 20),
  shell_weight = c(0.1, 0.2, 0.3, 0.4),
  category = c("A", "B", "A", "B")
)

one_row_numeric_df <- tibble(
  age = c(5, 10, 15, 20)
)

one_row_non_numeric_df <- tibble(
  category = c("A", "B", "A", "B")
)

empty_df <- tibble(
  age = numeric(0),
  shell_weight = numeric(0),
  diameter = numeric(0),
  height = numeric(0)
)

all_non_numeric_df <- tibble(
  category = c("A", "B", "C", "D"),
  label = c("X", "Y", "Z", "W")
)





# expected test outputs
all_numeric_df_output <- tibble(
  variable = c("age", "shell_weight", "diameter", "height"),
  mean = c(12.5, 0.25, 0.65, 0.065),
  median = c(12.5, 0.25, 0.65, 0.065),
  variance = c(41.67, 0.01667, 0.01667, 0.000167),
  minimum = c(5, 0.1, 0.5, 0.05),
  maximum = c(20, 0.4, 0.8, 0.08)
)

mixed_df_output <- tibble(
  variable = c("age", "shell_weight"),
  mean = c(12.5, 0.25),
  median = c(12.5, 0.25),
  variance = c(41.67, 0.01667),
  minimum = c(5, 0.1),
  maximum = c(20, 0.4)
)

one_row_numeric_df_output <- tibble(
  variable = c("age"),
  mean = c(12.5),
  median = numeric(12.5),
  variance = numeric(41.67),
  minimum = numeric(5),
  maximum = numeric(10)
)


empty_df_output <- tibble(
  variable = character(0),
  mean = numeric(0),
  median = numeric(0),
  variance = numeric(0),
  minimum = numeric(0),
  maximum = numeric(0)
)





# tests
test_that("a dataframe with numeric values returns correct summary", {
  expect_equal(get_summary(numeric_df), numeric_df_output)
  expect_s3_class(get_summary(numeric_df), "data.frame")
})

test_that("a dataframe with mixed numeric and non-numeric columns selects only numeric", {
  expect_equal(get_summary(mixed_df), numeric_df_output)
  expect_s3_class(get_summary(mixed_df), "data.frame")
})

test_that("a dataframe with only one numeric row returns correct summary", {
  expect_equal(get_summary(one_numeric_row_df), one_numeric_row_df_output)
  expect_s3_class(get_summary(one_numeric_row_df), "data.frame")
})

test_that("a dataframe with one non-numeric row returns an empty summary", {
  expect_error(get_summary(one_row_non_numeric_df))
})

test_that("an empty dataframe returns an empty output", {
  expect_equal(get_summary(empty_df), empty_df_output)
  expect_s3_class(get_summary(empty_df), "data.frame")
})

test_that("a dataframe with non-numeric columns only should return an error", {
  expect_error(get_summary(non_numeric_df))
})
