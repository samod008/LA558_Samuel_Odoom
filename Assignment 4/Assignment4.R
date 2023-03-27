install.packages("leaflet", "leaflet.providers")

library(leaflet)
library(leaflet.providers)
library(tidyverse)


buildingGroup1 <- read.csv("BuildingLocations1.csv", header = TRUE)
buildingGroup2 <- read.csv("BuildingLocations2.csv", header = TRUE)
myData <- buildingGroup1


map <- leaflet(myData) %>% 
  addTiles() %>%
  addMarkers(~Longitude, ~Latitude)
map



map <- leaflet(myData) %>% 
  addTiles() %>%
  addCircles(~Longitude, ~Latitude, label = myData$Country)
map


map <- leaflet(myData) %>% 
  addTiles() %>%
  addCircles(~Longitude, ~Latitude, popup = paste("<strong>", 
  myData$Place_Name, "</strong><br>", "Continent: ", 
 myData$Continent))
map


map <- leaflet(myData) %>% 
  addTiles() %>%
  addCircles(~Longitude, ~Latitude, popup= paste("<strong>", 
                                                 myData$Place_Name, "</strong><br>", "Continent: ", 
                                                 myData$Continent), weight = 10, radius=2000, 
             color="purple", stroke = TRUE, fillOpacity = 0.8)
map


names(providers)


map <- leaflet(myData) %>% 
  addTiles(group = "OSM", options = providerTileOptions(minZoom = 1, maxZoom = 50)) %>%
  addProviderTiles("Stamen.TopOSMRelief", group = "Relief", 
                   options = providerTileOptions(minZoom = 1, maxZoom = 50)) %>%
  addProviderTiles("Stamen.Terrain", group = "Terrain") %>%
  addProviderTiles("Esri.WorldShadedRelief", group = "Topo") %>%
  addProviderTiles("OpenWeatherMap.Temperature", group = "Temperature") %>%
  addProviderTiles("CartoDB.VoyagerOnlyLabels", group = "Voyager") %>%
  addLayersControl(baseGroups = c("OSM", "Relief", "Terrain", "Topo", "Temperature", "Voyager"),
                   options = layersControlOptions(collapsed = TRUE)) %>%
  addCircles(~Longitude, ~Latitude, popup= paste("<strong>", 
                                                 myData$Place_Name, "</strong><br>", "Continent: ", 
                                                 myData$Continent), weight = 10, radius=200, 
             color="purple", stroke = TRUE, fillOpacity = 0.8)
map


map <- leaflet(myData) %>% 
  addProviderTiles("Stamen.Terrain", 
                   options = providerTileOptions(minZoom = 1, maxZoom = 50))%>%
  addMarkers(~Longitude, ~Latitude, clusterOptions = markerClusterOptions())
map

library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(readxl)
library(sf)

nebraskaCounties <- st_read("SOCIO_County_CENSUS_2020.shp")

nebraskaCounties <- st_transform(nebraskaCounties, crs = 4326)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = nebraskaCounties,  # borders of all counties
              color = "blue", fill = NA, weight = 1)
m

nebraskaCounties_selection1 <- nebraskaCounties %>% 
  filter(NAME %in% c("Otoe", "Sarpy"))

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = nebraskaCounties_selection1,  # borders of all counties
              color = "#ffff00", fillColor = "blue", weight = 5, opacity = 0.75)
m

library("RColorBrewer")
display.brewer.all()

bins <- c(0, 5, 10, 15, 20, 25, 30, 35, 40, Inf)
pal <- colorBin("Reds", domain = nebraskaCounties$Vacancyper, bins = bins)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = nebraskaCounties,
              fillColor = ~pal(Vacancyper),
              weight = 0.5,
              opacity = 1,
              color = "black",
              dashArray = "1",
              fillOpacity = 0.8)
m

# Add interaction
m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = nebraskaCounties,
              fillColor = ~pal(Vacancyper),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "1",
              fillOpacity = 0.8,  #be careful, you need to switch the ) to a comma
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "4",
                fillOpacity = 0.7,
                bringToFront = TRUE)
  )
m

labels <- sprintf(
  "<strong>%s</strong><br/>%g vacant houses",
  nebraskaCounties$NAME, nebraskaCounties$Vacancyper
) %>% lapply(htmltools::HTML)


m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = nebraskaCounties,
              fillColor = ~pal(Vacancyper),
              weight = 0.5,
              opacity = 1,
              color = "black",
              dashArray = "1",
              fillOpacity = 0.8,  
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto"))
m

m %>% addLegend(pal = pal, values = nebraskaCounties, opacity = 0.7, title = "Percentage of Vacant Houses",
                position = "bottomright")


longitude<- c(-101.6, -101.1, -100.4)
latitude <- c(41.1, 41.6, 40.5)
df <- data.frame(longitude, latitude)


df_sf = st_as_sf(df, coords = c("longitude", "latitude"), crs = 4326)

bounds <- df_sf %>% 
  st_bbox() %>% 
  as.character()
#fitBounds(m, bounds[1], bounds[2], bounds[3], bounds[4])

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addMarkers(data = df_sf) %>%
  fitBounds(bounds[1], bounds[2], bounds[3], bounds[4])  %>%
  addPolygons(data = nebraskaCounties,
              fillColor = ~pal(Vacancyper),
              weight = 0.5,
              opacity = 1,
              color = "black",
              dashArray = "1",
              fillOpacity = 0.8,  #be careful, you need to switch the ) to a comma
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto")) %>% addLegend(pal = pal, values = count, opacity = 0.7, title = "Percentage of Vacant Houses", position = "bottomright")
m


bounds <- df_sf %>% 
  st_bbox() %>% 
  as.character()
fitBounds(m, bounds[1], bounds[2], bounds[3], bounds[4])


bounds <- nebraskaCounties %>% 
  st_bbox() %>% 
  as.character()
fitBounds(m, bounds[1], bounds[2], bounds[3], bounds[4])

library(htmlwidgets)

saveWidget(m, file="m.html")

saveWidget(m, "leaflet2.html", selfcontained = F, libdir = "lib")

