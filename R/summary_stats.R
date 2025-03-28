
#' Generate summary statistics table for numerical features
#'
#' takes a dataset as input and calculates individual summary statistics
#' (mean, median, variance, minimum, and maximum) for a selected set of
#' columns (age, shell_weight, diameter, height) that has been reshaped
#' from a wide format to a long format
#'
#' @param dataset A data frame or data frame extension (e.g. a tibble).
#' @param class_col unquoted column name of column containing class labels
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
#'   It will have 4 rows, each corresponding to one of the variables 
#'   selected from the original dataset (age, shell_weight, diameter, and height).
#'
#' @export
#' library(tidymodels)
#' @examples
#' get_summary(abalone_train)

library(tidymodels)

get_summary <- function(dataset) {

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