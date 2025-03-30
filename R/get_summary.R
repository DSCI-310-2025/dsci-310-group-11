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
#'
#' @examples
#' get_summary(abalone_train)


get_summary <- function(df) {
  # Check if the data frame is empty
  if (nrow(df) == 0) {
    return(tibble(
      variable = character(0),
      mean = numeric(0),
      median = numeric(0),
      variance = numeric(0),
      minimum = numeric(0),
      maximum = numeric(0)
    ))
  }
  
  # Select only numeric columns
  numeric_cols <- df %>% select(where(is.numeric))
  
  # Check if there are no numeric columns
  if (ncol(numeric_cols) == 0) {
    stop("No numeric columns found")
  }
  
  # Calculate summary statistics
  numeric_cols %>%
    pivot_longer(cols = everything(), names_to = "variable", values_to = "values") %>%
    group_by(variable) %>%
    reframe(
      mean = round(mean(values, na.rm = TRUE), 4),
      median = round(median(values, na.rm = TRUE), 4),
      variance = round(var(values, na.rm = TRUE), 4),
      minimum = round(min(values, na.rm = TRUE), 4),
      maximum = round(max(values, na.rm = TRUE), 4)
    )
}
