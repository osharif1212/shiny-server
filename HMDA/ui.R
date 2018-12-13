
## App UI

navbarPage("HMDA",theme = shinytheme("flatly"),
           updateTabUI("updateTab", "Update"),
           overviewTabUI("overviewTab", "Overview"),
           exploreTabUI("exploreTab", "Explore"))