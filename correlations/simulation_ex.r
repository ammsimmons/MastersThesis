# Example simulation code for correlations


########## HELPFUL SITES
# https://tidyverse.org/blog/2023/05/purrr-walk-this-way/#fn:2
##########

######################
# Load helper simulation functions via Source
######################
source("correlations/run_all.r")



#####################################
# Parameters 
#####################################

# Create parameter values here
x1 <- tibble::tibble(mu_x = c(10,20,15),
sd_x = c(1, 2 ,3)) 
y1 <- tibble::tibble(mu_y=c(20,40,8), 
sd_y = c(3, 4, 2))
n <- 1000  #samples per simulation 
r <- c(0.2, 0.5, 0.9)
P<- tidyr::crossing(x1, y1, r, n)
P_list<-as.list(P)

####################################
# File Management 
####################################
fs:::dir_create("correlations/data") #doesn't overwrite if exists
ncond <- nrow(P)
paths <- as.vector(str_glue("correlations/data/r_C{seq_len(ncond)}.csv"))
#path_list <- map(seq_len(length(P_list)), \(.x) paths)
P_list$fname <- paths

#P_list$paths <- paths

#####################################
# Simulation Hyper Parameters 
#####################################
iter <- 5 # number of iterations per simulation 


# Note, iter*conditions = total number of simulations 
# e.g., 10 iter * (3 x 3 x 3) = 270 simulations with 10 simulations per list
# length(estim_r) is number of lists within estim_r (or blocks of simulations)
# sum(lengths(estim_r)) is number of simulations total

estim_r <- run_all(iter, P_list)


