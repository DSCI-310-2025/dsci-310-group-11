FROM rocker/rstudio:4.4.2 

# Install pak and use it to install all required packages
RUN Rscript -e "install.packages('pak', repos = 'https://cran.rstudio.com'); \
    pak::pkg_install(c( \
        'tidymodels@1.3.0', \
        'rmarkdown@2.29', \
        'readr@2.1.5', \
        'GGally@2.2.1', \
        'knitr@1.49', \
        'pointblank@0.12.2', \
        'testthat@3.2.3', \
        'docopt@0.7.1' \
    ))"

RUN Rscript -e "pak::pkg_install('DSCI-310-2025/abalone.analysis')"
