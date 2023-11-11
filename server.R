function(input, output, session) {

  output$mapa <- renderLeaflet({
    
    leaflet() |> 
      addProviderTiles(providers$CartoDB.Positron) |> 
      addCircleMarkers(
        data = data,
        ~ long,
        ~ lat,
        radius = 10 ,
        stroke = FALSE,
        fillOpacity = 0.8
      )
  })
  
  # https://github.com/rstudio/shiny-examples/blob/main/063-superzip-example/server.R
  data_bounds <- reactive({
    if (is.null(input$mapa_bounds)) {
      return(data)
    } 
    
    bounds <- input$mapa_bounds
    
    # acá está la lógica para filtrar de acuerdo a las cotas
    # se deberá modificar en caso de tener otras geometrías sf::st_join?
    daux <- data |> 
      dplyr::filter(
        lat > bounds$south,
        lat < bounds$north,
        long < bounds$east,
        long > bounds$west
      )
    
    daux
    
  })
  
  output$number <- renderText({
    data_bounds() |> 
      nrow() |> 
      scales::comma()
  })
    
}