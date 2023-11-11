# packages ----------------------------------------------------------------
library(shiny)
library(bslib)
library(leaflet)
library(tidyverse)
library(bsicons)

# data --------------------------------------------------------------------
# opcion 1
# data <- read_csv("https://raw.githubusercontent.com/Appsilon/crossfilter-demo/master/app/ships.csv")

# opcion 2
data <- as_tibble(quakes)



