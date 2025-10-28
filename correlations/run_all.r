#' Simulating correlations
#' @description
#' This function receives instructions to simulate one iteration 
#' of the correlation simulation exercrise
#' 
#' Goal: Simulate data given parameters, calculate cor, 
#' then return cor
#'  
#' @param iter Number of iterations
#' @param Paramter List Object of parameters
#' @return sample corrleation
#' @example run_simulation(param_list)
#' 
#' 
#' 
#' For use in Master's Thesis
#' Aaron Simmons
#' University of Kansas

source("correlations/run_one.r")
#sim_P[[]]

run_all <- function(iter, P,dir){

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
  furrr::future_pwalk(P, run_one_cond, iter =iter, 
    dir = dir, .progress = TRUE,
  .options = furrr::furrr_options(seed = TRUE))
  #disable the error 



 
  }

