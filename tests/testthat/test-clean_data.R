library(testthat)
source("R/clean_data.R")

# Data without age column 
data_no_age <- data.frame(diameter = c(1:10), 
                        length = c(1:10),
                        diameter = c(1:10),
                        height = c(1:10)0,
                        whole_weight = c(1:10),
                        shucked_weight = c(1:10),
                        viscera_weight = c(1:10),
                        shell_weight = c(1:10)
)


# Data with age column (new target variable)
data_with_age <- data.frame(diameter = c(1:10), 
                        length = c(1:10),
                        diameter = c(1:10),
                        height = c(1:10)0,
                        whole_weight = c(1:10),
                        shucked_weight = c(1:10),
                        viscera_weight = c(1:10),
                        shell_weight = c(1:10),
                        age = c(1:10)
)

# Data with scaled values 
data_scaled <- data.frame(diameter = c(0.01:0.05), 
                        length = c(0.01:0.05),
                        diameter = c(0.01:0.05),
                        height = c(0.01:0.05),
                        whole_weight = c(0.01:0.05),
                        shucked_weight = c(0.01:0.05),
                        viscera_weight = c(0.01:0.05),
                        shell_weight = c(0.01:0.05)
)
