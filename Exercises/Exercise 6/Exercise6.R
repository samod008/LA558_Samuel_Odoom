library(tidycensus)
options(tigris_use_cache = TRUE)

pop20 <- get_decennial(
  geography = "state",
  variables = "P1_001N",
  year = 2020
)


library(tidycensus)
options(tigris_use_cache = TRUE)

# If necessary, set the API key
census_api_key("b501912c918d329bfa535a62614ac2f3bb57e694")

ca_population <- get_decennial(
  geography = "county",
  variables = "P1_001N",
  state = "CA",
  year = 2020,
  geometry = TRUE #<<
  
  plot(ca_population$geometry)
) 

ca_population


plot(ca_population["value"])


library(ggplot2)

