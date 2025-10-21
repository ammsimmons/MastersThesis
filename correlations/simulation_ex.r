#Example simulation code for correlations


# Load Parameters from Source
source("correlations/run_all.r")

#dat <- readr::read_csv("correlations/cor_params.csv")

x1 <- tibble::tibble(mu_x = c(10,20,15),
  sd_x = c(1, 2 ,3)) 
y1 <- tibble::tibble(mu_y=c(20,40,8), 
sd_y = c(3, 4, 2))
n <- 1000 
r <- c(0.2, 0.5, 0.9)

P_list <- tidyr::crossing(x1, y1, r, n) 


#simulation hyper-parameters
iter <- 10 # number of iterations 


estim_r <- run_all(iter, P_list)
