
FROM rocker/rstudio:4.4.2 

RUN Rscript -e "install.packages('remotes')" # Double Quotes For Command, Single Quotes for R Code 
RUN Rscript -e "remotes::install_version('tidyverse', version='2.0.0')"
RUN Rscript -e "remotes::install_version('tidymodels', version='1.3.0')"
RUN Rscript -e "remotes::install_version('GGally', version='2.2.1')
