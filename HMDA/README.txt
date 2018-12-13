Capital One Data Challenge
Omar Sharif 04/29/17



HOW TO RUN THIS PROGRAM
========================
Execute global.R from Rstudio. This application uses Shiny.



DATA NARRATIVE
==============
We can look at the market size in terms of the number of loans booked, and the dollar amount of the loans. The dollar amount of each loan is grouped into one of three segments: High, Medium, and Low. We define market geographies broadly based on State.

In the first chart we view the Loan Amount groups, years, and number of loans, across all markets. This shows a decline year over year. Additionally, DE and WV have negligible High end markets. 

In the second chart we investigate whether there is a difference between the Conventional and Conforming markets based on number of loans booked across the time period. Once again, there is a decline in both types of loans. As expected, the conventional/conforming market is significantly larger than non-conventional/non-conforming market.

In the third chart we see a decline across years in number of loans booked in all states.

The fourth chart shows that the median value of loans has actually increased from 2012 to 2014 in DE and DC. In all states but WV the median value increased between 2013 and 2014. This indicates that sub-geographies (based on MSA/MD or Census Tract) are worth investigating to pinpoint specific markets that could be potential entry-points. These are not adjusted for inflation.


CHALLENGES AND NEXT STEPS
=========================
Shiny was used to create this application, and proved to be challenging with debugging.

Next steps could involve:
- Adding more data quality checks, such as:
    -Converting null values to median (for continuous variables) 
    -Removing records with too many null values
    -Perform time series trend analysis (assuming exact dates can be obtained instead of just Year)
    -Convert attributes like Income to integer (in case it is used for analysis)
    
    

