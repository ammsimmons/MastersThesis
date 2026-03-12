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
#library(assertthat)

###################
#SAVE DIRECTORY
DIR <- "iccs/data"

# Simulation Experiment 1: Binary Data  -----

# Paramter Grid/Design 

design_factors <- list(
n_raters = c(3,12,24),
n_objects = c(10,50,100),
target_icc = c(0.50,0.60,0.70),
p = c(0.5, 0.9)# for the binary case
) 
iter <- 10
# params <- expand_grid( !!!design_factors) %>%
#   mutate(
#     SEED = 02112026 + 17 * 1:n() #set seed for each row 
#   )

params <- expand_grid( !!!design_factors) |>
    mutate(
    seed = 03022026 + 17 * 1:n(), #set seed for each row
    filename = paste0("iccs/data/",seed,".rds")
  )

# #index SEED
# SEED <- params$SEED 

tictoc::tic()
future::plan(multicore, workers = 6)
#future::plan(sequential)
sim_results <- vardel::run_all_binary(params, iter, writeFiles=FALSE)
tictoc::toc()

# # saving results requires a new passed filename
# params_saved <- params |>
#   mutate(
#     filename = paste0("iccs/data/",seed,".rds")
#   )

# saved_estim_icc <- function(..., filename = NA_character_){
#   res <- safely(vardel::run_all_binary)(...)

#   saveRDS(res$result$res, file = filename)
   
#   #return(res$error)
#    }


#sim_results <- pmap(params_mod, Pearson_sim, reps = 1000 )

