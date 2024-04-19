library(shiny)
library(shinydashboard)
library(shinyjs)
library(data.table)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(V8) #required by shinyjs
library(pheatmap)
library(ComplexHeatmap)
library(circlize)
library(zip)
library(foreach)
library(DT)
library(dplyr)
library(gtable)
library(grid)
library(ggpubr)



ui <- tagList(
    dashboardPage(
        dashboardHeader(
            title = "The landscape of circular RNA in human skin wound healing and venous ulcers",
            titleWidth = "95%"),
        dashboardSidebar(
            sidebarMenu(
                id = "tabs", #if id="tabs", then input$tabs will be the tabName of the currently-selected tab. If you want to be able to bookmark and restore the selected tab, an id is required.
                menuItem("circRNA expression", tabName = "circRNAexpressions", icon = icon("shapes","fa-1.5x")), # 1.5x normal size                
                menuItem("DE circRNA analysis", tabName = "TabDEcircRNA", icon = icon("holly-berry","fa-1.5x"))
            )#,
            #tags$style(HTML(".main-sidebar { font-size: 15px; }")) #set the sidebar names font sizes
        ),
        dashboardBody(
            shinyjs::useShinyjs(),
            extendShinyjs(script = "www/custom.js", functions=c()),
            tags$head(
                tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"), 
                tags$link(rel = "stylesheet", type = "text/css", href = "buttons.css")
            ),
            #type: Specifies the media type of the linked document
            #rel:  Required. Specifies the relationship between the current document and the linked document. rel = "stylesheet" specifies a persistent or preferred style while rel="alternate" defines an alternate style. 
            #href: Specifies the location of the linked document (URL).
            tabItems(
                source("ui-tab-circRNA-expression.R", local = TRUE)$value,
                source("ui-tab-DEcircRNA.R", local = TRUE)$value
            )
        )
    ),
    tags$footer(
        HTML(
          '
           <p align="center" style="margin:10px;font-size:15px">© 2021 Zhuang Liu<br>
                <a href="https://www.xulandenlab.com/data" target="_blank">Xu Land&#233;n Laboratory | Karolinska Institutet</a> 
           </p>
          '
          )
    )
)
