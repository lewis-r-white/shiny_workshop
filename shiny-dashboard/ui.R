# dashboard header ----
header <- dashboardHeader(
  
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
) # END dashboardHeader


# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  #sidebar menu
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "Welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName= "Dashboard", icon = icon("gauge"))
    
  ) #END sidebarMenu
  
) #END dashboardSidebar 



# dashboard body ----
body <- dashboardBody(
  
  #set theme ----
  fresh::use_theme("fresh_theme.css"), #don't need full file path 
  
  #tabItems ----
  tabItems(
    
    #welcome tabItem ----
    tabItem(tabName = "Welcome",
            
            # left-hand column 
            column(width = 6,
                   
                   box(width = NULL,
                       
                       title = tagList(icon("water"), 
                                       tags$strong("Monitoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"),
                       
                       tags$img(src = "map.jpeg", #don't need to type "www/map.jpeg" shiny knows
                                alt = "here is some alt text",
                                style = "max-width: 100%;"),
                       tags$h6(tags$em("Map Source:", 
                                       tags$a(href = "http://www.fishcreekwatershed.org", 
                                              "FCWO")),
                               style = "text-align: center;")
                       
                       ) # END left-box
                   
                   ), # END left-column
            
            
            # right-hand column 
            column(width = 6,
                   
                   # top fluid row
                   fluidRow(
                     
                     box(width = NULL,
                         
                         includeMarkdown("text/citation.md")
                         
                         ) # END box
                     
                   ), # END top fluid row
                   
                   # bottom fluid row
                   fluidRow(
                     
                     box(width = NULL,
                         
                         includeMarkdown("text/disclaimer.md")
                         
                         ) # END box
                     
                   ) # END bottom fluid row
                   
                   ) # END right column
            
            ), # END welcome tabItem
    
    #dashboard tabItem ----
    tabItem(tabName = "Dashboard",
            
            # fluidRow ----
            fluidRow(
              
              #input box ----
              box(width = 4, 
                  
                  title = tags$strong("Adjust lake parameter ranges:"), #strong bolds text
                  
                  # sliderInput ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above sea level):",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation), max(lake_data$Elevation)))
                  
                  ), # END input box
              
              #leaflet box ----
              box(width = 8,
                  
                  title = tags$strong("Montiored lakes within Fish Creek Watershed:"),
                  
                  #leaflet output ----
                  leafletOutput(outputId = "lake_map") %>%
                    withSpinner(type = 1, color = "darkorchid")
                  
                  ) # END leaflet box
              
            ) # END fluidRow
            
            ) # END dashboard tabItem
    
  ) # END tabItem
  
  
) #END dashboardBody

#combine all ----
dashboardPage(header, sidebar, body)