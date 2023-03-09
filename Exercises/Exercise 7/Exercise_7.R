install.packages("leaflet", "plotly")


library(leaflet)
library(tidycensus)
library(tidyverse)
library(readxl)

leaflet(options = leafletOptions(minZoom = 0, maxZoom = 2))

map <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng= 2.2945, lat=48.8584, popup="The Eiffel Tower") %>%
  setView(lng= 2.2945, lat=48.8584, zoom = 20)
map  # Print the map


map %>% setView(lng= 2.2945, lat=48.8584, zoom = 20)