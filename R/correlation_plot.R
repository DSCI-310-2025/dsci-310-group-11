library(GGally)
library(ggplot2)

make_corr_plot <- function(data) {
  # creates a correlation plot for the given data
  ggpairs(data) +
    theme(text = element_text(size = 10))
}