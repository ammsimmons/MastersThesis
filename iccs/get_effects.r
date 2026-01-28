#' Simulating data
#' @description
#' This function receives instructions to simulate one iteration 
#' of the data given a target ICC, a fixed variance value, 
#' and a (varying) object-to-residual ratio (ORE)
#' 
#' This function can be replaced with 
#' generate_data_ORA() to specify with a object-to-rater ratio()
#' 
#' Goal: Simulate data given parameters
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



generate_data_ORE <- function(n_raters,n_objects,
  target_icc, fixed_obj_var, rater_resid_ratio){

  
  
  # Obtain variances 
  sigma_sqr <- get_data_ORE(target_icc, fixed_obj_var, rater_resid_ratio)
  
  # Generate effects 
  obj_effects   <- rnorm(
    n_objects, mean = 0, sd = sqrt(sigma_sqr$var_object)
  )
  rater_effects <- rnorm(
    n_raters, mean =0, sd = sqrt(sigma_sqr$var_rater)
  )

  # Create data structure # fully crossed designs only
  dat <- expand.grid(
    ObjectID = 1:n_objects,
    RaterID= 1:n_raters
  )
 # Generate scores 
  data <- dat %>% tibble %>%
    mutate(
      u_i = obj_effects[ObjectID], #object effect
      v_j = rater_effects[RaterID], #rater effect
      Error = rnorm(n(), mean=0, sd = sqrt(sigma_sqr$var_residual)),
      OBJ_VAR = sigma_sqr$var_object,
      RATER_VAR = sigma_sqr$var_rater, 
      RES_VAR = sigma_sqr$var_residual, 
      #implicate grand mean such that
      # y_ij = mu + O_i + R_j + e_ij

     # Score = grand_mean + Effect_O + Effect_R + Error
    )

  return(data)
}
