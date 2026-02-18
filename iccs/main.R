# ==========================================
# Project Controller: main.R
# Run before "simulation_script"
# ==========================================

# 1. Load necessary libraries
library(tidyverse)
library(simhelpers)
library(future)
library(vardel)
#library(ggdist)
#library(irr)
#library(glmmTMB)

# 2. Source definitions 
# This makes your custom objects available to the rest of the project

# Classes & Objects
# source("iccs/icc_oop.r")

# #helper functions
# source("iccs/icc.r") #main calcuate ICC functions 
# source("iccs/utils_sim.r") # functions for simulating data 
# source("iccs/utils_icc.r") # add'l functions for calculating ICCs
# source("iccs/get_effects.r") #function calcuating fixed/random effects
# source("iccs/get_variances_ORE.r") # utilizing rater/residual ratio

# 3. Run the analysis scripts
# Now that classes are defined, these scripts will recognize your objects
# source(here("analysis_part1.R"))
# source(here("analysis_part2.R"))

# message("Project run complete!")