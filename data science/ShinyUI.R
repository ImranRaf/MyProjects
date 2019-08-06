#install.packages("shiny")
library(shiny)
library(xgboost)
library(rpart)
library(randomForest)

setwd("C:/Users/Admin/Documents/Imran/assignment")

ui <- fluidPage(
  titlePanel("House pricing predictions"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    
    # Input: Slider for the number of bins ----
    selectInput(inputId = "ExterQual", label = "Exterior Quality", choices = (c("Ex","Fa","Gd","TA"))),
    numericInput(inputId = "GrLivArea", label ="Ground floor living area", value = 0, min = 0, step = 1),
    numericInput(inputId = "GarageCars", label ="Size of garage to amount of cars", value = 0, min = 0, step = 1),
    numericInput(inputId = "GarageArea", label ="Size of garage in square feet", value = 0, min = 0, step = 1),
    sliderInput(inputId = "OverallQual", label = "Rate overall quality of the property", min = 0, value = 0, step = 1, max = 10),
    numericInput(inputId = "TotalBsmt", label ="Total basement in square feet", value = 0, min = 0, step = 1),
    selectInput(inputId = "BsmtQual", label = "Basement Quality", choices = (c("Ex","Fa","Gd","TA"))),
    numericInput(inputId = "X1stFlrSF", label ="Total 1st floor in square feet", value = 0, min = 0, step = 1),
    selectInput(inputId = "KitchenQual", label = "Kitchen Quality", choices = (c("Ex","Fa","Gd","TA"))),
    sliderInput(inputId = "FullBath", label = "Number of Bathrooms", min = 0, value = 0, step = 1, max = 3),
    submitButton("Show predicted value \U00A3")
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    textOutput(outputId = "Predicted")
  )
)

createModel <- function(train){
  # XGBoost prediction ----
  train_data <- train[,c("ExterQual","GrLivArea","GarageCars","GarageArea","OverallQual","TotalBsmtSF","BsmtQual","X1stFlrSF",
                         "KitchenQual","FullBath","SalePrice")]

  # Matrix for the XGboost prediction ----
  dtrain <- xgb.DMatrix(label = train_data$SalePrice, data=data.matrix(train_data[,-11]))
  
  # Runs the prdiction nrounds times ----
  fit_xgb <- xgboost(data = dtrain, nrounds = 1000)
  return(fit_xgb)
}

predictedlogic <- function(input){
  # Take all 10 variables from the UI ----
  taken <- list(input$ExterQual, input$GrLivArea, input$GarageCars, input$GarageArea, input$OverallQual, input$TotalBsmt, input$BsmtQual, input$X1stFlrSF, input$KitchenQual, input$FullBath)
  #taken <- list("Ex",479,2,231,8,432,"Gd",674,"TA",1)
  test_data <- as.data.frame(taken)
  colnames(test_data) <- c("ExterQual","GrLivArea","GarageCars","GarageArea","OverallQual","TotalBsmtSF","BsmtQual","X1stFlrSF",
                           "KitchenQual","FullBath")
  predicted_xgb <- predict(fit_xgb, data.matrix(test_data))
  return(round(predicted_xgb,-3))
}

server <- function(input, output, session) {
  
  output$Predicted <- renderText({
    paste("Predicted Value of \U00A3", predictedlogic(input))
  })
  
}

train <- read.csv("train.csv")
fit_xgb <- createModel(train)

shinyApp(ui = ui, server = server)
