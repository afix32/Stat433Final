#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

nba <- read.csv("data/STAT433ProjectDATA.csv")
library(ggplot2)

# User interface ----
# Define UI for miles per gallon app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("NBA Analysis: How Different Statistics Effect Season Win Totals"),
    
    # Sidebar panel for inputs ----
    sidebarPanel(
        
        # Input: Selector for variable to plot against mpg ----
        selectInput("variable", "Variable:", 
                    c("3 Point Percentage" = "THREEPPercent",
                      "Two Point Percentage" = "ORB",
                      "Free Throw Percentage" = "FTPercent",
                      "Steals" = "STL",
                      "Blocks" = "BLK",
                      "Assists" = "AST",
                      "Turnovers" = "TOV",
                      "Personal Fouls" = "PF",
                      "Total Points Scored" = "PTS",
                      "Rebounds" = "TRB"
                      ))
        
        
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
        # Output: Formatted text for caption ----
        h3(textOutput("caption")),
        
        # Output: Plot of the requested variable against mpg ----
        plotOutput("nbaPlot")
    )
)

# Server logic ----
server <- function(input, output) {
    
    # Compute the formula text ----
    # This is in a reactive expression since it is shared by the
    # output$caption and output$mpgPlot functions
    formulaText <- reactive({
        paste("WINS ~", input$variable)
    })
    
    # Return the formula text for printing as a caption ----
    output$caption <- renderText({
        formulaText()
    })
    
    # Generate a plot of the requested variable against mpg ----
    # and only exclude outliers if requested
    output$nbaPlot <- renderPlot({
        plot(as.formula(formulaText()),
               data = nba,
               col = "#75AADB", pch = 19)
    })
    
}

# Run app ----
shinyApp(ui, server)
