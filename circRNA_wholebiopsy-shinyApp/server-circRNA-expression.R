observe({
  if(input$circRNA.ID1 == "Custom_ID"){
    updateSelectizeInput(session, "circRNA.names1", choices = unique(sort(na.omit(circRNA.exp$CustomID))), server = TRUE)
  }
  if(input$circRNA.ID1 == "CircBase_ID"){
    updateSelectizeInput(session, "circRNA.names1", choices = unique(sort(na.omit(circRNA.exp$circbaseID))), server = TRUE)
  }
  if(input$circRNA.ID1 == "CIRCpedia_v2_ID"){
    updateSelectizeInput(session, "circRNA.names1", choices = unique(sort(na.omit(circRNA.exp$circPediaID))), server = TRUE)
  }
  if(input$circRNA.ID1 == "CircAtlas_v2_ID"){
    updateSelectizeInput(session, "circRNA.names1", choices = unique(sort(na.omit(circRNA.exp$circAtlasID))), server = TRUE)
  }
  if(input$circRNA.ID1 == "Coordinate_ID"){
    updateSelectizeInput(session, "circRNA.names1", choices = unique(sort(na.omit(circRNA.exp$circID))), server = TRUE)
  }
})
observe({
  if(input$circRNA.ID2 == "Custom_ID"){
  updateSelectizeInput(session, "circRNA.names2", choices = unique(sort(na.omit(circRNA.exp$CustomID))), server = TRUE)
  }
  if(input$circRNA.ID2 == "CircBase_ID"){
    updateSelectizeInput(session, "circRNA.names2", choices = unique(sort(na.omit(circRNA.exp$circbaseID))), server = TRUE)
  }
  if(input$circRNA.ID2 == "CIRCpedia_v2_ID"){
    updateSelectizeInput(session, "circRNA.names2", choices = unique(sort(na.omit(circRNA.exp$circPediaID))), server = TRUE)
  }
  if(input$circRNA.ID2 == "CircAtlas_v2_ID"){
    updateSelectizeInput(session, "circRNA.names2", choices = unique(sort(na.omit(circRNA.exp$circAtlasID))), server = TRUE)
  }
  if(input$circRNA.ID2 == "Coordinate_ID"){
    updateSelectizeInput(session, "circRNA.names2", choices = unique(sort(na.omit(circRNA.exp$circID))), server = TRUE)
  }
})

observeEvent(input$circRNAExpPlot1,{
  withProgress(message = "Processing , please wait",{
    if(input$circRNA.ID1 == "Custom_ID"){
      upcircRNAname <- toupper(input$circRNA.names1) #transform all input data into uppercase
      circRNAexp.cp <- copy(circRNA.exp) %>% drop_na(CustomID) %>% distinct(CustomID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp) <- circRNAexp.cp$CustomID #add the rownames to the data
      circRNAexp.cp$CustomID <- toupper(circRNAexp.cp$CustomID) #transform all data into uppercase
      vioplotdata1 <- circRNAexp.cp[circRNAexp.cp$CustomID %in% upcircRNAname, ] #this data is for the rownames
      viodata1 <- vioplotdata1 %>% select(c("CustomID", 32:51)) %>% 
        pivot_longer(!CustomID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }
    if(input$circRNA.ID1 == "CircBase_ID"){
      upcircRNAname <- toupper(input$circRNA.names1) #transform all input data into uppercase
      circRNAexp.cp <- copy(circRNA.exp) %>% drop_na(circbaseID) %>% distinct(circbaseID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp) <- circRNAexp.cp$circbaseID #add the rownames to the data
      circRNAexp.cp$circbaseID <- toupper(circRNAexp.cp$circbaseID) #transform all data into uppercase
      vioplotdata1 <- circRNAexp.cp[circRNAexp.cp$circbaseID %in% upcircRNAname, ] #this data is for the rownames
      viodata1 <- vioplotdata1 %>% select(c("circbaseID", 32:51)) %>% 
        pivot_longer(!circbaseID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }
    if(input$circRNA.ID1 == "CIRCpedia_v2_ID"){
      upcircRNAname <- toupper(input$circRNA.names1) #transform all input data into uppercase
      circRNAexp.cp <- copy(circRNA.exp) %>% drop_na(circPediaID) %>% distinct(circPediaID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp) <- circRNAexp.cp$circPediaID #add the rownames to the data
      circRNAexp.cp$circPediaID <- toupper(circRNAexp.cp$circPediaID) #transform all data into uppercase
      vioplotdata1 <- circRNAexp.cp[circRNAexp.cp$circPediaID %in% upcircRNAname, ] #this data is for the rownames
      viodata1 <- vioplotdata1 %>% select(c("circPediaID", 32:51)) %>% 
        pivot_longer(!circPediaID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    } 
    if(input$circRNA.ID1 == "CircAtlas_v2_ID"){
      upcircRNAname <- toupper(input$circRNA.names1) #transform all input data into uppercase
      circRNAexp.cp <- copy(circRNA.exp) %>% drop_na(circAtlasID) %>% distinct(circAtlasID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp) <- circRNAexp.cp$circAtlasID #add the rownames to the data
      circRNAexp.cp$circAtlasID <- toupper(circRNAexp.cp$circAtlasID) #transform all data into uppercase
      vioplotdata1 <- circRNAexp.cp[circRNAexp.cp$circAtlasID %in% upcircRNAname, ] #this data is for the rownames
      viodata1 <- vioplotdata1 %>% select(c("circAtlasID", 32:51)) %>% 
        pivot_longer(!circAtlasID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }
    if(input$circRNA.ID1 == "Coordinate_ID"){
      upcircRNAname <- toupper(input$circRNA.names1) #transform all input data into uppercase
      circRNAexp.cp <- copy(circRNA.exp) %>% drop_na(circID) %>% distinct(circID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp) <- circRNAexp.cp$circID #add the rownames to the data
      circRNAexp.cp$circID <- toupper(circRNAexp.cp$circID) #transform all data into uppercase
      vioplotdata1 <- circRNAexp.cp[circRNAexp.cp$circID %in% upcircRNAname, ] #this data is for the rownames
      viodata1 <- vioplotdata1 %>% select(c("circID", 32:51)) %>% 
        pivot_longer(!circID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }

    if(nrow(vioplotdata1)==0){
      return()
    }

    my_comparisons <- list(c("VU", "Skin"), c("VU", "Wound1"), c("VU", "Wound7"),
                           c("Wound1", "Skin"), c("Wound7", "Skin"), c("Wound7", "Wound1"))

    if (input$circRNA.FPM1 == "FPM") {
      vioplot1 <- vioplotFun(
        datadf = viodata1, 
        aesX = "Group",
        aesY = "FPM",
        compares = my_comparisons)
    }
    if (input$circRNA.FPM1 == "log2(FPM+1)") {
      viodata1$log2FPM <- log2(viodata1$FPM + 1)
      vioplot1 <- vioplotFun(
        datadf = viodata1, 
        aesX = "Group",
        aesY = "log2FPM",
        compares = my_comparisons)
      vioplot1 <- ggpar(vioplot1, ylab="log2(FPM+1)")
    }    

    output$vioplotout1 <- renderPlot({
      vioplot1
    })

    output$datatable1 <- DT::renderDataTable(
      {outdata1 <- vioplotdata1 %>% mutate_if(is.numeric, signif, 6) #set the output decimals
      return(outdata1)},
      escape = FALSE,server = FALSE,extensions = c("Buttons"), 
      options = list(dom = 'Bfrtip',buttons = c('copy', 'csv')), #'excel': some of the padj values in output are strings. So we suggest to choose the csv format.
      rownames= FALSE
    )

    output$circRNAExp1.UI <- renderUI({
      tabBox(
        title = "", width = 12,
        tabPanel(rownames(vioplotdata1), plotOutput("vioplotout1")),
        tabPanel("Data Output", DT::dataTableOutput("datatable1"), style = "overflow-x: scroll;")
      )
    })

    output$downloadcircRNAPlot1 <- downloadHandler(
      filename <- function() {
          paste0("circRNAexpression_violin1", ".pdf")
      }, 
      content <- function(file) {
        pdf(file, width = 8, height = 8)
          print(vioplot1)
        dev.off()
      }
    )

  })#withProgress
})#observeEvent


observeEvent(input$circRNAExpPlot2,{
  withProgress(message = "Processing , please wait",{
    if(input$circRNA.ID2 == "Custom_ID"){
      upcircRNAname2 <- toupper(input$circRNA.names2) #transform all input data into uppercase
      circRNAexp.cp2 <- copy(circRNA.exp) %>% drop_na(CustomID) %>% distinct(CustomID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp2) <- circRNAexp.cp2$CustomID #add the rownames to the data
      circRNAexp.cp2$CustomID <- toupper(circRNAexp.cp2$CustomID) #transform all data into uppercase
      vioplotdata2 <- circRNAexp.cp2[circRNAexp.cp2$CustomID %in% upcircRNAname2, ] #this data is for the rownames
      viodata2 <- vioplotdata2 %>% select(c("CustomID", 32:51)) %>% 
        pivot_longer(!CustomID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }
    if(input$circRNA.ID2 == "CircBase_ID"){
      upcircRNAname2 <- toupper(input$circRNA.names2) #transform all input data into uppercase
      circRNAexp.cp2 <- copy(circRNA.exp) %>% drop_na(circbaseID) %>% distinct(circbaseID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp2) <- circRNAexp.cp2$circbaseID #add the rownames to the data
      circRNAexp.cp2$circbaseID <- toupper(circRNAexp.cp2$circbaseID) #transform all data into uppercase
      vioplotdata2 <- circRNAexp.cp2[circRNAexp.cp2$circbaseID %in% upcircRNAname2, ] #this data is for the rownames
      viodata2 <- vioplotdata2 %>% select(c("circbaseID", 32:51)) %>% 
        pivot_longer(!circbaseID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }
    if(input$circRNA.ID2 == "CIRCpedia_v2_ID"){
      upcircRNAname2 <- toupper(input$circRNA.names2) #transform all input data into uppercase
      circRNAexp.cp2 <- copy(circRNA.exp) %>% drop_na(circPediaID) %>% distinct(circPediaID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp2) <- circRNAexp.cp2$circPediaID #add the rownames to the data
      circRNAexp.cp2$circPediaID <- toupper(circRNAexp.cp2$circPediaID) #transform all data into uppercase
      vioplotdata2 <- circRNAexp.cp2[circRNAexp.cp2$circPediaID %in% upcircRNAname2, ] #this data is for the rownames
      viodata2 <- vioplotdata2 %>% select(c("circPediaID", 32:51)) %>% 
        pivot_longer(!circPediaID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    } 
    if(input$circRNA.ID2 == "CircAtlas_v2_ID"){
      upcircRNAname2 <- toupper(input$circRNA.names2) #transform all input data into uppercase
      circRNAexp.cp2 <- copy(circRNA.exp) %>% drop_na(circAtlasID) %>% distinct(circAtlasID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp2) <- circRNAexp.cp2$circAtlasID #add the rownames to the data
      circRNAexp.cp2$circAtlasID <- toupper(circRNAexp.cp2$circAtlasID) #transform all data into uppercase
      vioplotdata2 <- circRNAexp.cp2[circRNAexp.cp2$circAtlasID %in% upcircRNAname2, ] #this data is for the rownames
      viodata2 <- vioplotdata2 %>% select(c("circAtlasID", 32:51)) %>% 
        pivot_longer(!circAtlasID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }
    if(input$circRNA.ID2 == "Coordinate_ID"){
      upcircRNAname2 <- toupper(input$circRNA.names2) #transform all input data into uppercase
      circRNAexp.cp2 <- copy(circRNA.exp) %>% drop_na(circID) %>% distinct(circID, .keep_all = TRUE) %>% as.data.frame() #Check if it has duplicates
      rownames(circRNAexp.cp2) <- circRNAexp.cp2$circID #add the rownames to the data
      circRNAexp.cp2$circID <- toupper(circRNAexp.cp2$circID) #transform all data into uppercase
      vioplotdata2 <- circRNAexp.cp2[circRNAexp.cp2$circID %in% upcircRNAname2, ] #this data is for the rownames
      viodata2 <- vioplotdata2 %>% select(c("circID", 32:51)) %>% 
        pivot_longer(!circID,names_to = "SampleID" , values_to = "FPM") %>% #prepare the data for plot
        mutate(Group=factor(rep(c("VU","Skin", "Wound1", "Wound7"), each=5), levels = c("Skin", "Wound1", "Wound7", "VU")))
    }

    if(nrow(vioplotdata2)==0){
      return()
    }

    my_comparisons <- list(c("VU", "Skin"), c("VU", "Wound1"), c("VU", "Wound7"),
                           c("Wound1", "Skin"), c("Wound7", "Skin"), c("Wound7", "Wound1"))

    if (input$circRNA.FPM2 == "FPM") {
      vioplot2 <- vioplotFun(
        datadf = viodata2, 
        aesX = "Group",
        aesY = "FPM",
        compares = my_comparisons)
    }
    if (input$circRNA.FPM2 == "log2(FPM+1)") {
      viodata2$log2FPM <- log2(viodata2$FPM + 1)
      vioplot2 <- vioplotFun(
        datadf = viodata2, 
        aesX = "Group",
        aesY = "log2FPM",
        compares = my_comparisons)
      vioplot2 <- ggpar(vioplot2, ylab="log2(FPM+1)")
    }    

    output$vioplotout2 <- renderPlot({
      vioplot2
    })

    output$datatable2 <- DT::renderDataTable(
      {outdata2 <- vioplotdata2 %>% mutate_if(is.numeric, signif, 6) #set the output decimals
      return(outdata2)},
      escape = FALSE,server = FALSE,extensions = c("Buttons"), 
      options = list(dom = 'Bfrtip',buttons = c('copy', 'csv')), #'excel': some of the padj values in output are strings. So we suggest to choose the csv format.
      rownames= FALSE
    )

    output$circRNAExp2.UI <- renderUI({
      tabBox(
        title = "", width = 12,
        tabPanel(rownames(vioplotdata2), plotOutput("vioplotout2")),
        tabPanel("Data Output", DT::dataTableOutput("datatable2"), style = "overflow-x: scroll;")
      )
    })

    output$downloadcircRNAPlot2 <- downloadHandler(
      filename <- function() {
          paste0("circRNAexpression_violin2", ".pdf")
      }, 
      content <- function(file) {
        pdf(file, width = 8, height = 8)
          print(vioplot2)
        dev.off()
      }
    )

  })#withProgress
})#observeEvent


