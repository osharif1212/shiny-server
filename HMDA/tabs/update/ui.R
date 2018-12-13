
## Update Tab UI

updateTabUI <- function (id, label = "Update") {
  
  tabPanel(label,
           sidebarLayout(
             sidebarPanel( width = 3,
               tags$h4("Update data from Github"),
               actionButton("githubUpdateButton", label = "Update Data"),
               br(),
               verbatimTextOutput("githubText")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Raw Institutional Data",
                          br(),
                          DT::dataTableOutput("instData")
                 ),
                  tabPanel("Raw Loan Data",
                           br(),
                           DT::dataTableOutput("loanData")
                  ),
                 tabPanel("Duplicate Respondent Names",
                          br(),
                          DT::dataTableOutput("duplicateNamesData")
                 )
               ),
               br(),br(),br()
             )
           )
  )
  
}