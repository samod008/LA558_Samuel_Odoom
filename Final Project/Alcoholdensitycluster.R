# For this I decided to create this new file as I was running into errors trying to continue with the previous code file named "LA558.R"

install.packages(c("tidyverse", "readxl", "sf", "leaflet", "leaflet.providers", "RColorBrewer"))

#Load libraries
library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(readxl)
library(sf)
library(htmltools)

library("RColorBrewer")
# display.brewer.all()

#load the polygons
DSMneighborhoods <- st_read("Neighborhoods.shp")
DSMneighborhoods <- st_transform(DSMneighborhoods, crs = 4326)

#load the pointfile
alcoholstores <- st_read("outlets.shp")
alcoholstores <- st_transform(alcoholstores, crs = 4326)

#this is actually not used as I used paletteNum instead

#bins <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, Inf)
#pal <- colorBin("Blues", domain = DeMoinNeighborhood$Outlets, bins = bins)

#for the Chloropleth county outlines
paletteNum <- colorNumeric('Blues', domain = DSMneighborhoods$Outlets)

#define the Chloropleth layer labels. The $s is replaced with the first field 
#IowaCounties$COUNTY while the value IowaCounties$TOT_POP is represented with %g
labels <- sprintf(
  "<strong>%s</strong><br/>%g",
  DSMneighborhoods$NHNAME, DSMneighborhoods$Outlets
) %>% lapply(htmltools::HTML)


#Created density map
map <-leaflet() %>% 
  setView(-93.65, 41.62, 11)  %>%
  addTiles() %>%
  # addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions()) 
  addPolygons(data = DSMneighborhoods,
      fillColor = ~paletteNum(DSMneighborhoods$Outlets),
      weight = 2,
      opacity = 1,
      color = "black",
      dashArray = "1",
      fillOpacity = 0.9,  #be careful, you need to switch the ) to a comma
      highlightOptions = highlightOptions(
        weight = 4,
        color = "#666",
        dashArray = "",
        fillOpacity = 0.9,
        bringToFront = TRUE),
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "10px",
        direction = "auto")
  ) %>% 
  addLegend(pal = paletteNum, values = DSMneighborhoods$Outlets, opacity = 0.7, title = "Number of alcohol stores", position = "bottomright")
map




#Added cluster options

map <-leaflet() %>% 
  setView(-93.65, 41.62, 11)  %>%
  addTiles() %>%
  # addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions())
  addMarkers(data = alcoholstores, 
             label = alcoholstores$Store_Name,
             clusterOptions = markerClusterOptions(
               #options for cluster markers goes here. https://search.r-project.org/CRAN/refmans/leaflet/html/map-options.html
               zoomToBoundsOnClick = TRUE #this was an option I added
             )
  ) %>%
  addPolygons(data = DSMneighborhoods,
              fillColor = ~paletteNum(DSMneighborhoods$Outlets),
              weight = 2,
              opacity = 1,
              color = "black",
              dashArray = "1",
              fillOpacity = 0.9,  #be careful, you need to switch the ) to a comma
              highlightOptions = highlightOptions(
                weight = 4,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.9,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto")
  ) %>% 
  addLegend(pal = paletteNum, values = DSMneighborhoods$Outlets, opacity = 0.7, title = "Number of alcohol stores", position = "bottomright")
map