#' Simulating correlations
#' @description
#' This function receives instructions to simulate correlations
#'  
#' @param iter Number of simulation iterations
#' @param family Family of distributions
#' @param cor Correlation to simulate
#' @return A list of results
#' @example run_simulation(param_list)
#' 
#' 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
run_simulation <- function(n, r, mu_x = 0, mu_y = 0, sd_x = 1, sd_y = 1){
  cat("\n--- Simulation Parameters ---\n")
  cat(sprintf("Iterations: %i \n", n))
  #cat(sprintf("Family Distribution: %s \n",family))
  cat(sprintf("Correlation value: %1.2f \n", r))
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
  simulated_data <- mvrnorm(
    n = n,
    mu = mean_vector,
    Sigma = covariance_matrix
  )
  
  # 5. Convert the resulting matrix to a data frame for easier use.
  simulated_df <- as.data.frame(simulated_data)
  


  # 6. Set the column names for clarity.
colnames(simulated_df) <- c("x1", "y1")
  # Return the final data frame

#obtain correlations 
res<- cor(simulated_df$x, simulated_df$y) 
  return(res)
}


# # Set the parameters for our simulation
# num_samples <- 1000
# target_correlation <- 0.50
# 
# # Generate the dataset using the function
# my_data <- run_simulation(n = num_samples, r = target_correlation)