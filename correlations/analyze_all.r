

source("correlations/analyze_one_file.r")


analyze_all <- function(P, N_sim, dir){
   furrr::future_pmap_dfr(P, analyze_one_file,
    N_sim = N_sim, dir = dir, .progress = TRUE,
  .options = furrr::furrr_options(seed = TRUE))

}










