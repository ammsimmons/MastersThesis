#' Simulate Data Helper Functions
#' @description
#' 
#' Goal: Functions used to simulate raw data (binary and ordinal)
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
#' 


# CODE ----

simulate_binary <- function(n_raters,n_objects,target_icc,p,...){
# 1) Set binary data hyper-parameters 
  
  fixed_obj_var <- 1  # assume using rater-residual ratio for now
  intercept <- qnorm(p) # probit transformation 

 # Scenario A: Noise is mostly random error (Rater Variance is low)
 # Ratio 0.2 means: Rater Var is only 20% size of Residual Var
  rater_resid_ratio <- 0.2 


  
# 2) First, obtain (object and rater) random effects 
# must be fully crossed.
 
dat <- generate_data_ORE(n_raters,n_objects,
  target_icc, fixed_obj_var, rater_resid_ratio)
  
# 3)) Generate datasets given the binomial model 
# calculate Linear Predictor and Probabilities
df <- dat %>% tibble () %>%
  mutate(
    # Map random effects to rows
    # u_i = object_effects[Object_ID],
    # v_j = rater_effects[Rater_ID],
    
    # Linear Predictor (probit scale)
    eta = intercept + u_i + v_j, # don't add error? 
    
    # Probability scale (inverse probit)
    prob = plogis(eta),
    
    # Generate Binary Rating
    Score = rbinom(n(), 1, prob) #bernouli 
  )

  return(df)

}