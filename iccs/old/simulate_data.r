#Simulate Data for ICCs 

#################### SOURCE
source("iccs/get_data.r")

#################### LIBRARIES
library(tidyverse)


##############################
# Parameters

# Configuration
GRAND_MEAN <- 50
FIXED_OBJ_VAR <- 10
TARGET_ICC <- 0.60 # We want 60% signal, 40% noise

# Scenario A: Noise is mostly random error (Rater Variance is low)
# Ratio 0.2 means: Rater Var is only 20% size of Residual Var
sim_A <- generate_data_ORE(
  n_objects = 100, 
  n_raters = 24, 
  target_icc = TARGET_ICC,
  grand_mean = GRAND_MEAN,
  fixed_obj_var = FIXED_OBJ_VAR,
  rater_resid_ratio = 0.2) 

# Scenario B: Noise is mostly systematic bias (Rater Variance is high)
# Ratio 5.0 means: Rater Var is 5 times larger than Residual Var

sim_B <- generate_data_ORE(
  n_objects = 50, 
  n_raters = 5, 
  target_icc = TARGET_ICC,
  grand_mean = GRAND_MEAN, 
  fixed_obj_var = FIXED_OBJ_VAR,
  rater_resid_ratio = 5) 

###### check simulation data
# Using LMER 

fit_lme <- lme4::lmer( 
  Score ~ 1 + (1 | ObjectID) + (1 | RaterID), 
  data = sim_A)

fit_A_ratio <- #calculate

fit1 <- brms::brm(
  formula = Score ~ 1 + (1 | ObjectID) + (1 | RaterID),
  data = sim_A,
  chains = 4,
  cores = 4,
  init = "random",
  warmup = 5000,
  iter = 10000,
  seed = 2022,
)
fit_1 <- varde(fit_lme)
plot(fit_1, type = "river")


res_A <- calc_icc(
  .data = sim_A, 
  engine = "LME",
  subject = "ObjectID",
  rater = "RaterID",
  scores = "Score",
)
res_A$iccs_summary
#get back rater-residual ratio
res_A$vars_summary$estimate[2]/res_A$vars_summary$estimate[3]


res_B <- calc_icc(
  .data = sim_B, 
  subject = "ObjectID",
  rater = "RaterID",
  scores = "Score",
)
res_B$iccs_summary
