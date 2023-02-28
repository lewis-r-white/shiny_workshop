server <- function(input, output) {
  
  #filter lake data ----
  filtered_lakes <- reactive({
    
    lake_data %>% filter(
      Elevation >= input$elevation_slider_input[1],
      Elevation <= input$elevation_slider_input[2])
    
  })
  
  # build leaflet map ----
  output$lake_map <- renderLeaflet({
    
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
      
    #ADD MARKERS
    addMarkers(data = filtered_lakes(),
               lng = filtered_lakes()$Longitude,
               lat = filtered_lakes()$Latitude,
               popup = paste(
                 "Site Name:", filtered_lakes()$Site, "<br>", #html syntax to create break
                 "Elevation:", filtered_lakes()$Elevation, "meters (above SL)", "<br>",
                 "Avg Depth:", filtered_lakes()$avg_depth, "meters", "<br>",
                 "Avg Lake Bed Temperature:", filtered_lakes()$avg_temp, "deg Celsius"
               ))
    
  })
}