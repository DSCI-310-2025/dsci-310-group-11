library(readr)
library(tidymodels)
library(docopt)
library(pointblank)
library(abalone.analysis)

"This script creates the linear regression model, analyzes the performance of the model, and creates output visualizations

Usage: 04-modeling.R --train_path=<train_path> --test_path=<test_path> --coefs_path=<coefs_path> --metrics_path=<metrics_path> --viz_path=<viz_path>
" -> doc

opt <- docopt(doc)

# assigning the command line arguments to variables
abalone_train <- read_csv(opt$train_path)
abalone_test <- read_csv(opt$test_path)

set.seed(1234)

# fitting the model 
fit <- build_model(func = age ~ diameter + height + shell_weight, training = abalone_train)

# adding the coefficients to the model 
coefs <- tidy(fit)

# saving the coefficients to a csv file 
write_csv(coefs, file = opt$coefs_path)

# predicting the age of abalone on the test set 
abalone_predicted <- predict(fit, abalone_test) |>
  bind_cols(abalone_test)

# calculating the model performance metrics
metrics <- metrics(abalone_predicted, truth = age, estimate = .pred)

# writing the metrics to a csv file 
write_csv(metrics, file = opt$metrics_path)

# creating plot of predicted values 
weight_predict_plot <- abalone_predicted |>
  ggplot(aes(x = shell_weight)) +
  geom_point(aes(y = age), alpha = 0.3) +
  geom_line(aes(y = .pred), color = "skyblue", linewidth = 0.75) +
  labs(x = "Shell Weight (grams)", y = "Age (years)", title = "Abalone Predicted Age and True Age")

# saving the plot as a png 
ggsave(weight_predict_plot, file = opt$viz_path)

print("finished the analysis! XD")

# command to run: Rscript scripts/04-modeling.R --train_path=data/clean/abalone_train.csv --test_path=data/clean/abalone_test.csv --coefs_path=output/tables/coefs.csv --metrics_path=output/tables/metrics.csv --viz_path=output/images/abalone_predicted.png
