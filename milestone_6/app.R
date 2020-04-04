

library(shiny)

final_votes <- readRDS("votes_cast_voting_age_2018.RDS")
numeric_votes <- readRDS("votes_cast_voting_age_2018_numeric.RDS")
character_votes <- readRDS("votes_cast_voting_age_2018_character.RDS")
options(scipen = 999)

# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Votes Cast by Voting Age 2018"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Examine voting with 
               voting data from 2018."),
            fluidRow(
                column(5,
                       checkboxGroupInput("checkGroup", 
                                   h3("Does This Checkbox Say CT?"),
                                   choices = list("CT" = 1,
                                                  "Yes" = 2,
                                                  "No" = 3,
                                                  "I mean, one of them does..." = 4,
                                                  "I am extremely confused by your question" = 5)))
            )
                            
             # fluidRow(selectInput("state", "Choose a state:", final_votes$state_abbreviation),
                     # selectInput("y_var", "Choose what you want to measure:", choices = c(colnames(final_votes))))
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
            # pivot_longer(cols = `Votes Cast`:`Margin of Error for Voting Rate`, names_to = "variables", values_to = "n") %>%
            # filter(variables == input$y_var) %>%
            filter(state_abbreviation == "CT") %>%
            ggplot(aes(state_abbreviation, `Votes Cast`)) + 
            geom_bar(stat = "identity") + theme_classic() +
            labs(
                title = "Votes Cast by Connecticut in 2018",
                x = "State (Connecticut)",
                y = "Votes Cast"
            )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

