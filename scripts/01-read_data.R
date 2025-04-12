library(readr)
library(docopt)
library(pointblank)
source("R/download_data.R")

"This script loads and cleans the data
Usage: 01-read_data.R --url=<file_path> --output_path=<output_path>
" -> doc

opt <- docopt(doc)

data_file <- download_data(opt$url)

# data validation validation
agent <- create_agent(tbl = data_file, tbl_name = "abalone_data") |>
  col_vals_in_set(columns = vars(sex), set = c("M", "F", "I")) |>
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

# Stop execution if any validation failed
if (any(agent$validation_set$f_failed)) {
  stop("❌ One or more data validation checks failed. Aborting execution.")
}

# inline tests for read_data
source("tests/testthat/test-download_data.R")

write_csv(data_file, file = opt$output_path)

# command to run: Rscript 01-read_data.R --url="https://archive.ics.uci.edu/static/public/1/abalone.zip" --output_path=data/raw/abalone_data.csv
print("data loaded :P")
