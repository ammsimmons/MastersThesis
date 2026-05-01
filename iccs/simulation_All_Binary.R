#' Main Binary Simulation Script
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
library(future)
library(vardel)
#library(assertthat)

###################
#SAVE DIRECTORY
DIR <- "iccs/data"

# Simulation Experiment 1: Binary Data  -----

# Paramter Grid/Design 

design_factors <- list(
n_raters = c(3,12,24),
n_objects = c(10,50,100),
target_icc = c(0.40,0.60,0.80),
p = c(0.5, 0.8)# for the binary case
) 
iter <- 1000
# params <- expand_grid( !!!design_factors) %>%
#   mutate(
#     SEED = 02112026 + 17 * 1:n() #set seed for each row 
#   )

params <- expand_grid( !!!design_factors) |>
    mutate(
    seed = 03022026 + 17 * 1:n(), #set seed for each row
    condition = 1:n() * 1,
    filename = paste0("iccs/data/binary_",condition,"_",seed,".rds")
  )

# Find errored conditions and rerun 
# 1. List all .rds files in the directory
files <- list.files(path = "~/MastersThesis/iccs/data/", pattern = "\\.rds$", full.names = FALSE)
  
#2. Extract the number from the middle of the filename
# This regex looks for a sequence of digits (\d+)
file_numbers <- as.numeric(stringr::str_extract(files, "\\d+")) 
`%notin%` <- Negate(`%in%`)  
filt_param <- params |> filter(condition %notin% file_numbers)


# #index SEED
# SEED <- params$SEED 

tictoc::tic()
future::plan(multisession, workers = 22)
#future::plan(sequential)
sim_results <- vardel::run_all_binary(filt_param, iter, writeFiles=TRUE)
tictoc::toc()

