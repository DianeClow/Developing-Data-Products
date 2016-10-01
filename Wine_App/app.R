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
            textOutput("quality.red"),
            textOutput("quality.white"), 
            p("The output of the Random Forest Algorithm behind this Shiny App are shown above.  A quick test to show that they work, change XXX to YYY.  That will change the ZZZ value.  Then change XXX to YYY.  That will shift the ZZZ value.  Please note that this app sometime takes some time initally load the two sentances that will appear above with the final quality ranking."), 
            p("This app is designed to help analyze the quality of wine.  The data is from the UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/index.html) and the data set is called “Wine Quality Data Set”.  It contains 11 values: fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free suffer dioxide, total sulfur dioxide, density, pH, sulphates, alcohol, and quality.  Quality is the output variable and is based on a score of 1-10."), 
            p('There are two datasets here, one for red wine and one for white wine.  Both datasets contain the same variables, but because of the difference in the wines, I have created two different algorithms.  From the UCI Repository “The two datasets are related to red and white variants of the Portuguese "Vinho Verde" wine.  Due to privacy and logistic issues, only physicochemical (inputs) and sensory (the output) variables are available (e.g. there is no data about grape types, wine brand, wine selling price, etc.). “  This means that potentially useful information for rating wines is missing.'), 
            p("It should also be noted that the majority of the wines in the data set have a quality ranking of 6.  You have to find some extremes to get the results to move.  Below I have provided the min, max and median value for each variable shown as: Variable Name (min, median, max)"), 
            p("Fixed Acidity (4.60, 7.90, 15.90)"), 
            p("Volatile Acidity (.12, .52, 1.58)"), 
            p("Citric Acid (0, .260, 1.0)"), 
            p("Residual Sugar (.9, 2.2, 15.5)"), 
            p("Chlorides (.012, .079, .611)"),
            p("Free Sulfur Dioxide (1, 15.87, 72)"), 
            p("Total Sulfur Dioxide (6, 38, 289)"), 
            p("Density (.9901, .9968, 1.0037)"), 
            p("pH (2.74, 3.311, 4.01)"), 
            p("Sulphates (.33, .62, 2)"), 
            p("Alcohol (8.4, 10.2, 14.9)")
        )
    )
)
# This line set up the ui app

server <- function(input, output) {
    red <- read.csv("winequality-red.csv")
    white <- read.csv("winequality-white.csv")
    set.seed(12345)
    mod_RF.red <- train(quality ~., method="rf", 
                        data = training.red, 
                        trControl = trainControl(method="cv", number = 4))
    mod_RF.red$finalModel
    mod_RF.white <- train(quality ~., method="rf", 
                          data = training.white, 
                          trControl = trainControl(method="cv", number = 4))
    mod_RF.white$finalModel
    
    output$quality.red <- renderText(
        paste("The quality of a red wine with the following characteristis is a", predict(mod_RF.red, newdata = data.frame("fixed.acidity" = input$fixed.acidity, 
                                                       "volatile.acidity"= input$volatile.acidity, 
                                                       "citric.acid" = input$citric.acid, 
                                                       "residual.sugar" = input$residual.sugar, 
                                                       "chlorides" = input$chlorides, 
                                                       "free.sulfur.dioxide" = input$free.sulfur.dioxide, 
                                                       "total.sulfur.dioxide"=  input$total.sulfur.dioxide, 
                                                       "density" = input$density, 
                                                       "pH" = input$pH, 
                                                       "sulphates" = input$sulphates, 
                                                       "alcohol" = input$alcohol)))
    )
    output$quality.white <- renderText(
        paste("The quality of a white wine with the following characteristis is a", predict(mod_RF.white, newdata = data.frame("fixed.acidity" = input$fixed.acidity, 
                                                       "volatile.acidity"= input$volatile.acidity, 
                                                       "citric.acid" = input$citric.acid, 
                                                       "residual.sugar" = input$residual.sugar, 
                                                       "chlorides" = input$chlorides, 
                                                       "free.sulfur.dioxide" = input$free.sulfur.dioxide, 
                                                       "total.sulfur.dioxide"=  input$total.sulfur.dioxide, 
                                                       "density" = input$density, 
                                                       "pH" = input$pH, 
                                                       "sulphates" = input$sulphates, 
                                                       "alcohol" = input$alcohol)))
        )
}
# this sets up the server app

shinyApp(ui = ui, server = server)
#this knits the two together