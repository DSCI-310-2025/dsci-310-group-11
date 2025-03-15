FROM rocker/rstudio:4.4.2 

RUN Rscript -e "install.packages('remotes')" && \
    Rscript -e "remotes::install_version('tidymodels', version='1.3.0')" && \
    Rscript -e "remotes::install_version('rmarkdown', version='2.29')" && \
    Rscript -e "remotes::install_version('readr', version='2.1.5')" && \
    Rscript -e "remotes::install_version('GGally', version='2.2.1')" && \
    Rscript -e "remotes::install_version('knitr', version='1.49')"
