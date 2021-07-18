pacman::p_load(tidyverse, broom)


setting_n <- 5 

# Normal samples ----
norm_settings <- list(
  n     = as.list( rep(setting_n,setting_n)),
  mu    = as.list( rnorm(setting_n, 100,50)),
  sigma = as.list( abs(rnorm(setting_n, 5,10)) ) 
)

args_norm <- list(
  mean = norm_settings$mu,
  sd   = norm_settings$sigma, 
  n    = norm_settings$n)

normal_samples<- pmap(args_norm, rnorm)
# extraer los elementos que compone la distribucion con map¿?
args_norm
normal_samples[1][2] <- args_norm$mean[1]
normal_samples

# Exponential samples ----

exponential_settings<-list(
  n      = as.list(rep(setting_n,setting_n)),
  lambda = as.list( 1/cumsum(1:setting_n) )
)

args_exp <- list(
  rate = exponential_settings$lambda, 
  n    = exponential_settings$n)

pmap(args_exp, rexp)

# Binomial samples ----

binomial_settings <- list(
  n    = as.list( rep(setting_n,setting_n)),
  size = as.list( seq(1,setting_n,1)) ,
  prob = as.list( runif(setting_n,min = 0,max=1) )
)

args_binom<- list(
  n = binomial_settings$n ,
  size = binomial_settings$size,
  prob = binomial_settings$prob)

pmap(args_binom, rbinom)

# Sample generation under random distribution


replicate(n = 10,
          unlist( 
            sample( 
              list(
                sample(pmap(args_binom, rbinom),1),
                sample(pmap(args_exp  , rexp),1),
                sample(pmap(args_norm , rnorm),1)),1 )),
          simplify = FALSE )


