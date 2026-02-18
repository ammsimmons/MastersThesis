#' Main Simulation Script
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

###################
#SAVE DIRECTORY
DIR <- "iccs/data"

# Simulation Experiment 1: Binary Data  -----

# Paramter Grid/Design 

design_factors <- list(
n_raters = c(3,12,24),
n_objects = c(10,50,100),
target_icc = c(0.5,0.75,0.90),
p = c(0.5, 0.9)# for the binary case
)
iter = 2
# params <- expand_grid( !!!design_factors) %>%
#   mutate(
#     SEED = 02112026 + 17 * 1:n() #set seed for each row 
#   )

params <- expand_grid( !!!design_factors)

# #one condition test
# target_icc <- TARGET_ICCS[1]
# n_raters <- RATERS[3]
# n_objects <- OBJECTS[3]
# p <- PROPORTION[1]


n_raters <- 24
n_objects <- 100
target_icc <- 0.5
p <- 0.5
iter <- 10

# RUN BINARY SIMULATIONS (simhelper doesn't work with f_analyze )
# Binary_sim <- bundle_sim(
#   f_generate = run_one_binary,
#   f_analyze = calc_icc
# )


# run_all_binary <- function(
#   ITERATIONS, DIR,icc_target,
#   RATERS[3],OBJECTS[3], PROPORTION[1]){

#   furrr::future_pwalk(P, run_one_cond, iter =iter, 
#     dir = dir, .progress = TRUE,
#   .options = furrr::furrr_options(seed = TRUE))
#   #disable the error 

#   }


future::plan(multicore, workers = 6)
#future::plan(sequential)
estim_icc <- vardel::run_all_binary(params, iter)




#sim_results <- pmap(params_mod, Pearson_sim, reps = 1000 )
