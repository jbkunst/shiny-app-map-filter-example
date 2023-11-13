# packages ----------------------------------------------------------------
library(shiny)
library(bslib)
library(tidyverse)
library(bsicons)
library(leaflet)
library(highcharter)

# data --------------------------------------------------------------------
# opcion 1
# data <- read_csv("https://raw.githubusercontent.com/Appsilon/crossfilter-demo/master/app/ships.csv")

# opcion 2
data <- as_tibble(quakes) |> 
  mutate(mag_cat = ggplot2::cut_interval(mag, 3))

levels(data$mag_cat) <-  c("Bajo", "Medio", "Alto")


