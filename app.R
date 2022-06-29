## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "DivInteractiv"),
  dashboardSidebar(sidebarMenu(
    menuItem("Interactive calculator", tabName = "dashboard", icon = icon("calculator")),
    menuItem("Learn more", tabName = "widgets", icon = icon("share")),
    menuItem("Privacy", tabName = "widgets2", icon = icon("eye")),
    menuItem("Contact", tabName = "widgets3", icon = icon("envelope"))
  )),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(
                  title = "Inputs", status = "warning",
                  "Box content here", br(), "More box content",
                  sliderInput("slider", "Slider input:", 1, 100, 50),
                  textInput("text", "Text input:")
                ),
                
                box(
                  plotOutput("plot1", height = 250)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Learn more about dividends")
      ),
      tabItem(tabName = "widgets2",
              h2("Terms and Conditions / Privacy Policy")
    ),
    tabItem(tabName = "widgets3",
            h2("Contact Information")
    ) 
  )
)
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)