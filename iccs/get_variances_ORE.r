#' Simulating correlations
#' @description
#' This function receives instructions to calculate variances 
#' 
#' Goal: Simulate data given parameters, calculate cor, 
#' then return cor
#'  
#' @param target_icc Target ICC 
#' @param fixed_obj_var default = 1
#' @param rater_resid_ratio 
#' values to consider: 
#' ratio = 0.2; rater variance is only 20% of residual variance (low rater variance)
#' ratio = 5; rater variance is 5x the residual variance (high rater variance/bias)
#' @return variances
#' @example get_variances(0.90,1,.5)
#' 
#' 


##################

get_data_ORE <- function(target_icc, fixed_obj_var = 1, rater_resid_ratio) {

  #error check on ICC value 
    if(target_icc >= 1 | target_icc <=0) {
      stop("ICC must be between 0 and 1")
    }
  
  #calculate noise(combined rater and residual variance)
  # TODO: CHANGE RATIO to OBJECT/RATER VARIANCE

  total_noise <- fixed_obj_var * ((1/target_icc) - 1) 
  
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

