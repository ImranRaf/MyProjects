# Packages for running program ----
#install.packages("randomForest")
#install.packages("xgboost")
library(xgboost)
library(rpart)
library(randomForest)


setwd("C:/Users/Admin/Documents/Imran/assignment")
train <- read.csv("train.csv")

# XGBoost prediction ----
train_subset <- train[,c("ExterQual","GrLivArea","GarageCars","GarageArea","OverallQual","TotalBsmtSF","BsmtQual","X1stFlrSF",
                        "KitchenQual","FullBath","SalePrice")]
 
rows_taken <- sample(nrow(train_subset),nrow(train_subset)*0.75)
 
training_data <- train_subset[rows_taken,]
test_data <- train_subset[-rows_taken,]

# Matrix for the XGboost prediction ----
dtrain <- xgb.DMatrix(label = train_subset$SalePrice, data=data.matrix(train_subset[,-11]))
  
# Runs the prdiction nrounds times ----
fit_xgb <- xgboost(data = dtrain, nrounds = 1000)

predicted_xgb <- predict(fit_xgb, data.matrix(test_data[,-11]))
  
#Forest AIDA boost XG boost ----
npredictions <- length(predicted_xgb)
numcorrect <- 0L
#compare predicted with actual results ----
for(i in 1:npredictions){
  if(predicted_xgb[i] > test_data$SalePrice[i] * 0.99 & predicted_xgb[i] < test_data$SalePrice[i] * 1.01 ){
    numcorrect <- numcorrect + 1
  }
}
percentage_correct <- (numcorrect/ npredictions) * 100
print("randomForest Correctness: ")
print(percentage_correct)
  
# Used to output predictions to a csv file ----
#predicted_df <- data.frame(test_data[,"SalePrice"],predicted_xgb)
#names(predicted_df) <- c("SalePrice")
#write.csv(predicted_df, "Kagglesolution.csv")
