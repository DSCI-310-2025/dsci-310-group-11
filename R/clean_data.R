#' Clean the `abalone_data` by reversing the scaling, 
#' creating a new age target variable, 
#' removing the old target variable 
#' and removing an unnecessary categorical variable. 
 
#' @param data_frame Abalone dataframe 
#' 
#' @return a data_frame with reversed scaling, new target variable, removed columns 
#' 
#' @export 
#'
#' @examples 
#' clean_data(abalone_data)

clean_data <- function(raw_data = "abalone data to be cleaned") {

    #returns clean data according to the above specifications
}


#' Creates the training and testing sets.
#' @param data_frame clean data that is ready to be split into traininng and testing
#' 
#' @return assigns training and testing sets to variables 

split_data <- function(clean_data = "clean abalone data") {
    
    # splits data into training and testing set 
}
