# Analyzing the Ordinal Simulation Data 
#' @description
#' 
#' Goal: Run Simulations 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
#' University of Kansas
#' 
#' 

# 1. Load necessary libraries
library(tidyverse)
library(simhelpers)
#library(unnest)
#library(future)
#library(vardel)
#library(assertthat)


###################
# DIRECTORY & Loading Data 
DIR <- "MastersThesis/iccs/data"
dat_nest <- readRDS(paste0(DIR,'/Ordinal_run1_full.rds'))

###### Data Wrangling 

## unnest the results' list-column  (by hand; example with "icc" column which is numeric) 

# dat <- dat_nest |> 
#   mutate(result = map(result, as_tibble)) |>
#   unnest(result) |>
#   mutate(
#     icc = map_dbl(icc, \(x) pluck(x, .default= NA_real_)))

##  unnest efficiently 
dat <- dat_nest |> 
  mutate(result = map(result, as_tibble)) |>
  unnest(result) |>
  mutate(across(where(is.list), \(col) {
    map_vec(col, \(x) if(is.null(x)) NA else x)
  }))

# Delete nested object
rm(dat_nest)



  