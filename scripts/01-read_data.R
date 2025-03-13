library(readr)
library(docopt)

"This script loads and cleans the data
Usage: 01-read_data.R --url=<file_path> --output_path=<output_path>
" -> doc

opt <- docopt(doc)


temp <- tempfile()
zipped <- download.file(url = opt$url, destfile = temp)
file <- unz(temp, "abalone.data")
data_file <- read_csv(file, col_names = c("sex", 
                                               "length", 
                                               "diameter", 
                                               "height", 
                                               "whole_weight", 
                                               "shucked_weight", 
                                               "viscera_weight", 
                                               "shell_weight", 
                                               "rings"))
  
unlink(temp)
  
write_csv(data_file, file = opt$output_path)


# command to run: Rscript 01-read_data.R --url="https://archive.ics.uci.edu/static/public/1/abalone.zip" --output_path=data/raw/abalone_data.csv

