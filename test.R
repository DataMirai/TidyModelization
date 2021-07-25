setting_n <- 2 

# Normal samples ----
norm_settings <- list(
  n     = as.list( rep(setting_n,setting_n)),
  mu    = as.list( rnorm(setting_n, 100,50)),
  sigma = as.list( abs(rnorm(setting_n, 5,10)) ) 
)

args_norm <- list(
  n    = norm_settings$n,
  mean = norm_settings$mu,
  sd   = norm_settings$sigma)

normal_samples<-list("Sample"=pmap(args_norm, rnorm))
normal_samples


normal_samples$Distribution<-args_norm

map(normal_samples,"mean")
