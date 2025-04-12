library(docopt)
library(GGally)
library(readr)
library(docopt)
library(tidymodels)
library(testthat)
library(pointblank)
source("R/get_summary.R")

"this script conducts the exploratory data analysis on the abalone dataset
includes preliminary analysis, summary statistics for the predictor variables 
the target variable `rings`, and a histogram of the age of abalones 
Usage: 03-eda.R --file_path=<file_path> --output_path1=<output_path1> --output_path2=<output_path2> --output_path3=<output_path3> 
" -> doc

opt <- docopt(doc)

abalone_train <- read_csv(opt$file_path)

# preliminary analysis on abalone data
correlation_plot <- ggpairs(abalone_train) +
  theme(text = element_text(size = 10))
correlation_plot

# summary statistics for abalone data using abstracted function
abalone_train_summ <- get_summary(abalone_train)

# inline tests for get_summary()
source("tests/testthat/test-get_summary.R")

# data validation
# create agent for data validation
agent <- create_agent(tbl = abalone_train_summ) |>

  # check that columns do not contain null values
  col_vals_not_null(columns = everything()) |>

  # check that all columns are numeric
  col_is_numeric(columns = vars(mean, median, variance, minimum, maximum)) |>

  # check that it includes a variable column
  col_exists("variable") |>

  # check that all rows are complete and are not missing values
  rows_complete() |>

  # perform the interrogation
  interrogate()

if (any(agent$validation_set$f_failed)) {
  stop("❌ summary validation failed: One or more pointblank checks did not pass.")
}

# --- VALIDATE output file types using pointblank ---
# Create a tibble to validate image file types (.png)
output_files <- tibble::tibble(
  plot1 = opt$output_path1,
  plot2 = opt$output_path3
)

agent_files <- create_agent(tbl = output_files, tbl_name = "output_files") |>
  col_vals_regex(
    columns = vars(plot1, plot2),
    regex = "\\.png$"
  ) |>
  interrogate()

if (any(agent_files$validation_set$f_failed)) {
  stop("❌ Output path validation failed: One or more image paths are not .png files.")
}

# Validate that the summary table output file is a .csv
output_csv <- tibble::tibble(summary_file = opt$output_path2)

agent_csv <- create_agent(tbl = output_csv, tbl_name = "output_csv") |>
  col_vals_regex(columns = vars(summary_file), regex = "\\.csv$") |>
  interrogate()

if (any(agent_csv$validation_set$f_failed)) {
  stop("❌ Output path validation failed: Summary file is not in .csv format.")
}

# histogram of abalone age
age_histogram <- abalone_train |>
  ggplot(aes(x = age)) +
  geom_histogram(binwidth = 2) +
  labs(x = "Age (years)", y = "Count", title = "Abalone Training Data Age Distribution")
age_histogram

ggsave(correlation_plot, file = opt$output_path1)
write_csv(abalone_train_summ, file = opt$output_path2)
ggsave(age_histogram, file = opt$output_path3)

# command to run; Rscript scripts/03-eda.R --file_path=data/clean/abalone_train.csv --output_path1=output/images/correlation_plot.png --output_path2=output/tables/abalone_train_summ.csv --output_path3=output/images/age_histogram.png
print("eda completed!")
