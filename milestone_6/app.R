

library(shiny)
votes_cast_voting_age_2018 <- read_xlsx("Raw-data/votes_cast_voting_age_2018.xlsx", skip = 2) %>%
    clean_names()

votes_cast_voting_age_2018_revised <- votes_cast_voting_age_2018 %>%
    select(-line_number) %>%
    drop_na() %>%
    rename("Votes Cast" = votes_cast_for_congressional_representative_for_the_november_6_2018_election1, 
           "Number of Eligible Citizens (Estimate)" = citizen_voting_age_population2,
           "Margin of Error (MOE)" = x7,
           "Voting Rate" = voting_rate3,
           "MOE" = x9)


# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Votes Cast by Voting Age 2018"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Examine voting with 
               voting data from 2018."),
            
            selectInput("x var",
                        label = "Choose a congressional district",
                        choices = votes_cast_voting_age_2018_revised$state_abbreviation)
            ),
            
        mainPanel("results")
    )
        
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
