print("loading app...")
options(shiny.trace=TRUE)
options(port=4105)

source("global/dependencies.R")
source("config.R")
source("global/utils.R")

sourceDir("global/hmda-data", trace = FALSE)

dataProcessor <- DataProcessor$new()
dataProcessorDataFrame = dataProcessor$hmda_init()

summaryByYearStateConforming <- dataProcessor$summaryByYearStateConforming()
summaryByStateYear <- dataProcessor$summaryByStateYear()
summaryByHML <- dataProcessor$summaryByHML()

# loading tabs
sourceDir("tabs/update", trace = FALSE)
sourceDir("tabs/overview", trace = FALSE)
sourceDir("tabs/explore", trace = FALSE)

# TODO: Cleanup (rm) of any items from Global Environment that aren't needed

#runApp(appDir="HMDA", port = 4103)
