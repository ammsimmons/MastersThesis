#' Simulating correlations
#' @description
#' This function uses MVrnom from {Mass} 
#' to get n samples for each column of the matrix 
#'  
#' @param n number of samples
#' @param mu vector of means
#' @param cov_matrix covarianec matrix for two variables
#' @return A list of results
#' @example sim_data(param_list)
#' 
#' 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
#' 
sim_data <- function(n, mu, cov_matrix){
  simulated_data <- MASS::mvrnorm(
    n = n,
    mu = mean_vector,
    Sigma = covariance_matrix
  )
  return(sim_data)
}

  