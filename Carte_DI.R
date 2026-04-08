# Anne Piron
# Avril 2026
# Carte DI - Volcan

library(leaflet) # carte interactive
library(dplyr)
library(sf) # pour les shape


# import du jeu de donnees DI global
di_global <-st_read("06_Prio_Volcan_2026_v3.shp")
# verification import
class(di_global)
plot(di_global)

# leaflet = WGS 84
# on transforme car on est en UTM40S
di_global <- st_transform(di_global, 4326)
#verification
st_crs(di_global)


# échelle de couleurs
# test 1 : pal <- colorFactor(palette = "Set2", domain = di_global$DI_6cat)

# reordonne la légende avant tout
di_global$DI_6cat <- factor(
  di_global$DI_6cat,
  levels = c(
     "intact",
     "peu envahi (1)",
     "peu envahi (2)",
     "moyennement envahi (3)",
     "moyennement envahi (4)",
     "très envahi (5)",
     "très envahi (6)"))

pal <- colorFactor(palette = c(
    "intact" = "#00994C",
    "peu envahi (1)" = "#73C754",
    "peu envahi (2)" = "#C1DEB6",
    "moyennement envahi (3)" = "#FFF558",
    "moyennement envahi (4)" = "#FF8000",
    "très envahi (5)" = "#E95427",
    "très envahi (6)" = "#B52D04"
    ), domain = di_global$DI_6cat)


# Carte avec un point par relevé dont la couleur correspond à l'enjeu (DI_6cat) 

leaflet(di_global) %>%
  addProviderTiles(providers$OpenTopoMap) |> # fond satellite
  #addTiles() %>%
  addPolygons(
    fillColor = ~pal(DI_6cat),
    color = "black", 
    weight = 0.6,
    fillOpacity = 0.6,
    popup = ~paste0(
      "<strong>Catégorie :</strong> ", DI_6cat, "<br>")
  ) %>%
  addLegend(
    "bottomright",
    pal = pal,
    values = ~DI_6cat,
    title = "DI",
    opacity = 1
  )
