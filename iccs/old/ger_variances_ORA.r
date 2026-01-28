 get_variances_ORA <- function(target_icc, fixed_resid_var = 1, rater_resid_ratio) {
 
  #error check on ICC value 
    if(target_icc >= 1 | target_icc <=0) {
      stop("ICC must be between 0 and 1")
    }
  
  # calculate noise
  # TODO: CHANGE RATIO to OBJECT/RATER VARIANCE

  # Given ICC = sigma_2

  total_noise <- fixed_res_var * ((1/target_icc) - 1) 
  
  #obtain rater variance as a function of ratio  
  var_residual <- total_noise / (1 + rater_resid_ratio)

  var_rater <- total_noise - var_residual

  #return variances 
  out <- list(
    var_object = fixed_obj_var, 
    var_rater = var_rater, 
    var_residual = var_residual)
  
  return(out)
}