
#' Generate summary statistics table for numerical features
#'
#' takes a dataset as input and calculates individual summary statistics
#' (mean, median, variance, minimum, and maximum) for all numeric columns
#' in a given dataset that has been reshaped from a wide format to a long
#'  format
#'
#' @param dataset A dataset or dataset extension (e.g. a tibble).
#'
#' @return A data frame with 6 columns.
#'   The first column (named `variable`) lists the variables selected from
#'   the original dataset (`age`, `shell_weight`, `diameter`, `height`).
#'   The second column (named `mean`) contains the mean of the values for
#'   each variable.
#'   The third column (named `median`) contains the median of the values
#'   for each variable.
#'   The fourth column (named `variance`) contains the variance of the
#'   values for each variable.
#'   The fifth column (named `minimum`) contains the minimum value for
#'   each variable.
#'   The sixth column (named `maximum`) contains the maximum value for
#'   each variable.
#'   Each row corresponds to one of the variables selected from the
#'   original dataset
#' @export
#' library(tidymodels)
#' library(dplyr)
#' library(tidyr)
#' @examples
#' get_summary(abalone_train)

library(tidymodels)
library(dplyr)
library(tidyr)

get_summary <- function(dataset) {
  # returns a dataframe with 6 columns: variable, mean, median, variance,
  # minimum, and maximum
  dataset |>
    select_if(is.numeric) |> # select(age, shell_weight, diameter, height) |>
    pivot_longer(cols = everything(), names_to = "variable", values_to = "values") |>
    group_by(variable) |>
    summarize(
      mean = mean(values, na.rm = TRUE),
      median = median(values, na.rm = TRUE),
      variance = var(values, na.rm = TRUE),
      minimum = min(values, na.rm = TRUE),
      maximum = max(values, na.rm = TRUE)
    )
}