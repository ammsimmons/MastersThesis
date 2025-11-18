# Example analysis of correlation simulations

################### 
# Monte Carlo simulation accuracy will be based on two criteria 
# (Muthen & Muthen, 2002)
# 1. Estimation Accuracy (Bias in point estimates) 
# 2. Statistcal Inference (Coverage rates of confidence intervals)


###################
# Criterion 1: Estimation Accuracy 
# Bias in point estimates will be asssesed using 
# a) Bias in Estimate:
# The average value of the estimate across all simulation
# repetitions: The population value is subtracted from this
# average estimate and divded by the population value. 
# This bias should not exceed 10%  
# b) Bias in Standard Error:
# The SD of the distribution of simulation estimates
# is the population standard error. To get bias in standard error,
# calculate: [SD(r_acrossSims) - SE(average per sim)}/SD(r_acrossSim)
# This bias should not exceed 10%   
# NOTE: SE of the r (for each simulation) is estimated using 
# the least biased esimator for SE in Gnambs (2023)

# b) MAE: mean absolute error 
# The mean absolute deviation between the parameter 
# population value and sample estimate across all simulation
# repetitions (Van Oest, 2019)
#########################

#Criterion 2: Coverage rates of confidence intervals
# Defined as the proportion of replications
# "for which the 95% confidence interval contains
# the true parameter value".
# To calculate coverage: 
# for each simulation reptitions, calculate the 95% CI
# Does this CI contain the true population paramter? 
# if so = 1, if not = 0 
# coverage = (proportion of 1)/simulation repetitions
# This coverage should be close 95% 

######################
# Load helper simulation functions via Source
######################
source("correlations/analyze_all.r")
library(dplyr)
library(future)
library(purrr)


####################################
# File Management 
####################################
fs:::dir_create("correlations/data") #doesn't overwrite if exists
dir <- "correlations/data"
#####################################


#Obtain poplation parameters 
#These MUST match the original simulation design 

# Create parameter values here
x1 <- tibble::tibble(mu_x = c(10,20,15),
sd_x = c(1, 2 ,3)) 
y1 <- tibble::tibble(mu_y=c(20,40,8), 
sd_y = c(3, 4, 2))
r <- c(0.2, 0.5, 0.9)
P<- tidyr::crossing(x1, y1, r)
P_list<-as.list(P)
N_sim <- 10000 # number of iterations per simulation (per condition)

# start analysis in parallel (because each file is one condition)

future::plan(multisession, workers=6)
analyze_r <- analyze_all(P_list, N_sim, dir)


