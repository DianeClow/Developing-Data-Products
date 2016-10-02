library(shiny)
library(caret)
library(randomForest)
library(e1071)
ui <- fluidPage(
    titlePanel("Wine Quality"), 
    
    sidebarLayout(
        sidebarPanel(
            numericInput(inputId = "fixed.acidity", label = "Fixed Acidity   (4.6 - 15.9)", value = 7.90), 
            numericInput(inputId = "volatile.acidity", label = "volatile Acidity (.12 - 1.58)", value = .52), 
            numericInput(inputId = "citric.acid", label = "Citric Acid (0 - 1.0)", value = .260), 
            numericInput(inputId = "residual.sugar", label = "Residual Sugar (.9 - 15.5)", value = 2.2), 
            numericInput(inputId = "chlorides", label = "Chlorides (.012 - .611)", value = .079), 
            numericInput(inputId = "free.sulfur.dioxide", label = "Free Sulfur Dioxide (1 - 72)", value = 15.87), 
            numericInput(inputId = "total.sulfur.dioxide", label = "Total Sulfur Dioxide (6 - 289)", value = 38), 
            numericInput(inputId = "density", label = "Density (.9901 - 1.0037)", value = .9968),
            numericInput(inputId = "pH", label = "pH (2.74 - 4.01)", value = 3.311), 
            numericInput(inputId = "sulphates", label = "Sulphates (.33 - 2)", value = .62), 
            numericInput(inputId = "alcohol", label = "Alcohol (8.4 - 14.9)", value = 10.2)
        ),
        mainPanel(        
            p('This app is designed to help analyze the quality 
              of wine.  The data is from the UCI Machine Learning 
              Repository (http://archive.ics.uci.edu/ml/index.html) 
              and the data set is called “Wine Quality Data Set”.  
              It contains 11 values: fixed acidity, volatile 
              acidity, citric acid, residual sugar, chlorides, 
              free suffer dioxide, total sulfur dioxide, density, 
              pH, sulphates, alcohol, and quality.  Quality is 
              the output variable and is based on a score 
              of 1-10.'), 
            p('There are two datasets here, one for red wine and 
              one for white wine.  Both datasets contain the same 
              variables, but because of the difference in the 
              wines, I have created two different algorithms.  
              From the UCI Repository “The two datasets are 
              related to red and white variants of the 
              Portuguese "Vinho Verde" wine.  Due to privacy and 
              logistic issues, only physicochemical (inputs) and 
              sensory (the output) variables are available (e.g. 
              there is no data about grape types, wine brand, 
              wine selling price, etc.). “  This means that 
              potentially useful information for rating wines 
              is missing.'), 
            p('It should also be noted that the majority of the wines 
              in the data set have a quality ranking of 6.  You have to 
              find some extremes to get the results to move.  Next to 
              each value on the left is the min and max of each variable.'), 
            img(src="wine_image.png"), 
            p(" "), 
            p("The output of the Random Forest Algorithm behind 
              this Shiny App are shown below.  A quick test to show 
              that they work, change the Volatile Acidity to .12.  
              That will change the white wine value.  Then change 
              the Total Sulfur Dioxide to 289.  That will shift 
              the red wine value.  Please note that this app 
              sometime takes some time initally load the two 
              sentances that will below above with the final 
              quality ranking."),     
            p(" "), 
            h3("Outputs of the Random Forest", style = "color:red"), 
            textOutput("quality.red"),
            textOutput("quality.white")
        )
    )
)
# This line set up the ui app

server <- function(input, output) {
    red <- read.csv("data/winequality-red.csv", sep=";")
    red$quality <- as.factor(red$quality)
    white <- read.csv("data/winequality-white.csv", sep=";")
    white$quality <- as.factor(white$quality)
    set.seed(12345)
    mod_RF.red <- train(quality ~., method="rf", 
                        data = red, 
                        trControl = trainControl(method="cv", number = 4))
    mod_RF.white <- train(quality ~., method="rf", 
                          data = white, 
                          trControl = trainControl(method="cv", number = 4))
    
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