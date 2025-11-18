
analyze_one <- function(mu_x,sd_x,mu_y,sd_y,r,...){

  #load data per file 
  fname<- sprintf("%.2f_%.2f_%.2f_%.2f_%.2f.csv", mu_x,sd_x,mu_y,sd_y,r)
  dat <- read.csv(file.path(dir,fname))

  # Analysis Criterion #1: Estimation Accuracy

  #Bias in Estimate
  mean_r<- mean(dat$cor) #average correlation across all simulation
  estim_bias <- (mean_r - r)/r  # bias in estimate (Muthen & Muthen)

  mae <- mean(r - dat$cor) #mean absolute error (van Oest, 2019) 

  #Bias in SE 

  sd_sim <- sd(dat$cor) #simulated SE 
  se_per_sim <- (1- r^2) / (sqrt(N_sim - 3)) # analytic correlation SE (Gnambs,2023)
  se_bias <- (se_per_sim - sd_sim)/(se_per_sim)


  # Criterion #2: Coverage rates of confidence intervals (Muthen & Muthen 2002)
  coverage_r <- sum(dat$CI)/N_sim
  
  res <- data.frame(Cond = fname, bias_cor = estim_bias, MAE = mae, 
    bias_se = se_bias, coverage = coverage_r)
  
  
}




analyze_one_file <- function(..., N_files = 1) {

  res <- purrr::map_dfr(.x = seq_len(N_files), .f = analyze_one, ...)
  #args <- list(...)
  #conds <- with(args, sprintf("%.2f_%.2f_%.2f_%.2f_%.2f.csv", mu_x,sd_x,mu_y,sd_y,r))
  #print(res)
  #out<- dplyr::bind_rows(res)
  #write_csv(bind_rows(res),file = file.path(args$dir,conds))
}

