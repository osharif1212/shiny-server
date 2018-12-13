InstitutionData <- R6Class("InstitutionData",
                      
  cloneable = FALSE,
  
  public = list(
    dataFrame = NULL,
    
    # load data from db
    load = function() {
      self$dataFrame <- data.frame(ingestfile("institutions"))
    }
    
  )
)