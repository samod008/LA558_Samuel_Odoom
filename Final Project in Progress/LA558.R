#see line 141 for the explanation of the error I am getting


library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(readxl)
library(sf)


DeMoinNeighborhood <- st_read("Neighborhoods.shp")

DeMoinNeighborhood <- st_transform(DeMoinNeighborhood, crs = 4326)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = DeMoinNeighborhood,  # borders of all counties
              color = "blue", fill = NA, weight = 2)
m

library("RColorBrewer")
display.brewer.all()

bins <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, Inf)
pal <- colorBin("Blues", domain = DeMoinNeighborhood$Outlets, bins = bins)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = DeMoinNeighborhood,
              fillColor = ~pal(Outlets),
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
  addPolygons(data = DeMoinNeighborhood,
              fillColor = ~pal(Outlets),
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
  "<strong>%s</strong><br/>%g alcohol outlets",
  DeMoinNeighborhood$NHNAME, DeMoinNeighborhood$Outlets
) %>% lapply(htmltools::HTML)


m <- leaflet() %>%
  setView(-93.65, 41.62, 11)  %>%
  addTiles() %>%
  addPolygons(data = DeMoinNeighborhood,
              fillColor = ~pal(Outlets),
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

m %>% addLegend(pal = pal, values = DeMoinNeighborhood, opacity = 0.7, title = "Number of Alcohol Outlets",
                position = "bottomright")


longitude<- c(-93.645, -93.516, -93.619, -93.601, -93.642, -93.597, -93.628, -93.601, -93.699, -93.635, -93.651, -93.703, -93.629, -93.597, -93.677, -93.597, -93.570, -93.559, -93.626, -93.620, -93.541, -93.597, -93.626, -93.562, -93.637, -93.635, -93.630, -93.622, -93.625, -93.660, -93.559, -93.654, -93.621, -93.614, -93.614, -93.673, -93.637, -93.597, -93.597, -93.617, -93.703, -93.673, -93.698, -93.679, -93.603, -93.651, -93.698, -93.608, -93.619, -93.625, -93.666, -93.626, -93.664, -93.597, -93.587, -93.569, -93.663, -93.601, -93.673, -93.653, -93.699, -93.559, -93.661, -93.593, -93.570, -93.659, -93.646, -93.698, -93.558, -93.620, -93.665, -93.637, -93.596, -93.635, -93.574, -93.561, -93.629, -93.541, -93.645, -93.645, -93.645, -93.545, -93.640, -93.645, -93.645, -93.649, -93.625, -93.645, -93.599, -93.645, -93.629, -93.698, -93.616, -93.619, -93.620, -93.613, -93.579, -93.601, -93.561, -93.600, -93.597)
latitude <- c(41.547, 41.644, 41.600, 41.654, 41.527, 41.555, 41.601, 41.605, 41.628, 41.555, 41.626, 41.579, 41.527, 41.556, 41.628, 41.571, 41.608, 41.601, 41.558, 41.606, 41.631, 41.554, 41.586, 41.601, 41.628, 41.538, 41.680, 41.584, 41.576, 41.600, 41.555, 41.585, 41.652, 41.606, 41.576, 41.611, 41.583, 41.595, 41.556, 41.628, 41.570, 41.600, 41.625, 41.630, 41.629, 41.627, 41.616, 41.628, 41.628, 41.586, 41.639, 41.558, 41.586, 41.572, 41.596, 41.628, 41.586, 41.601, 41.620, 41.680, 41.630, 41.600, 41.604, 41.661, 41.591, 41.600, 41.512, 41.638, 41.585, 41.605, 41.587, 41.634, 41.549, 41.532, 41.604, 41.644, 41.527, 41.631, 41.545, 41.531, 41.542, 41.629, 41.600, 41.547, 41.543, 41.600, 41.564, 41.543, 41.599, 41.548, 41.527, 41.625, 41.628, 41.643, 41.605, 41.590, 41.615, 41.653, 41.627, 41.648, 41.529)
df <- data.frame(longitude, latitude)

df_sf = st_as_sf(df, coords = c("longitude", "latitude"), crs = 4326)


bounds <- df_sf %>% 
  st_bbox() %>% 
  as.character()
#fitBounds(m, bounds[1], bounds[2], bounds[3], bounds[4])

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addCircles(data = df_sf) %>%
  fitBounds(bounds[1], bounds[2], bounds[3], bounds[4])  %>%
  addPolygons(data = DeMoinNeighborhood,
              fillColor = ~pal(Outlets),
              weight = 2,
              opacity = 1,
              color = "black",
              dashArray = "1",
              fillOpacity = 0.3,  #be careful, you need to switch the ) to a comma
              highlightOptions = highlightOptions(
                weight = 4,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.5,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto")) %>% addLegend(pal = pal, values = count, opacity = 0.7, title = "Number of Alcohol Outlets", position = "bottomright")
m







#See below for the problem I m getting

#this is the initial code that works without the polygon
map <-leaflet(df_sf) %>% 
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions())
map


#when I add the polygon as shown below it doesnt work
map <-leaflet(df_sf) %>% 
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions())
addPolygons(data = DeMoinNeighborhood,
            fillColor = ~pal(Outlets),
            weight = 2,
            opacity = 1,
            color = "black",
            dashArray = "1",
            fillOpacity = 0.3,  #be careful, you need to switch the ) to a comma
            highlightOptions = highlightOptions(
              weight = 4,
              color = "#666",
              dashArray = "",
              fillOpacity = 0.5,
              bringToFront = TRUE),
            label = labels,
            labelOptions = labelOptions(
              style = list("font-weight" = "normal", padding = "3px 8px"),
              textsize = "10px",
              direction = "auto")) %>% addLegend(pal = pal, values = count, opacity = 0.7, title = "Number of Alcohol Outlets", position = "bottomright")
map












