# Load required packages
library(tidyverse)
library(ggplot2)
library(docopt)

doc <- "
Usage:
  analysis.R --out_dir=<out_dir>

Options:
  --output=<output_file>  Path to save cleaned data CSV file
"

analysis <- function(out_dir) {
  # Create a sample dataset
  set.seed(123)
  data <- data.frame(
    x = 1:100,
    y = rnorm(100, mean = 0, sd = 1)
  )

  # Create and save the plot
  plot <- ggplot(data, aes(x = x, y = y)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(title = "Random Data with Trend Line",
        x = "Index",
        y = "Value") +
    theme_minimal()

  # Save the plot
  ggsave("output/random_plot.png", plot, width = 8, height = 6)

  # Save summary statistics
  summary_stats <- summary(data$y) %>%
    enframe(name = "statistic", value = "value")

  write_csv(summary_stats, "output/summary_stats.csv")

  # Save mean and standard deviation
  stats <- tibble(
    mean = mean(data$y),
    sd = sd(data$y)
  )

  write_csv(stats, "output/mean_sd.csv")
}

opt <- docopt(doc)
analysis(opt$out_dir)