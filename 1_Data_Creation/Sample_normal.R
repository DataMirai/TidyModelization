
samples_number <- readRDS("samples_parameters/samples_number.rds")
samples_size   <- readRDS("samples_parameters/samples_size.rds")


# Normal samples ----
norm_settings <- list(
  n     = as.list( rpois(samples_size,samples_size) ),
  mu    = as.list( rnorm(samples_size, 100,50)),
  sigma = as.list( abs(rnorm(samples_size, 5,10)) ) 
)

args_norm <- list(
  n    = norm_settings$n,
  mean = norm_settings$mu,
  sd   = norm_settings$sigma
  )

normal_samples<- pmap(args_norm, rnorm)


args_norm %>% 
  transpose() %>%   #Transpongo la lista: paso de una lista de largo tres con n elementos a una lista de largo n con tres elementos 
  map(unlist) -> lista_parametros_norm #Simplifico con unlist para que no me quede demasiado anidada en el paso siguiente


normal_samples <- map2(
  normal_samples,     #con map2 trabajo sobre dos listas al mismo tiempo: la de muestras y la de parámetros
  lista_parametros_norm, 
  ~list(.x, .y)) %>%  #Hago una lista nueva en la que cada elemento es un par de elementos de las listas anteriores.
  map(set_names, c("muestra", "parámetros"))  #Los nombres podrían facilitar navegar la lista más adelante, no son estrictamente necesarios.

normal_samples
