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
  rater_resid_ratio <- 0.9


  
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
    eta = intercept + u_i + v_j + Error, # don't add error? 
    
    # Probability scale (inverse probit)
    # prob = plogis(eta), 
    
    # Generate Binary Rating
    #Score = rbinom(n(), 1, prob) #bernouli (don't do since not stochastic?)


    Score = ifelse(eta > 0 , 1, 0) #threshold of the probit scale 
  )

  return(df)

}



run_one_binary <- function(n_raters, n_objects,target_icc, p,iter){
  #ones run row as stated in the params matrix
  #set set 
  #set.seed(seed)

  results <- simhelpers::repeat_and_stack(iter, expr ={
  #1) Generate Data 
    dat <- simulate_binary(n_raters, n_objects, target_icc, p)

  #2) Analyze data with error
    
    calc_icc_possibly <- purrr:::possibly(calc_icc, otherwise = NA)
    estimate_icc <- calc_icc_possibly(dat, subject ="ObjectID", rater = "RaterID", scores = "Score",
     k = NULL, engine = "LME")
    
    
    return(estimate_icc[1])

  })
  

  #extract ICC and variance estimates 
  # out <- data.frame(icc = estimate_icc$iccs_summary$estimate[1],  #single-measures agreement ICC(A,1)
  #   obj_var= estimate_icc$vars_summary$estimate[1],
  #   rater_var = estimate_icc$vars_summary$estimate[2] 
  # )

  #output result 
  
}




run_all_binary <- function(P){

  #print(P)
  #print(paths)
  #cat("\n--- Simulation Parameters ---\n")
  #cat(sprintf("Iterations: %i \n", iter))
  #cat(sprintf("Family Distribution: %s \n",family))
  #cat(sprintf("Correlation value: %1.2f \n", r))

  #times <- length(P[[1]])

  #result <- numeric(iter*times) #initialize

  #increase parameter by iteration amount
  #multi_param <- map(P,rep,iter)
  #  res <- purrr::pmap(P, \(.x) run_one_set(.x, iter=iter) |> readr::write_csv(y))

  #run simulations
  #res<- purrr::pmap(P, run_one_cond, iter =iter)

  res <- furrr::future_pmap(P, run_one_binary,
   .progress = TRUE,
  .options = furrr::furrr_options(seed = TRUE))

  #disable the error 
# purrr::pmap(P, run_one_binary,
#    .progress = TRUE)
  
  return(res)
 
}

