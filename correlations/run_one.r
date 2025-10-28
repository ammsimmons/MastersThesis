#' Simulating correlations
#' @description
#' This function receives instructions to simulate one iteration 
#' of the correlation simulation exercrise
#' 
#' Goal: Simulate data given parameters, calculate cor, 
#' then return cor
#'  
#' @param n number of samples in dataset
#' @param r Correlation to simulate
#' @param mu_x
#' @param mu_y
#' @param sd_x
#' @param sd_y description
#' @return sample corrleation
#' @example run_simulation(param_list)
#' 
#' 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
#' University of Kansas
source("correlations/gen_data.r")

 run_one <- function(mu_x,sd_x,mu_y,sd_y,r,n,...){
  
  #print(iter) 
   
   #write out conditions 
  #conds <- c(mu_x,sd_x,mu_y,sd_y,r)
  
  
   #cat(mu_x, mu_y, sd_x, sd_y, r, n, sep = " ")
  # Input validation for the correlation coefficient
  if (r < -1 || r > 1) {
    stop("Correlation coefficient 'r' must be between -1 and 1.")
  }
  
  # 1. Define the mean vector for the two variables.
  mean_vector <- c(mu_x, mu_y)
  
  # 2. Calculate the required covariance from the desired correlation.
  # The formula is: cov(x,y) = r * sd(x) * sd(y)
  covariance <- r * sd_x * sd_y
  
  # 3. Construct the 2x2 covariance matrix.
  # The diagonal elements are the variances (sd^2).
  # The off-diagonal elements are the covariances.
  covariance_matrix <- matrix(
    c(sd_x^2, covariance,
      covariance, sd_y^2),
    nrow = 2,
    byrow = TRUE
  )
  
  # 4. Generate the data using a multivariate normal distribution.
  # The mvrnorm function from the MASS package does this for us.
  # It takes the number of samples (n), the means, and the covariance matrix.
  simulated_data <- MASS::mvrnorm(
    n = n,
    mu = mean_vector,
    Sigma = covariance_matrix
  )
  
# 4.5 Something here to transform the marginal distributions of MVrnorm 
# if desired 
   
  # 5. Convert the resulting matrix to a data frame for easier use.
  simulated_df <- as.data.frame(simulated_data)
  
  # 6. Set the column names for clarity.
  colnames(simulated_df) <- c("x1", "y1")
  # Return the final data frame

  #obtain correlation for one simulation  
  cor_result <- stats::cor(simulated_df$x1, simulated_df$y1)


  return(cor_result)
   

   
 }


run_one_cond <- function(..., iter = 1) {
   #,mu_y,sd_x,sd_y,r,n,path
  #print(fname)
  res <- purrr::map_dbl(.x = seq_len(iter), .f = run_one, ...)
  print(res)
  args <- list(...)
  conds <- with(args, sprintf("%.2f_%.2f_%.2f_%.2f_%.2f.csv", mu_x,sd_x,mu_y,sd_y,r))



  #output & write
  out <- tibble(estimate = res)
  write_csv(out,file = file.path(args$dir,conds))
  
}