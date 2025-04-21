.PHONY all clean

# run everything
all: ouptut/random_plot.png reports/maternal_health_modeling.html reports/maternal_health_modeling.pdf docs/index.html

# create image
ouptut/random_plot.png: scripts/analysis.R
	Rscript scripts/analysis.R --out_dir="output"

# create html of report
reports/maternal_health_modeling.html: analysis.qmd 
	quarto render reports/maternal_health_modeling.qmd --to html

# create pdf of report
reports/maternal_health_modeling.pdf: analysis.qmd 
	quarto render reports/maternal_health_modeling.qmd --to pdf

# create index.html
docs/index.html: analysis.html
	cp reports/maternal_health_modeling.html docs/index.html

# clean outputs
clean: rm -rf output/* \
	reports/* \
	docs/index.html