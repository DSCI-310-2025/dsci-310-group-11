#' Downloads and reads the abalone dataset from the internet
#' 
#' This function downloads the abalone dataset from the internet, unzips it,
#' and reads it into a data frame.
#' 
#' @param url the url to the abalone dataset
#' 
#' @return a data frame containing the raw abalone dataset 
#' 
#' @export
#' 
download_data <- function(url = "url to the abalone dataset") {
  temp <- base::tempfile()
  zipped <- utils::download.file(url, destfile = temp)
  file <- base::unz(temp, "abalone.data")
  data_file <- readr::read_csv(file, col_names = c("sex", 
                                               "length", 
                                               "diameter", 
                                               "height", 
                                               "whole_weight", 
                                               "shucked_weight", 
                                               "viscera_weight", 
                                               "shell_weight", 
                                               "rings"))
  base::unlink(temp)
  return(data_file)

}
