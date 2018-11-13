#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
a <- 5
print(a^2)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  # "This is some text",
  # br(),
  # p("This is more text"),
  # tags$h1("Level 1 header"),
  # h1(em("Level 1 header, part2")),   
  # HTML("<h1> Level 1 header, part3 </h1>"),   
  # tags$strong("This text is strongly emphasized."),  
  # br(),
  # tags$button("put a button"),  
  # br(),
  # a(href = "https://shiny.rstudio.com/articles/tag-glossary.html", "Link to all tags"),
  # print(a)
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("This text is in the sidebar."),
    mainPanel(
              #ggplot2::qplot(bcl$Price)
              plotOutput("price_hist"),
              tableOutput("bcl_data")
              )
    
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
  output$bcl_data <- renderTable(head(bcl))
   

}

# Run the application 
shinyApp(ui = ui, server = server)

