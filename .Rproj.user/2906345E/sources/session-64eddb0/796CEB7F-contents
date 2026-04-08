# Anne Piron
# Avril 2026
# Carte DI - Volcan

library(leaflet) # carte interactive
library(dplyr)
library(sf) # pour les shape


# import du jeu de donnees DI global
prio_hab <-st_read("06_Prio_Volcan_2026_v3.shp")
# verification import
class(prio_hab)
plot(prio_hab)

# leaflet = WGS 84
# on transforme car on est en UTM40S
prio_hab <- st_transform(prio_hab, 4326)
#verification
st_crs(prio_hab)


# échelle de couleurs
# test 1 : pal <- colorFactor(palette = "Set2", domain = prio_hab$DI_6cat)

pal <- colorFactor(palette = c(
  "Faibles Priorités - Score inférieur à 50" = "#FDE725",
  "Priorités intermédiaires - Score compris entre 50 et 69" = "#5dc963",
  "Fortes priorités - Top 50% (score compris entre 78 et 70)" = "#21908d",
  "Très fortes priorités - Top 10% (score sup ou égal à 85)" = "#3B528B",
  "Très fortes priorités - Top 25% (score compris entre 84 et 79)" = "#440154"
), domain = prio_hab$prio_txt)


# Carte avec un point par relevé dont la couleur correspond à prio (prio_txt) 

leaflet(prio_hab) %>%
  addProviderTiles(providers$OpenTopoMap) |> # fond satellite
  #addTiles() %>%
  addPolygons(
    fillColor = ~pal(prio_txt),
    color = "black", 
    weight = 0.6,
    fillOpacity = 0.6,
    popup = ~paste0(
      "<strong>Catégorie :</strong> ", prio_txt, "<br>")
  ) %>%
  addLegend(
    "bottomright",
    pal = pal,
    values = ~prio_txt,
    title = "Niveaux de priorités de surveillance et de restauration du massif du Volcan",
    opacity = 1
  )
