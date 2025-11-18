##### Generate a fully crossed design 
source("iccs/get_variances.r")

simulate_icc_data <- function(n_objects, n_raters, 
  target_icc, grand_mean, fixed_obj_var, rater_resid_ratio){
  
  # Obtain variances 
  sigma_sqr <- get_variances(target_icc, fixed_obj_var, rater_resid_ratio)
  
  # Generate effects 
  obj_effects   <- rnorm(
    n_objects, mean = 0, sd = sqrt(sigma_sqr$var_object)
  )
  rater_effects <- rnorm(
    n_raters, mean =0, sd = sqrt(sigma_sqr$var_rater)
  )

  # Create data structure
  dat <- expand.grid(
    ObjectID = 1:n_objects,
    RaterID= 1:n_raters
  )
 # Generate scores 
  data <- dat %>% 
    mutate(
      Effect_O = obj_effects[ObjectID],
      Effect_R = rater_effects[RaterID],
      Error = rnorm(n(), mean=0, sd = sqrt(sigma_sqr$var_residual)),
      #implicate grand mean such that
      # y_ij = mu + O_i + R_j + e_ij

      Score = grand_mean + Effect_O + Effect_R + Error
    )

  return(data)
}
