library(readr)
library(tidymodels)
library(docopt)
source("R/build_model.R")

"This script creates the linear regression model, analyzes the performance of the model, and creates output visualizations

Usage: 04-modeling.R --train_path=<train_path> --test_path=<test_path> --coefs_path=<coefs_path> --metrics_path=<metrics_path> --viz_path=<viz_path>
" -> doc

opt <- docopt(doc)

abalone_train <- read_csv(opt$train_path)
abalone_test <- read_csv(opt$test_path)

set.seed(1234)


fit <- build_model(abalone_train)
coefs <- tidy(fit)

write_csv(coefs, file = opt$coefs_path)


abalone_predicted <- predict(fit, abalone_test) |>
  bind_cols(abalone_test)

metrics <- metrics(abalone_predicted, truth = age, estimate = .pred)

write_csv(metrics, file = opt$metrics_path)


weight_predict_plot <- abalone_predicted |>
  ggplot(aes(x = shell_weight)) +
  geom_point(aes(y = age), alpha = 0.3) +
  geom_line(aes(y = .pred), color = "skyblue", linewidth = 0.75) +
  labs(x = "Shell Weight (grams)", y = "Age (years)", title = "Abalone Predicted Age and True Age")

ggsave(weight_predict_plot, file = opt$viz_path)

print("finished the analysis! XD")

# command to run: Rscript scripts/04-modeling.R --train_path=data/clean/abalone_train.csv --test_path=data/clean/abalone_test.csv --coefs_path=output/tables/coefs.csv --metrics_path=output/tables/metrics.csv --viz_path=output/images/abalone_predicted.png
