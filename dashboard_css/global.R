
# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(tidyverse)
library(palmerpenguins)
library(sass)


# Compile CSS ----
sass::sass(input = sass_file("R/sass_styles.scss"),
           output = "www/sass_styles.css")