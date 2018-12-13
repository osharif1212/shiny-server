dependencies <- c(
  "data.table",
  "dplyr",
  "ggplot2",
  "jsonlite",
  "R6",
  "rhandsontable",
  "RCurl",
  "shiny",
  "shinythemes",
  "httr",
  "DT"
  )

new.packages <- dependencies[!(dependencies %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) install.packages(new.packages)

lapply(dependencies, library, character.only = TRUE)

sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "[.][RrSsQq]$")) {
    if(trace) cat(nm,":")
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}

rm(dependencies, new.packages)
