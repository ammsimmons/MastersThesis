#Simulate Data for ICCs 

#################### SOURCE
source("iccs/get_data.r")

##############################
# Parameters

# Configuration
GRAND_MEAN <- 50
FIXED_OBJ_VAR <- 10
TARGET_ICC <- 0.60 # We want 60% signal, 40% noise

# Scenario A: Noise is mostly random error (Rater Variance is low)
# Ratio 0.2 means: Rater Var is only 20% size of Residual Var
sim_A <- simulate_icc_data(
  n_objects = 50, 
  n_raters = 5, 
  target_icc = TARGET_ICC,
  grand_mean = GRAND_MEAN,
  fixed_obj_var = FIXED_OBJ_VAR,
  rater_resid_ratio = 0.2) 

# Scenario B: Noise is mostly systematic bias (Rater Variance is high)
# Ratio 5.0 means: Rater Var is 5 times larger than Residual Var

sim_B <- simulate_icc_data(
  n_objects = 50, 
  n_raters = 5, 
  target_icc = TARGET_ICC,
  grand_mean = GRAND_MEAN, 
  fixed_obj_var = FIXED_OBJ_VAR,
  rater_resid_ratio = 5) 

###### simulate many datasets (draft)


# future::plan(multisession, workers=6)
icc_targets <- list(0.2,0.5,0.9)


# dats <- furrr::future_map_at(icc_targets, "target_icc",simulate_icc_data,  
#   n_objects = 50, 
#   n_raters = 5, 
#   #target_icc = TARGET_ICC,
#   grand_mean = GRAND_MEAN, 
#   fixed_obj_var = FIXED_OBJ_VAR,
#   rater_resid_ratio = 5,
#   .progress = TRUE,
#   .options = furrr::furrr_options(seed = TRUE))
#   #disable the error



# ##### Simulation lots of datasets


#  furrr::future_pwalk(P, run_one_cond, iter =iter, 
#     dir = dir, .progress = TRUE,
#   .options = furrr::furrr_options(seed = TRUE))
#   #disable the error 

