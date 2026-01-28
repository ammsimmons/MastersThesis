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


###################


# Simulation Experiment 1: Binary Data  -----

# Paramter Grid 
RATERS = c(3,12,24)
OBJECTS = c(10,50,100)
TARGET_ICCS = c(0.5,0.75,0.90)
PROPORTION = c(0.5, 0.9) # for the binary case 


test_binary <- function(n_raters, n_objects,target_icc,p){
  dat <- simulate_binary(n_raters, n_objects, target_icc, p)
}

