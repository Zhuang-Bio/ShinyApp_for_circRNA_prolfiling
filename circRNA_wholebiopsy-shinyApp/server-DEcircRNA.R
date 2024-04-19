observeEvent(input$DecircRNA.Plot,{
  withProgress(message = "Processing , please wait",{ 

    #Filter the data according to the GroupType of comparisons and different criteria
    if (input$DEcircRNA.FCtype == "greatthan") {
      de_list <- DEcircRNA.df %>% filter(.data$log2FoldChange >= input$DEcircRNA.foldChange & 
                                       .data$Grouptype == input$DEcircRNA.compares &
                                       .data$padj < input$DEcircRNA.pvalue)                        
    }
    if (input$DEcircRNA.FCtype == "lessthan") {
      de_list <- DEcircRNA.df %>% filter(.data$log2FoldChange <= input$DEcircRNA.foldChange & 
                                       .data$Grouptype == input$DEcircRNA.compares &
                                       .data$padj < input$DEcircRNA.pvalue)                      
    }
    if (input$DEcircRNA.FCtype == "both") {
      de_list <- DEcircRNA.df %>% filter(abs(.data$log2FoldChange) >= input$DEcircRNA.foldChange & 
                                       .data$Grouptype == input$DEcircRNA.compares &
                                       .data$padj < input$DEcircRNA.pvalue)  
    }

    #Further clean the data after filtering and obtain the final expression data
    exptmp <- circRNA.exp[circRNA.exp$CustomID %in% de_list$CustomID, -c(12:31)]
    colnames(exptmp) <- gsub("_FPM", "", colnames(exptmp))

    #Extract the metadata info (Groups SampleID and gene data)
    groupCom <- str_split(input$DEcircRNA.compares, "vs")[[1]]
    #First group data
    exp1 <- exptmp[,grep(groupCom[1], colnames(exptmp))]
    #Second group data
    exp2 <- exptmp[,grep(groupCom[2], colnames(exptmp))]
    #Combined the data again
    exp_com <- as.matrix(cbind(exp1, exp2))
    rownames(exp_com) <- exptmp$CustomID
    #Calculate Z scores for rows of expression matrix
    exprZscore <- t(scale(t(exp_com), center = TRUE, scale = TRUE))

    if(nrow(exprZscore) < 2){
      showNotification("Genes less than 2.", type="error")
      return()
    }
    
    ##########################################complex heatmap#######################################
    # prepare pre-data 
    rowname <- input$DEcircRNA.rownames
    if (rowname == "None") {
      show_rowname <- FALSE
    }else {
      show_rowname <- TRUE
    }   

    columnname <- input$DEcircRNA.colnames
    if (columnname == "None") {
      show_columnname <- FALSE
    }else {
      show_columnname <- TRUE
    }   

    #If cluster the gene and cells/samples
    rowcluster <- input$DEcircRNA.clusterGene
    if (rowcluster == "No") {
      cluster_row <- FALSE
    }else {
      cluster_row <- TRUE
    }   

    columncluster <- input$DEcircRNA.clusterSample
    if (columncluster == "No") {
      cluster_column <- FALSE
    }else {
      cluster_column <- TRUE
    }   

    #Extract the metadata info (Groups SampleID and gene data)
    group1.name <- as.character(groupCom[1])
    group2.name <- as.character(groupCom[2])

    anno_column <- data.frame(Group = factor(c(rep(group1.name, 5), rep(group2.name, 5))), row.names = colnames(exp_com))

    #anno_color = list(Group = c(group1.name = "#984ea3", group2.name = "#4daf4a"))

    ######################
    ###Draw the heatmap###
    ######################
    DEheatmap <- DEcomplexheatmap(
      matZval = exprZscore, 
      columnName = show_columnname, 
      rowName = show_rowname, 
      columnClu = cluster_column, 
      rowClu = cluster_row, 
      annoColumn = anno_column#, 
      #annoCol = anno_color
    )
    
    output$dePlot1 <- renderPlot({
      DEheatmap
    })
    
    output$deTable <- DT::renderDataTable({
      outdata <- copy(de_list) #data you want to show
      outdata <- outdata %>% mutate_if(is.numeric, signif, 6) #set the output decimals
      return(outdata)},
      escape = FALSE,server = FALSE,extensions = c("Buttons"), 
      options = list(dom = 'Bfrtip',buttons = c('copy', 'csv')), #'excel': some of the padj values in output are strings. So we suggest to choose the csv format.
      rownames= FALSE)

    #Set plot height using gtable package functions
    gtable_h <- convertHeight(gtable_height(DEheatmap$gtable),"inches",valueOnly = TRUE)
    legend_row <- length(unique(anno_column$Group))
    h <- max(gtable_h, legend_row/2 + 1.5)

    plot_height <- h * 70 + 150
    plotDE_pdf_height <<- h + 0.5 #the output heatmap

    output$DEcircRNA.UI <- renderUI({
      tabBox(
        title = "", width = 12,
        tabPanel("Heatmap", plotOutput("dePlot1", height = plot_height)),
        tabPanel("Data Output", DT::dataTableOutput("deTable"), style = "overflow-x: scroll;")
      )
    })
    output$downloadDEHeatmap <- downloadHandler(
      filename <- function() {
          paste0("Heatmap_defaultName", ".pdf")
      }, 
      content <- function(file) {
        pdf(file, width = 10, height = plotDE_pdf_height)
          grid::grid.newpage()
          grid::grid.draw(DEheatmap$gtable)
        dev.off()
      }
    )

  })#withProgress
})#observeEvent



