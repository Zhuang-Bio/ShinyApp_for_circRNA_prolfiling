server <- function(input, output, session) {
    
    circRNA.exp <- readRDS('data/circRNA_exp.rds')
    DEcircRNA.df <- readRDS('data/DEcircRNA_df.rds')

    source("app-functions.R")

    source("server-circRNA-expression.R", local = TRUE)
    source("server-DEcircRNA.R", local = TRUE)
    
    GotoTab <- function(name){
        shinyjs::show(selector = paste0("a[data-value=\"",name,"\"]"))
       
        shinyjs::runjs("window.scrollTo(0, 0)")
    }
}
