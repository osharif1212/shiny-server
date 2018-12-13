DataProcessor <- R6Class("DataProcessor",
  
  public = list(
    
    # load data from file
    hmda_init = function() {
      
      # check if data exists, if not, download from Github
      if (!dir.exists(file.path("data-challenge-data-master"))) {
        print("data-challenge-data-master data files missing; downloading ...")
        self$download_data()
      }
      
      # load the loan data
      loanData <- LoanData$new()
      print("Loading loan data ...")
      loanDataFrame <<- loanData$load()
      
      # Remove outliers from loan data
      print("Removing outliers from loan data ...")
      loanDataFrame <- self$data_quality_loan_outliers();
      
      # load the institution data
      institutionData <- InstitutionData$new()
      print("Loading institution data ...")
      institutionDataFrame <<- institutionData$load()
      
      # Merge cleansed loan data with institution data
      print("Merging cleansed loan data with institution data ...")
      combinedDataFrame <<- data.frame(inner_join(loanDataFrame, institutionDataFrame))
  
      print("Identifying data quality issues ...")
      duplicateNames <<- self$data_quality_resp_names()
      
    },
    
    # Filters hmda_data based on state and conventional/conforming flag
    hmda_filter = function(data = combinedDataFrame, states = c("VA", "WV"), conventional_conforming = c("Y", "N")) {
      data <- combinedDataFrame
      output <- data[(data$State %in% states & data$Conventional_Conforming_Flag %in% conventional_conforming),]
      #output <- data.frame(output[1:500,])
      return (output)
    },
    
    # Converts hmda_data to JSON
    hmda_to_json = function(data = combinedDataFrame, states = c("VA"), conventional_conforming = c("Y")) {
      output <- self$hmda_filter(data, states, conventional_conforming)
      jsondf <- data.frame(output[1:500,])
      print("Converting to JSON ...")
      x <- toJSON(unname(split(jsondf, 1:nrow(jsondf))))
      return (x)
    },
    
    # Remove outliers from loan data
    data_quality_loan_outliers = function() {
      outlier_values <- boxplot.stats(loanDataFrame$Loan_Amount_000)$out 
      in_scope_loans <- loanDataFrame$Loan_Amount_000 < min(outlier_values)
      loanDataFrame <- loanDataFrame[in_scope_loans,]
      loanDataFrame$Loan_Amount_Cat <- cut(loanDataFrame$Loan_Amount_000, 3, include.lowest = FALSE, labels = c("Low", "Medium", "High"))
      return (loanDataFrame)
    },
    
    # Identify data quality issues / duplicate respondent names
    data_quality_resp_names = function() {
      byRespondentName <- group_by(combinedDataFrame, Respondent_Name_TS, Respondent_ID)
      summaryNames <- summarize(byRespondentName,count=n())
      summaryNames <- data.frame(summaryNames)
       
      byRespID <- group_by(summaryNames, Respondent_ID)
      summaryID <- summarize(byRespID, count=n())
      summaryID <- summaryID[summaryID$count > 1, ]
      duplicateNames <- inner_join(summaryID, summaryNames, by="Respondent_ID")
      
      # Cleanup
      rm(summaryID, byRespID, byRespondentName, summaryNames)
      return (duplicateNames)
    },

    download_data = function() {
      # Data fetcher R6 class
      hmdaDataFetcher <- HmdaDataFetcher$new()
      print("Authenticating and downloading data from Github ...")
      hmdaDataFetcher$downloadData()
      self$hmda_init()
    },
    
    summaryByYearStateConforming = function() {
      byYear <- group_by(combinedDataFrame, As_of_Year, State, Conventional_Conforming_Flag)
      summaryRes <- summarize(byYear,count=n(), mn=mean(Loan_Amount_000) , md=median(Loan_Amount_000))
      summaryRes <- data.frame(summaryRes)
    },

    summaryByStateYear = function() {
      byState <- group_by(combinedDataFrame, State, As_of_Year)
      summaryRes <- summarize(byState,count=n(), mn=mean(Loan_Amount_000) , md=median(Loan_Amount_000))
      summaryRes <- data.frame(summaryRes)
    },
    
    summaryByHML = function() {
      byYearHML <- group_by(combinedDataFrame, As_of_Year, State, Loan_Amount_Cat)
      summaryRes <- summarize(byYearHML,count=n())
      summaryRes <- data.frame(summaryRes)
    }
    
  )
)

