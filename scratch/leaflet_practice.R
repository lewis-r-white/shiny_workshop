library(tidyverse)

filtered_lakes <- read_csv("shiny-dashboard/data/lake_data_processed.csv")


# practice filtering 
lakes_new <- filtered_lakes %>%
  filter(avg_temp >= 4 & avg_temp <= 6)



# build leaflet map ----
leaflet() %>%
  
  # add tiles 
  addProviderTiles("Esri.WorldImagery") %>%
  
  #set view of Alaska
  setView(lng = -152,
          lat = 70,
          zoom = 6) %>%
  
  #add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) %>%
  
  # ADD MARKERS
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude,
             lat = filtered_lakes$Latitude,
             popup = paste(
               "Site Name:", filtered_lakes$Site, "<br>", #html syntax to create break
               "Elevation:", filtered_lakes$Elevation, "meters (above SL)", "<br>",
               "Avg Depth:", filtered_lakes$avg_depth, "meters", "<br>",
               "Avg Lake Bed Temperature:", filtered_lakes$avg_temp, "deg Celsius"
             ))
