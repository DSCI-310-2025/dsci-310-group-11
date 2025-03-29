library(testthat)
source("R/clean_data.R")

set.seed(1234)

# Raw data for tests
# Data with scaled values and no age column (raw data)
data_raw <- data.frame(length = c(1:10),
                        diameter = c(1:10), 
                        height = c(1:10),
                        whole_weight = c(1:10),
                        shucked_weight = c(1:10),
                        viscera_weight = c(1:10),
                        shell_weight = c(1:10), 
                        sex = c("M", "F", "M", "F","M", "F","M", "F", "M", "F"), 
                        rings = c(1:10)
)

data_scaled <- data.frame(length = c(1:10),
                        diameter = c(1:10), 
                        height = c(1:10),
                        whole_weight = c(1:10),
                        shucked_weight = c(1:10),
                        viscera_weight = c(1:10),
                        shell_weight = c(1:10), 
                        sex = c("M", "F", "M", "F","M", "F","M", "F", "M", "F"), 
                        rings = c(1:10)
)

# Clean data for tests 
# Data with age column (new target variable)
data_with_age <- data.frame(length = data_scaled$length * 200,
                        diameter = data_scaled$diameter * 200,
                        height = data_scaled$height * 200,
                        whole_weight = data_scaled$whole_weight * 200,
                        shucked_weight = data_scaled$shucked_weight * 200,
                        viscera_weight = data_scaled$viscera_weight * 200,
                        shell_weight = data_scaled$shell_weight * 200,
                        age = data_scaled$rings + 1.5
)


# Tests for clean_data function 

test_that("clean data is returned unscaled with new target and removed columns", {
    cleaned_data <- clean_data(data_raw)

    comparison_result <- all.equal(cleaned_data, data_with_age)
    print(comparison_result)

    expect_s3_class(cleaned_data, "data.frame")

    expect_true(isTRUE(comparison_result))
})

# further testing is done with data validation on data used for analysis in the script file 


# Testing data for data split function 
data_raw_20 <- data.frame(length = c(1:100),
                        diameter = c(1:100), 
                        height = c(1:100),
                        whole_weight = c(1:100),
                        shucked_weight = c(1:100),
                        viscera_weight = c(1:100),
                        shell_weight = c(1:100), 
                        sex = sample(c("M", "F"), 100, replace = TRUE), 
                        rings = sample(1:20, 100, replace = TRUE)
)

data_with_age_20 <- data.frame(length = data_raw_20$length * 200,
                        diameter = data_raw_20$diameter * 200,
                        height = data_raw_20$height * 200,
                        whole_weight = data_raw_20$whole_weight * 200,
                        shucked_weight = data_raw_20$shucked_weight * 200,
                        viscera_weight = data_raw_20$viscera_weight * 200,
                        shell_weight = data_raw_20$shell_weight * 200,
                        age = data_raw_20$rings + 1.5
)

# Tests for split_data function 

test_that("split_data splits the clean data correctly", {
    splits <- split_data(data_with_age_20)
    
    # Test that the function returns a list with train and test in the names
    expect_true(is.list(splits))
    expect_true("train" %in% names(splits))
    expect_true("test" %in% names(splits))

    # Check the total number of rows in the train and test sets
    expect_equal(nrow(splits$train) + nrow(splits$test), nrow(data_with_age_20))

    # Allow for a larger rounding error (e.g., 5% difference)
    expected_train_size <- floor(0.7 * nrow(data_with_age_20))
    expect_true(abs(nrow(splits$train) - expected_train_size) <= expected_train_size * 0.05)  # 5% margin of error

    # Optionally: Check that the train/test sets are non-empty
    expect_gt(nrow(splits$train), 0)
    expect_gt(nrow(splits$test), 0)
})