

library(shiny)

final_votes <- readRDS("votes_cast_voting_age_2018.RDS")
numeric_votes <- readRDS("votes_cast_voting_age_2018_numeric.RDS")
character_votes <- readRDS("votes_cast_voting_age_2018_character.RDS")

# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Votes Cast by Voting Age 2018"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Examine voting with 
               voting data from 2018."),
            
            fluidRow(selectInput("state", "Choose a state:", final_votes$state_abbreviation),
                     selectInput("y_var", "Choose what you want to measure:", choices = c(colnames(final_votes))))
            ),
            
        mainPanel(
            plotOutput("voting_data"),
            br(), br(),
            tableOutput("results")
        )
    )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
    output$voting_data <- renderPlot({
        final_votes %>%
            pivot_longer(cols = `Votes Cast`:`Margin of Error for Voting Rate`, names_to = "variables", values_to = "n") %>%
            filter(variables == input$y_var) %>%
            ggplot(aes(state, n)) + geom_bar(stat = "identity")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

