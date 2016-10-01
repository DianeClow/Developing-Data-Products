library(shiny)
ui <- fluidPage(
    titlePanel("Wine Quality"), 
    
    sidebarLayout(
        sidebarPanel(
            numericInput(inputId = "fixed.acidity", label = "Fixed Acidity", value = 0), 
            numericInput(inputId = "volatile.acidity", label = "volatile Acidity", value = 0), 
            numericInput(inputId = "citric.acid", label = "Citric Acid", value = 0), 
            numericInput(inputId = "residual.sugar", label = "Residual Sugar", value = 0), 
            numericInput(inputId = "chlorides", label = "Chlorides", value = 0), 
            numericInput(inputId = "free.sulfur.dioxide", label = "Free Sulfur Dioxide", value = 0), 
            numericInput(inputId = "total.sulfur.dioxide", label = "Total Sulfur Dioxide", value = 0), 
            numericInput(inputId = "density", label = "Density", value = 0),
            numericInput(inputId = "pH", label = "pH", value = 0), 
            numericInput(inputId = "sulphates", label = "Sulphates", value = 0), 
            numericInput(inputId = "alcohol", label = "Alcohol", value = 0)
        ),
        mainPanel(
            textOutput("quality")
        )
    )
)
# This line set up the ui app

server <- function(input, output) {}
# this sets up the server app

shinyApp(ui = ui, server = server)
#this knits the two together