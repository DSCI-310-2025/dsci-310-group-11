library(testthat)
source("R/clean_data.R")

# Raw data for tests
# Data with scaled values and no age column (raw data)
data_scaled <- data.frame(length = c(1:2),
                        diameter = c(1:2), 
                        height = c(1:2),
                        whole_weight = c(1:2),
                        shucked_weight = c(1:2),
                        viscera_weight = c(1:2),
                        shell_weight = c(1:2), 
                        sex = c(1:2), 
                        rings = c(1:2)
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
                        age = c(1:10)
)



# Tests for clean_data function 

test_that("clean data is returned unscaled with new target and removed columns", {
    expect_equal(clean_data(data_scaled), data_with_age)
    expect_s3_classes(clean_data(data_with_age), "data.frame")
})

# further testing is done with data validation on data used for analysis in the script file. 


# Tests for split_data function 

test_that("split_data splits the clean data correctly", {
    splits <- split_data(data_with_age)
    
    #test that the function returns list with train and test in the names 
    expect_true("train" %in% names(splits))
    expect_true("test" %in% names(splits))

    # test the proportion of the splits

    #that the training data is 70% of the rows of the data
    expect_equal(nrow(split$train), floor(0.7 * nrow(data_with_age)))

    # that the testing data is the remaining 30% of the data
    expect_equal(nrow(splits$test), nrow(data_with_age) - nrow(splits$train))

})