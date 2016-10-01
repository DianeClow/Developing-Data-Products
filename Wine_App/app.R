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
            tableOutput("red.data"), 
            textOutput("quality.red"),
            textOutput("quality.white")
        )
    )
)
# This line set up the ui app

server <- function(input, output) {
    red <- read.csv("winequality-red.csv")
    white <- read.csv("winequality-white.csv")
    set.seed(12345)
    mod_RF.red <- train(quality ~., method="rf", data = training.red, trControl = trainControl(method="cv", number = 4))
    mod_RF.red$finalModel
    mod_RF.white <- train(quality ~., method="rf", data = training.white, trControl = trainControl(method="cv", number = 4))
    mod_RF.white$finalModel
    
    output$quality.red <- renderText(
        paste("This is a test")
    )
    output$quality.white <- renderText(
        paste("This is also a test")
        )
}
# this sets up the server app

shinyApp(ui = ui, server = server)
#this knits the two together