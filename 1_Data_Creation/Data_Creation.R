
pacman::p_load(tidyverse, broom)


n_samples   <- 50
sample_size <- 100

saveRDS(n_samples, "samples_parameters/samples_number.rds")
saveRDS(sample_size, "samples_parameters/samples_size.rds")

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


Example_sample<- replicate(n = 10,
                           unlist( 
                             sample( 
                               list(
                                 sample(pmap(args_binom, rbinom),1),
                                 sample(pmap(args_exp  , rexp),1),
                                 sample(pmap(args_norm , rnorm),1)),1 )),
                           simplify = FALSE )

rm(list() )
