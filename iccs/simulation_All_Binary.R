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

# #index SEED
# SEED <- params$SEED 

tictoc::tic()
future::plan(multisession, workers = 22)
#future::plan(sequential)
sim_results <- vardel::run_all_binary(params, iter, writeFiles=TRUE)
tictoc::toc()

