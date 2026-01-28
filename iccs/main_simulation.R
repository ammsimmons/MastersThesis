#' Main Simulation Script
#' @description
#' 
#' Goal: Run Simulations 
#'  
#' @param n_objects Number of objects
#' @param n_raters Number of raters
#' @param target_icc Target ICC (between 0-1)
#' @param fixed_obj_var Fixed object variance value 
#' @param rater_resid_ratio Value between [0,int]
#' @return a tibble 
#' @example generate_data_ORE(param_list)
#' 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
#' University of Kansas
#' 
#' 


# SOURCE ----
##################
source("iccs/simulate_utils.r") # functions for simulating data 
source("iccs/get_effects.r") #function calcuating fixed/random effects
source("iccs/get_variances_ORE.r") # utilizing rater/residual ratio

# LIBRARIES -------
library(tidyverse)
library(varde)

###################
#SAVE DIRECTORY
DIR <- "iccs/data"

# Simulation Experiment 1: Binary Data  -----

# Paramter Grid 
RATERS = c(3,12,24)
OBJECTS = c(10,50,100)
TARGET_ICCS = c(0.5,0.75,0.90)
PROPORTION = c(0.5, 0.9) # for the binary case
ITERATIONS = 10

#one condition test
target_icc <- TARGET_ICCS[1]
n_raters <- RATERS[3]
n_objects <- OBJECTS[3]
p <- PROPORTION[1]



# run_all_binary <- function(
#   ITERATIONS, DIR,icc_target,
#   RATERS[3],OBJECTS[3], PROPORTION[1]){

#   furrr::future_pwalk(P, run_one_cond, iter =iter, 
#     dir = dir, .progress = TRUE,
#   .options = furrr::furrr_options(seed = TRUE))
#   #disable the error 

#   }



run_one_binary <- function(n_raters, n_objects,target_icc,p){

  #1) Generate Data 
  dat <- simulate_binary(n_raters, n_objects, target_icc, p)

  #2) Analyze data 
  estimate_icc <- varde::calc_icc(dat, subject ="ObjectID", rater = "RaterID", scores = "Score",
  engine = "LME")

  #extract ICC and variance estimates 
  out <- data.frame(icc = estimate_icc$iccs_summary$estimate[1],  #single-measures agreement ICC(A,1)
    obj_var= estimate_icc$vars_summary$estimate[1],
    rater_var = estimate_icc$vars_summary$estimate[2] 
  )
  return(out)
}



