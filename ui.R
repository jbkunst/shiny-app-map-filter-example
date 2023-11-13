x <- value_box(
  title = "Contenido",
  value = "123",
  showcase = bsicons::bs_icon("globe-americas"),
  theme_color = "light"
  )

page_navbar(
  theme = bs_theme(),
  lang = "es",
  fillable = TRUE,
  fillable_mobile = TRUE,
  title = "App-ex",
  sidebar = sidebar(width = 300, open = "closed", "sidebar_content", position = "right"),
  nav_panel(
    title = NULL,
    layout_columns(
      col_widths = c(6, 6),
      card(
        # card_header("Mapa")
        full_screen = TRUE,
        leafletOutput("mapa")
        ),
      layout_columns(
        col_widths = 12,
        layout_columns(
          col_widths = 6,
          value_box(
            title = "Puntos en el mapa",
            value = textOutput("number"),
            showcase = bs_icon("hash"),
            theme_color = "light"
          ),
          x,
          x,
          x),
        layout_columns(
          col_widths = 12,
          card(
            highchartOutput("chart"),
            full_screen = TRUE
            )
          )
        )
      )
    ) 
  )

  
  
  