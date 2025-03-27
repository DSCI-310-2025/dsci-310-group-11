#' Create a linear regression model
#' 
#' Creates a linear regression model using the training data, based on the diameter,
#' height, and shell weight of the abalone. Returns a fitted linear regression model
#' 
#' @param training the training data for the function
#' 
#' @return a fitted linear regression model 
#' 
#' @export
#' 
build_model <- function(training = "training data for the model") {
  spec <- parsnip::linear_reg() |>
    parsnip::set_engine("lm") |>
    parsnip::set_mode("regression")
  
  recipe <- recipes::recipe(age ~ diameter + height + shell_weight, data = training)
  
  modelfit <- workflows::workflow() |>
    workflows::add_recipe(recipe) |>
    workflows::add_model(spec) |>
    parsnip::fit(data = training)
  
  modelfit
}
