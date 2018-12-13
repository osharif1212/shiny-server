## App server

function(input, output) {
  
  output$instData <- DT::renderDataTable(DT::datatable({
    data <- institutionDataFrame
  }))
    
  output$loanData <- DT::renderDataTable(DT::datatable({
    data <- loanDataFrame
  }))

  output$dataProcessorData <- DT::renderDataTable(DT::datatable({
    data <- dataProcessor$hmda_filter(combinedDataFrame, input$states, input$conventional_conforming)
  }))
  
  output$duplicateNamesData <- DT::renderDataTable(DT::datatable({
    data <- duplicateNames
  }))
  
  # builds a reactive expression that only invalidates 
  # when the value of input$githubUpdateButton becomes out of date 
  # (i.e., when the button is pressed)
  githubText <- eventReactive(input$githubUpdateButton, {
    dataProcessor$download_data()
    return("Data successfully updated")
  })
  
  output$githubText <- renderText({
    githubText()
  })  
  
  output$json_export <- downloadHandler(
    filename = function() { 
      paste("export", ".json", sep="") 
    },
    content = function(file) {
      jsonData <- dataProcessor$hmda_to_json(combinedDataFrame, input$states, input$conventional_conforming)
      write_json(jsonData, file)
    }
  )
  
 output$summaryByYearStateConforming<-renderPlot({
    ggplot(data=summaryByYearStateConforming, aes(x=As_of_Year, y=count, fill=State)) +
     facet_grid(. ~ Conventional_Conforming_Flag) +
      geom_bar(stat="identity", position=position_dodge()) +
      ggtitle ("Number of loans by year in each state, faceted for Conventional/Conforming")+
      xlab ("Year") +
      ylab ("Number of loans")
      
     })
 
 output$summaryByLoanState<-renderPlot({
   ggplot(data=summaryByStateYear, aes(x=As_of_Year, y=count, colour=State)) +
     geom_line(stat="identity", position=position_dodge())+
     ylab ("Number of loans") +
     xlab ("Year") +
     ggtitle ("Number of loans by year in each state")
 })
 
 output$summaryByMedianState<-renderPlot({
   ggplot(data=summaryByStateYear, aes(x=As_of_Year, y=md, colour=State)) +
     geom_line(stat="identity", position=position_dodge())+
     ylab ("Median value of loans") +
     xlab ("Year") +
     ggtitle ("Median value of loans by year in each state")
 })
  
 output$summaryByHML<-renderPlot({
   ggplot(data=summaryByHML, aes(x=As_of_Year, y=count, fill=Loan_Amount_Cat)) +
     geom_bar(stat="identity", position=position_dodge()) +
     facet_grid(. ~ State) +
     ylab ("Number of loans") +
     xlab ("Year") +
     ggtitle ("Low-Medium-High loans by year in each state") +
     labs(fill = "Loan Amt")
 })
  
}