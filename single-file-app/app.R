# load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

# ui ---- 
#establishes a webpage with rows and columns that adjusts based on size of browser window. 

ui <- fluidPage(    
  #app title ----
  tags$h1("Happy Feet"),    #h1 specifies this is a header 1 title
  
  #app subtitle ----
  tags$p(tags$strong("Exploring Antarctic Penguin Data")),
  
  # body mass sliderInput ----
  sliderInput(inputId = "body_mass_input",
              label = "select a range of body masses (g):",
              min = 2700, max = 6300,
              value = c(3000, 4000)),
  
  # body mass plot output ----
  imageOutput(outputId = "bodyMass_scatterPlot"),
  
  
  #year check box input
  checkboxGroupInput(inputId = "year_input",
                     label = "Select year(s) of interest",
                     choices = c("year 2007" = 2007, 2008, 2009), #unique(penguins$year)
                     selected = c(2007, 2008)),
  
  # DT output ----
  DT::dataTableOutput(outputId = "penguins_table")
  
  
)  #END fluidPage

# server ----
server <- function(input, output) {
  
  #filter data ----
  body_mass_df <- reactive({
    
    penguins %>%
      filter(body_mass_g %in% input$body_mass_input[1]:input$body_mass_input[2])
    
  })
    
  
  # render scatter plot ----
  output$bodyMass_scatterPlot <- renderPlot({
    
    ggplot(na.omit(body_mass_df()),  #when plotting reactive data frame, NEED to put parentheses after the data frame 
           aes(x = flipper_length_mm, y = bill_length_mm,
               color = species, shape = species)) + 
      geom_point() +
      theme_classic() +
      scale_color_manual(values = c("Adelie" = "#FEA346", 
                                    "Chinstrap" = "#B251F1",
                                    "Gentoo" = "#4BA4A4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15))
    
  }) # END render scatter plot
  
  # filter years ----
  filtered_years <- reactive({
    
    penguins %>%
      filter(year %in% c(input$year_input))
    
  })
  
  # render DT ----
  output$penguins_table <- renderDataTable({
    
    #make DT
    DT::datatable(filtered_years())

    
  }) # END render penguins table
  
} # END server 

# combine ui & server ----
shinyApp(ui = ui, server = server)