#' Main Ordinal Simulation Script
#' @description
#' 
#' Goal: Run Simulations 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
#' University of Kansas
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
k_category = c(3,5,7),
e_category = c(TRUE,FALSE) # 1 = equal category prevalence, #0 = unequal linear decay prevalence 
) 
iter <- 2


param <- expand_grid( !!!design_factors) |>
    mutate(
    seed = 03122026 + 17 * 1:n(), #set seed for each row,
    condition = 1:n() * 1,
    filename = paste0("iccs/data/ordinal_",condition,"_",seed,".rds")
  )


# run sim (in portions)
params_comp1 <- param |>
  filter(condition <= 81) # for fast server 1 

params_comp2 <- param |> 
  filter(condition <= 82) # for fast server 1 




tictoc::tic()
future::plan(multisession, workers = 6)
#future::plan(sequential)
sim_results <- vardel::run_all_ordinal(params_comp1, iter, writeFiles=TRUE)
tictoc::toc()



