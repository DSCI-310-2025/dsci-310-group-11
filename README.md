# Abalone Age Prediction for DSCI 310 2025

## Contributors
- `Group 11`
  - `Alex Haddon, Maxine Paredes, Edward Sobczak, Emma Wolfe`

## Project Summary
This project analyzes the Abalone dataset from the UCI Machine Learning Repository to predict the age of abalones based on physical characteristics. The analysis involves data preprocessing, exploratory data analysis, and building a linear regression model using the `tidymodels` framework.

## How to Run the Analysis
---
### 1. Clone the Repository
Clone the `abalone_analysis` repository from GitHub to your local machine:
```sh
git clone https://github.com/DSCI-310-2025/dsci-310-group-11.git
```

### 2. Navigate to the Project Directory
In your terminal changing your working directory to the newly cloned repository:
```sh
cd abalone_analysis
```

### 3. Start the Container
Ensure Docker is installed and running on your system. Start the container using docker-compose:
```sh
docker-compose up
```

### 4. Access RStudio in the Browser
Once the container is up and running, open a browser and go to:
```sh
http://localhost:8787
```
The password is disabled in the docker-compose.yml file so you will be able to directly access RStudio. 

### 5. Open the Abalone Age Prediction File
- In RStudio, go to the Files pane (bottom right).
- Navigate to /home/rstudio/abalone_analysis.
- Click on abalone_age_prediction.qmd to open the file.

### 6. Run the Analysis
- In RStudio, click Render to run the entire .qmd file.
- Alternatively, you can run each chunk manually in the R console, if needed.
  
### 7. Shut Down the Container (Optional)
When you’re finished, stop and remove the container. In your terminal use the shortcut `Ctr+c` then type:
```sh
docker-compose rm
```
---

## Dependencies
- `tidymodels`(1.3.0): for modeling and data preprocessing 
- `GGally`(2.2.1): for visualization, including correlation plots
- `ggplot2`(3.5.1): for custom data visualizations
- `readr`(2.1.5): for reading and writing CSV files
- `rmarkdown`(2.29): for generating reports and documentation

## Licenses
This project is licensed under the terms specified in `LICENSE.md`. Specifically, the `MIT License` and `Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)` licenses. 
