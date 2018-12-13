LoanData <- R6Class("LoanData",
                      
  cloneable = FALSE,
  
  public = list(
    
    dataFrame = NULL,
    
    # load data from file
    load = function() {
      self$dataFrame <- data.frame(ingestfile("loans"))
    }
  
  )
)
