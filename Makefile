.PHONY: all clean report

all:
	make data/raw/abalone_data.csv
	make data/clean/abalone_train.csv data/clean/abalone_test.csv
	make output/images/correlation_plot.png output/tables/abalone_train_summ.csv output/images/age_histogram.png
	make output/tables/coefs.csv output/tables/metrics.csv output/images/abalone_predicted.png
	make report

# Download raw data from UCI Machine Learning Repository
data/raw/abalone_data.csv: scripts/01-read_data.R
	Rscript scripts/01-read_data.R --url="https://archive.ics.uci.edu/static/public/1/abalone.zip" --output_path=data/raw/abalone_data.csv

# Generate clean data with splits for testing and training 
data/clean/abalone_train.csv data/clean/abalone_test.csv: scripts/02-clean_data.R data/raw/abalone_data.csv
	Rscript scripts/02-clean_data.R --file_path=data/raw/abalone_data.csv --output_train_path=data/clean/abalone_train.csv --output_test_path=data/clean/abalone_test.csv

# Generate EDA Figures and Tables
output/images/correlation_plot.png output/tables/abalone_train_summ.csv output/images/age_histogram.png: scripts/03-eda.R data/clean/abalone_train.csv
	Rscript scripts/03-eda.R --file_path=data/clean/abalone_train.csv --output_path1=output/images/correlation_plot.png --output_path2=output/tables/abalone_train_summ.csv --output_path3=output/images/age_histogram.png

output/tables/coefs.csv output/tables/metrics.csv output/images/abalone_predicted.png: scripts/04-model.R data/clean/abalone_train.csv data/clean/abalone_test.csv
	Rscript scripts/04-model.R --train_path=data/clean/abalone_train.csv --test_path=data/clean/abalone_test.csv --output_path1=output/tables/coefs.csv --output_path2=output/tables/metrics.csv --output_path3=output/images/abalone_predicted.png

index.html: report/report.qmd
	quarto render report/report.qmd
	mv report/report.html index.html

report:
	make index.html

clean:
	rm -f output/images/*
	rm -f output/tables/*
	rm -f data/clean/*
	rm -f index.html
	rm -f *.pdf