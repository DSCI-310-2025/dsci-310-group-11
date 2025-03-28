
library(tidymodels)

get_summary <- function(dataset) {
    # generates table containing summary stats for numerical data
  dataset |>
    select(age, shell_weight, diameter, height) |>
    pivot_longer(cols = height:age, names_to = "variable", values_to = "values") |>
    group_by(variable) |>
    summarize(
      mean = mean(values, na.rm = TRUE),
      median = median(values, na.rm = TRUE),
      variance = var(values, na.rm = TRUE),
      minimum = min(values, na.rm = TRUE),
      maximum = max(values, na.rm = TRUE)
    )
}