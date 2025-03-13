library(docopt)
library(GGally)
library(readr)
library(tidymodels)

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

# summary statistics for abalone data
abalone_train_summ <- abalone_train |>
  select(age, shell_weight, diameter, height) |>
  pivot_longer(cols = height:age, names_to = "variable", values_to = "values") |>
  group_by(variable) |>
  summarize(mean = mean(values),
            median = median(values),
            variance = var(values),
            minimum = min(values),
            maximum = max(values))
abalone_train_summ

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
