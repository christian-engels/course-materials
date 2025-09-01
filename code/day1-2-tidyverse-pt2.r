############################################################
#   Author: Dr Christian Engels
#   University of St Andrews Business School
#
#   This script demonstrates using the tidyverse (dplyr, tidyr),
#   tidyfinance (data download), and tsibble/fable (time series)
#   to download FRED series, summarise, reshape, and plot data.
############################################################

# Optional: install missing packages (uncomment if needed)
# pkgs <- c("tidyverse", "tidyfinance", "tsibble", "fable")
# to_install <- setdiff(pkgs, rownames(installed.packages()))
# if (length(to_install)) install.packages(to_install)

# Load Libraries
library(tidyverse)
library(tidyfinance)
library(tsibble)
library(fable)

# Download Data
fred <- download_data("fred", series = c("GDP", "CPIAUCNS"))

# View Data
View(fred)

# Summary of Data
fred %>% glimpse()

# Filter CPIAUCNS Series
fred_cpi <- fred %>% filter(series == "CPIAUCNS")

# Summary Statistics for CPIAUCNS
fred_cpi_summary <-
  fred_cpi %>%
  summarise(
    date_min = min(date),
    date_max = max(date),
    value_mean = mean(value, na.rm = TRUE)
  )

# Summary for All Series
fred_summary <-
  fred %>%
  group_by(series) %>%
  summarise(
    date_min = min(date),
    date_max = max(date),
    value_mean = mean(value, na.rm = TRUE)
  )

# Yearly Mean Value
fred_yearly_mean <-
  fred %>%
  group_by(series, year = year(date)) %>%
  summarise(value_mean = mean(value, na.rm = TRUE))

# Pivot (wide) Yearly Mean Data (single object; removed duplicate fred_pivot)
fred_yearly <-
  fred_yearly_mean %>%
  pivot_wider(
    id_cols = year,
    names_from = series,
    values_from = value_mean
  ) %>%
  drop_na() # replaced remove_missing()

# Inspect GDP Data
df_gdp <-
  fred_yearly %>%
  select(year, GDP) %>%
  glimpse()

# Plot GDP Over Time
df_gdp %>%
  as_tsibble(index = year) %>%
  autoplot(.vars = GDP)

# Logarithmic GDP Analysis (kept as separate pipeline)
df_gdp %>%
  as_tsibble(index = year) %>%
  mutate(log_GDP = log(GDP)) %>%
  autoplot(.vars = log_GDP)
df_gdp %>%
  as_tsibble(index = year) %>%
  mutate(log_GDP = log(GDP)) %>%
  autoplot(.vars = log_GDP)
