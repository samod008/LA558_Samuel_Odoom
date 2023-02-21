library(googlesheets4)
trophieswon <- read_sheet('https://docs.google.com/spreadsheets/d/1OMpc1GZ-UHPp9wOZKmDVNGg4iO0zcQSbO1A80HZrEV8/edit?usp=sharing')

head(trophieswon)

library(tidyverse)

totalSeasonsPlayed <- trophieswon %>%
  summarize(TrophiesWon= sum(Trophies_Won))
totalSeasonsPlayed

teamWin <- trophieswon %>%
  group_by(Team) %>%
  summarize(TrophiesWon= sum(Trophies_Won),
      team_players = n())
view(teamWin)

nationalityPerWin <- trophieswon %>%
  group_by(Nationality) %>%
  summarize(TrophiesWon= sum(Trophies_Won)) %>%
  mutate(percentWins = round(TrophiesWon / sum(TrophiesWon), 3)*100) %>%
  as.data.frame()

view(nationalityPerWin)

v1<-ggplot(data=nationalityPerWin, aes(x=Nationality, y=percentWins)) +
  geom_bar(stat="identity")
v1

v1<-ggplot(data=nationalityPerWin, aes(x=Nationality, y=percentWins)) +
  geom_bar(stat="identity", width=0.5, color="blue", fill="white")
v1

v1 + labs(title="Percent Win for Each Nationality", x ="Team's Nationality", y = "Percentage")
v1


install.packages("sf")
library("sf")
iowaCounties_sf <- st_read("Counties.shp")

nebraskaCounties_sf <- st_read("Nebco.shp")

nebraskaCounties_sf <- st_read("SOCIO_County_CENSUS_2020.shp")

ggplot() + 
  geom_sf(data = nebraskaCounties_sf, size = 3, color = "black", fill = "yellow") + 
  ggtitle("Nebraska Map") + 
  coord_sf()
