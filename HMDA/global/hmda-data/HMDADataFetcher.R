HmdaDataFetcher <- R6Class( "HmdaDataFetcher",
  
  public = list(
    
    downloadData = function () {
      
      # allow for downloading of data, in case there is new data, it can also be consumed
      # assumption is folder names will be the same
      
      # login to Capital One github repo and download master zip
      tmp <- "data-challenge-data.zip"
      print("Fetching data files ...")
      GET(CONFIG$git_repo, authenticate(CONFIG$git_username, CONFIG$git_pass), write_disk(tmp))
      
      # unzip the file
      print("Unzipping data files ...")
      unzip("data-challenge-data.zip")
      
      # find and unzip all zip files
      files <- list.files(path = "data-challenge-data-master", pattern = "\\.zip$")
      sapply(files, function(i) unzip(paste("data-challenge-data-master/",i, sep=""), exdir=gsub("\\.zip$", "", i))) 
      
      # clean up
      file.remove("data-challenge-data.zip")
      
    }
    
  )
)