tabItem(tabName = "circRNAexpressions",
  fluidRow(
    box(
      width = 6, title="circRNA Expression1", solidHeader = TRUE, collapsible = TRUE,
      fluidRow(
        column(4, selectInput("circRNA.FPM1", "Type:", c("FPM", "log2(FPM+1)"))),
        column(6, selectInput("circRNA.ID1", "circID Source:", c("Custom_ID", "CircBase_ID", "CIRCpedia_v2_ID", "CircAtlas_v2_ID", "Coordinate_ID")))
      ),
      fluidRow(
        column(7, selectizeInput("circRNA.names1", "circRNA Name", choices = NULL, selected=NULL, options = list(openOnFocus = FALSE))),
        column(3, style = "margin-top: 25px;", actionButton("circRNAExpPlot1", "VISUALIZATION", class = "button-3d button-block button-pill button-primary"))
      ),
    ),
    box(
      width = 6, title="circRNA Expression2", solidHeader = TRUE, collapsible = TRUE,
      fluidRow(
        column(5, selectInput("circRNA.FPM2", "Type:", c("log2(FPM+1)", "FPM"))),
        column(5, selectInput("circRNA.ID2", "circID Source:", c("CircBase_ID", "Custom_ID", "CIRCpedia_v2_ID", "CircAtlas_v2_ID", "Coordinate_ID")))
      ),
      fluidRow(
        column(7, selectizeInput("circRNA.names2", "circRNA Name", choices = NULL, selected=NULL, options = list(openOnFocus = FALSE))),
        column(3, style = "margin-top: 25px;", actionButton("circRNAExpPlot2", "VISUALIZATION", class = "button-3d button-block button-pill button-primary"))
      ),
    )
  ), 
  #hr(),
  fluidRow(
    box(
      title="circRNA Plot1", width = 6,
      uiOutput("circRNAExp1.UI")
    ),
    box(
      title="circRNA Plot2", width = 6,
      uiOutput("circRNAExp2.UI")
    )
  ),
  fixedPanel(
    downloadButton("downloadcircRNAPlot1", label = "Download circPlot1", class = "button-primary", icon = icon("download")),
    downloadButton("downloadcircRNAPlot2", label = "Download circPlot2", class = "button-primary", icon = icon("download")),
    right = 5,
    bottom = 5
  )
)

