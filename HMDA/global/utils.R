
ingestfile <- function(x){
  # TODO: Make sure argument is valid
  fullpath <- CONFIG$data_path_template
  fullpath <- gsub("reportname", x, fullpath)
  x <- data.frame(fread(fullpath))
  return(x)
}
 

