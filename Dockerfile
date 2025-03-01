
FROM rocker/rstudio:4.4.2 

RUN Rscript -e "install.packages('remotes')" 
RUN Rscript -e "remotes::install_version('ggplot2', version='3.5.1')"
RUN Rscript -e "remotes::install_version('tidymodels', version='1.3.0')"
RUN Rscript -e "remotes::install_version('rmarkdown', version='2.29')"
RUN Rscript -e "remotes::install_version('readr', version='2.1.5')"
RUN Rscript -e "remotes::install_version('GGally', version='2.2.1')"
