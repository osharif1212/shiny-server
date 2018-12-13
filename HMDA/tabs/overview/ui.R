
## Overview Tab UI

overviewTabUI <- function (id, label = "Overview") {
  
  tabPanel(label,
           sidebarLayout(
             sidebarPanel( width = 3,
                           tags$h4("Data Visualizations"),
                           br(),
                           tags$h6("We can look at the market size in terms of the number of loans booked, and the dollar amount of the loans. The dollar amount of each loan is grouped into one of three segments: High, Medium, and Low. We define market geographies broadly based on State."),
                           hr(),
                           tags$h6("In the first chart we view the Loan Amount groups, years, and number of loans, across all markets. This shows a decline year over year. Additionally, DE and WV have negligible High end markets."),
                           hr(),
                           tags$h6("In the second chart we investigate whether there is a difference between the Conventional and Conforming markets based on number of loans booked across the time period. Once again, there is a decline in both types of loans. As expected, the conventional/conforming market is significantly larger than non-conventional/non-conforming market."),
                           hr(),
                           tags$h6("In the third chart we see a decline across years in number of loans booked in all states."),
                           hr(),
                           tags$h6("The fourth chart shows that the median value of loans has actually increased from 2012 to 2014 in DE and DC. In all states but WV the median value increased between 2013 and 2014. This indicates that sub-geographies (based on MSA/MD or Census Tract) are worth investigating to pinpoint specific markets that could be potential entry-points. These are not adjusted for inflation.")
             ),
             mainPanel(
    titlePanel(title=h4("Visual Data Narrative", align="center")),
     mainPanel(
       plotOutput("summaryByHML",  width = "100%"),
       br(),
       hr(),
       plotOutput("summaryByYearStateConforming",  width = "100%"),
       br(),
       hr(),
       plotOutput("summaryByLoanState",  width = "100%"),
       br(),
       hr(),
       plotOutput("summaryByMedianState",  width = "100%")
       
       )
    
    )
  )
  )
  
}