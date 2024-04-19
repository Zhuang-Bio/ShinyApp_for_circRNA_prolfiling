
check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])] #Check if packages has been installed; installed.packages() return a matrix package names, library paths and version numbers.
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
}


packages <- c("shiny","shinydashboard", "shinyjs","ggplot2","RColorBrewer","V8",
            "pheatmap","zip","foreach","DT","dplyr","gtable","grid","data.table",
            "tidyverse","ggpubr","ComplexHeatmap", "circlize")
#Be careful with packages ggpubr and ComplexHeatmap (bioconductors)

check.packages(packages)

setwd("/Users/zhuliu/Desktop/circRNA/aCircRNA_profiling_manuscript/circRNA_wholebiopsy-shinyApp")

shiny::runApp()

#specify the repos as the Complexheatmap package is from bioconductor
options(repos = BiocManager::repositories())
getOption("repos")
rsconnect::deployApp()

