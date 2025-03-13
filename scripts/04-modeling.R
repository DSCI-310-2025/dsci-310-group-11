library(readr)
library(tidymodels)
library(docopt)

"This script creates the linear regression model, analyzes the performance of the model,
and creates output visualizations
Usage: 04-modeling.R --train_path=<file path> --test_path=<file path> --coefs_path=<file_path> --metrics_path=<file path> --viz_path=<file path>
" -> doc

opt <- docopt(doc)

abalone_train <- read_csv(opt$train_path)
abalone_test <- read_csv(opt$test_path)

set.seed(1234)

spec <- linear_reg() |> 
  set_engine("lm") |> 
  set_mode("regression")

recipe <- recipe(age ~ diameter + height + shell_weight, data = abalone_train)

fit <- workflow() |> 
  add_recipe(recipe) |> 
  add_model(spec) |> 
  fit(data = abalone_train)

coefs <- tidy(fit)

write_csv(coefs, file = opt$coefs_path)

abalone_predicted <- predict(fit, abalone_test) |> 
  bind_cols(abalone_test)

metrics <- metrics(abalone_predicted, truth = age, estimate = .pred)

write_csv(metrics, file = opt$metrics_path)


weight_predict_plot <- abalone_predicted |> 
  ggplot(aes(x = shell_weight)) +
  geom_point(aes(y = age), alpha = 0.3) +
  geom_line(aes(y = .pred), color = "skyblue", size = 0.75) +
  labs(x = "Shell Weight (grams)", y = "Age (years)", title = "Abalone Predicted Age and True Age")

ggsave(weight_predict_plot, file = opt$viz_path)

print("finished the analysis! XD")

# command to run: Rscript 04-modeling.R --train_path=data/clean/abalone_train.csv --test_path=data/clean/abalone_test.csv --metrics_path=output/tables/metrics.csv --viz_path=output/images/abalone_predicted.png