## app.R ##
library(shinydashboard)
library(ggplot2)

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
      tabItem(tabName = "dashboard", h2(tags$b("How much money do I need to invest to get monthly dividend income?"), align = 'center'),
              tags$br(), h3("You set your monthly dividend goal..."),
              fluidRow(
              #mainPanel(
                box(
                  title = " ", status = "warning",
                  " ",  
                  sliderInput("slider", "Desired dollars per month in dividend income:", 0, 8300, 5000)
                )),
              h3("...and then see how much you need to invest.", align = 'right'),
                fluidRow(
                box(
                  plotOutput("plot1", height = 250)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2(tags$b("Learn more about dividends"), align = 'center'),
              tags$br(),
              h5(tags$b("What are dividends? Are dividends a good form of 'passive income'?")),
              h5("Here's some information"),
              h5(tags$b("Why do some companies/funds pay dividends? Aren't they just giving away money?")),
              h5("Here's some information"),
              h5(tags$b("What are the risks of dividends? How can I mitigate these risks?")),
              h5("Here's some information")
              
      ),
      tabItem(tabName = "widgets2",
              h2(tags$b("Privacy / Terms and Conditions"), align='center'),
              tags$br(),
              h5(tags$b("Overarching guideline:")),
              h5("DivInteractiv and associated product(s), services, and website(s) is good at helping people but is not a replacement for a certified CPA, tax attorney, and/or financial advisor. DivInteractiv and its associated  product(s), service(s), and website(s) are for education and entertainment purposes only. Consequently, DivInteractiv and its associated product(s), service(s), and website(s) can not and should not be considered financial advice. DivInteractiv is dedicated to providing a harassment-free experience for everyone, regardless of gender, gender identity and expression, age, sexual orientation, disability, physical appearance, body size, race, ethnicity, religion (or lack thereof), or technology choices. We do not tolerate harassment of users or employees in any form."), 
              h5(tags$b("Product Use:")),
              h5("DivInteractiv's product(s), service(s), and website(s) are made available on an “as is” and “as available” basis. Data shall be only be used by the user for his/her personal and/or internal business use. Sharing data with third parties for a commercial purpose without prior written consent of DivInteractiv is not allowed."),
              h5(tags$b("Privacy Policy and information about data sharing:")),
              h5("DivInteractiv takes Privacy extremely seriously. Data shall be used only by DivInteractiv for internal business use. DivInteractiv will not share data with third parties without prior consent from the user. User data is stored for a maximum of 5 years or for however long the user has a login/password, whichever is longer. If you are concerned about DivInteractiv data usage or want to know what data has been collected by DivInteractiv about you or to request that your personal data be deleted, you can email divinteractiv <at> gmail <dot> com. To make an inquiry or complaint about how personal data is being used, please email divinteractiv <at> gmail <dot> com.")
                 
                 
    ),
    tabItem(tabName = "widgets3",
            h2(tags$b("Contact Information"), align='center'),
            tags$br(),
            h5("I'd love to hear from you! Please reach out with questions and feedback at divinteract <at> gmail <dot> com.")
    ) 
  )
)
)

server <- function(input, output) {
  set.seed(122)
  #histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    #data <- histdata[seq_len(input$slider)]
    #barplot(data_bar_plot)
    # Do calculations for the app
    dp1 <- input$slider*0.0125
    dp2 <- input$slider*0.025
    div_data <- data.frame(
      Investments = c("ETF1", "ETF2"),
      Dollars_needed = c(dp1, dp2)
    )
    ggplot(data = div_data, aes(x=Investments, y=Dollars_needed)) + ylim(0, (max(div_data$Dollars_needed)+max(div_data$Dollars_needed)*0.07)) + 
      geom_bar(stat = "identity") + geom_col(fill = "#0099f9") + theme_classic() + 
      labs(
        title = "Dollars to be invested \n across different vehicles",
        caption = "Chart by DivInteractiv", 
        x = "Prospective Investments",
        y = "Dollars to be invested (USD)"
      ) + theme(plot.title = element_text(hjust = 0.5), 
                plot.caption = element_text(face = "italic") 
                #axis.title.x = element_text(face = "bold"), 
                #axis.title.y = element_text(face = "bold"), 
                #title = element_text(face = "bold")
                ) +
      geom_text(aes(label = Dollars_needed), vjust = -0.5, size = 3, fontface = "bold")
  })
}

shinyApp(ui, server)