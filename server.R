function(input, output, session) {
  
  # https://github.com/rstudio/shiny-examples/blob/main/063-superzip-example/server.R
  data_bounds <- reactive({
    if (is.null(input$mapa_bounds)) {
      return(data)
    } 
    
    bounds <- input$mapa_bounds
    
    # acá está la lógica para filtrar de acuerdo a las cotas
    # se deberá modificar en caso de tener otras geometrías sf::st_join?
    data_bounds <- data |> 
      dplyr::filter(
        lat > bounds$south,
        lat < bounds$north,
        long < bounds$east,
        long > bounds$west
      )
    
    data_bounds
    
  })
  
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
  
  output$number <- renderText({
    data_bounds() |> 
      nrow() |> 
      scales::comma()
  })
  
  # output$chart <- renderHighchart({
  #   data_bounds <- data_bounds()
  #   data_bounds |> 
  #     count(mag_cat) |> 
  #     full_join(tibble(mag_cat = factor(c("Bajo", "Medio", "Alto")))) |> 
  #     mutate(n = coalesce(n, 0)) |> 
  #     arrange(mag_cat) |> 
  #     hchart("column", hcaes(mag_cat, n))
  # })
    
  
  output$chart <- renderHighchart({
    data_bounds <- data
    data_bounds |>
      count(mag_cat) |>
      full_join(tibble(mag_cat = factor(c("Bajo", "Medio", "Alto")))) |>
      mutate(n = coalesce(n, 0)) |>
      arrange(mag_cat) |>
      hchart("column", hcaes(mag_cat, n), id = "dat")
  })
  
  observeEvent(data_bounds(),{
    data_bounds <- data_bounds() 
    d <- data_bounds |>
      count(mag_cat) |>
      full_join(tibble(mag_cat = factor(c("Bajo", "Medio", "Alto")))) |>
      mutate(n = coalesce(n, 0)) |>
      arrange(mag_cat) |> 
      select(name = mag_cat, y = n) |> 
      list_parse()
    
    highchartProxy("chart") |> 
      hcpxy_update_series(id = "dat", data = d)
  })
  
}