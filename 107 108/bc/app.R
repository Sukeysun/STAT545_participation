#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
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
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      
      radioButtons("typeInput","Select the alcoholic beverage type ",
                    choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                    selected = "WINE")
      ### value is the defalut. instead of single value, I would like a price range.
    ),
    mainPanel(
              #ggplot2::qplot(bcl$Price)
              plotOutput("price_hist"),
              tableOutput("bcl_data")
              )
    
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  observe(print(input$priceInput))
  
  ## it is stored as a function if using reactive()
  bcl_filtered <- reactive({
    bcl %>% 
    filter( Price < input$priceInput[2],
            Price > input$priceInput[1],
            Type == input$typeInput)
    })
  
  output$price_hist <- renderPlot({
    bcl_filtered() %>% 
      ggplot(aes(Price)) +
      geom_histogram()
    
    # ggplot2::qplot(bcl$Price)
    })
  output$bcl_data <- renderTable({
    bcl_filtered()
    })
   

}

# Run the application 
shinyApp(ui = ui, server = server)

