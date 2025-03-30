.PHONY: all clean report

all:
	make data/raw/abalone_data.csv
	make data/clean/abalone_train.csv data/clean/abalone_test.csv
	make output/images/correlation_plot.png output/tables/abalone_train_summ.csv output/images/age_histogram.png
	make output/tables/coefs.csv output/tables/metrics.csv output/images/abalone_predicted.png
	make index.html

# Download raw data from UCI Machine Learning Repository
data/raw/abalone_data.csv: scripts/01-read_data.R
	Rscript scripts/01-read_data.R --url="https://archive.ics.uci.edu/static/public/1/abalone.zip" --output_path=data/raw/abalone_data.csv

# Generate clean data with splits for testing and training 
data/clean/abalone_train.csv data/clean/abalone_test.csv: scripts/02-clean_data.R data/raw/abalone_data.csv
	Rscript scripts/02-clean_data.R --file_path=data/raw/abalone_data.csv --output_train_path=data/clean/abalone_train.csv --output_test_path=data/clean/abalone_test.csv

# Generate EDA Figures and Tables
output/images/correlation_plot.png output/tables/abalone_train_summ.csv output/images/age_histogram.png: scripts/03-eda.R data/clean/abalone_train.csv
	Rscript scripts/03-eda.R --file_path=data/clean/abalone_train.csv --output_path1=output/images/correlation_plot.png --output_path2=output/tables/abalone_train_summ.csv --output_path3=output/images/age_histogram.png

output/tables/coefs.csv output/tables/metrics.csv output/images/abalone_predicted.png: scripts/04-modeling.R data/clean/abalone_train.csv data/clean/abalone_test.csv
	Rscript scripts/04-modeling.R --train_path=data/clean/abalone_train.csv --test_path=data/clean/abalone_test.csv --coefs_path=output/tables/coefs.csv --metrics_path=output/tables/metrics.csv --viz_path=output/images/abalone_predicted.png

index.html: report/abalone_age_prediction.qmd
	quarto render report/abalone_age_prediction.qmd
	mv report/abalone_age_prediction.html docs/index.html

clean:
	rm -f output/images/*
	rm -f output/tables/*
	rm -f data/clean/*
	rm -f *.pdf