#' Clean the `abalone_data` by reversing the scaling, 
#' creating a new age target variable, 
#' removing the old target variable 
#' and removing an unnecessary categorical variable. 
 
#' @param data_frame raw Abalone dataframe with scaled values 
#' 
#' @return a data_frame with reversed scaling, new target variable, removed columns 
#' 
#' @export 
#'
#' @examples 
#' clean_data(abalone_data)

clean_data <- function(abalone_data) {

    #returns clean data according to the above specifications

    abalone_data <- abalone_data |> 
        dplyr::mutate(
            length = length * 200, # Reversing the scaling for readability purposes 
            diameter = diameter * 200,
            height = height * 200,
            whole_weight = whole_weight * 200,
            shucked_weight = shucked_weight * 200,
            viscera_weight = viscera_weight * 200,
            shell_weight = shell_weight * 200,
            age = rings + 1.5 #  adding the age variable 
        ) |> 
        # Clean data - removing old target variable and removing unecessary categorical sex variable 
        dplyr::select(-sex, -rings)

    return(abalone_data)
}


#' Creates the training and testing sets.
#' @param data_frame clean data that is ready to be split into traininng and testing
#' 
#' @return assigned training and testing sets to variables, returned as a list 

split_data <- function(clean_data) {
    
    # splits data into training and testing set 

    set.seed(1234)
    abalone_split <- rsample::initial_split(clean_data, prop = 0.7, strata = age)
    
    #assigning to variables in global environment 
    abalone_train <<- rsample::training(abalone_split)
    abalone_test <<- rsample::testing(abalone_split)

    return(list(train = abalone_train, test = abalone_test))
}
