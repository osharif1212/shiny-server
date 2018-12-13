
## Explore Tab UI

exploreTabUI <- function (id, label = "Explore") {
  
  tabPanel(label,
           sidebarLayout(
             sidebarPanel( width = 3,
                           tags$h4("Data Export"),
                           br(),
                           selectizeInput(
                             'states', 'States', choices = c("MD", "VA", "WV", "DE", "DC"), multiple = TRUE,
                             selected = c("MD")
                           ),
                           br(),
                           selectizeInput(
                             'conventional_conforming', 'Conventional Conforming', choices = 
                               c("Y", "N")
                           ),
                           br(),
                           downloadButton("json_export", label = "Export JSON"),
                           tags$h6("Please note JSON export is limited to first 500 records for performance reasons")
                           
                           
             ),
             mainPanel(
               titlePanel(title=h4("Explore & Download", align="center")),
               tabsetPanel(
               tabPanel("Combined Institution & Loan Data With Outliers Removed based on Loan Amounts",
                        br(),
                        DT::dataTableOutput("dataProcessorData")
               )
               
               ))
           )
  )
  
}