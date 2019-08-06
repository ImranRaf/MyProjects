
# Random forest prediction
#randomtree <- function(){

# Takes factors and converts them to numeric for the knn predictions later on
train$BsmtQual <- as.numeric(train$BsmtQual)
train$GarageFinish <- as.numeric(train$GarageFinish)

#replace NA's with column mean
train$BsmtQual <- na.aggregate(train$BsmtQual)
train$GarageFinish <- na.aggregate(train$GarageFinish)
train_subset <- train[,c("ExterQual","GrLivArea","GarageCars","GarageArea","OverallQual","TotalBsmtSF","BsmtQual","X1stFlrSF",
                         "KitchenQual","FullBath","TotRmsAbvGrd","YearBuilt","GarageFinish","SalePrice")]


train_training <- train[1:973,]
train_test <- train[974:1460,]

fit <- randomForest(SalePrice ~ ., data = train_subset, ntree = 10000)
#fancyRpartPlot(fit)
predicted <- predict(fit, train_test)
#Forest AIDA boost XG boost
npredictions <- length(predicted)
numcorrect <- 0L
#compare predicted with actual results
for(i in 1:npredictions){
  if(predicted[i] > train_test$SalePrice[i] * 0.9 & predicted[i] < train_test$SalePrice[i] * 1.1 ){
    numcorrect <- numcorrect + 1
  }
}
percentage_correct <- (numcorrect/ npredictions) * 100
print("randomForest Correctness: ")
print(percentage_correct) #88.9% accuracy

}
# Knn prdiction
#knnalgoritm <- function(){
# Creating a smaller data.frame to work with
train_refined <- train[c("OverallQual","ExterQual","BsmtQual","GrLivArea","GarageCars","GarageArea","TotalBsmtSF","X1stFlrSF","KitchenQual","FullBath","SalePrice")]
train_noresults <- train[c("OverallQual","ExterQual","BsmtQual","GrLivArea","GarageCars","GarageArea","TotalBsmtSF","X1stFlrSF","KitchenQual","FullBath")]
# A test for NA's
checkforNA <- function(){
  #see if there are any n/a's in the data set
  #any(is.na(train_noresults))
  #see how many n/a's in the data set
  #sum(is.na(train_noresults))
  # outputs the rows that have NA values
  #na.cols = which(colSums(is.na(train_noresults)) > 0)
  #sort(colSums(sapply(train_noresults[na.cols], is.na)), decreasing = TRUE)
}
train_noresults <- na.exclude(train_noresults)
FeatureScalling <- function(x){ ((x - min(x)) / (max(x) - min(x))) }
train_Normalised <- as.data.frame(lapply(train_noresults, FeatureScalling))
train_training <- train_Normalised[1:944,]
train_test <- train_Normalised[945:1349,]
train_refined <- na.exclude(train_refined)
K_Value <- 39
train_predictions <- knn(train_training,train_test,train_refined[1:944,"SalePrice"], k=K_value)
train_reference <- train_refined[945:1349,"SalePrice"]
accuarcy <- sum(round(as.numeric(as.character(train_predictions)),digit = -4)==round(as.numeric(train_reference),digit=-4))/length(train_predictions)
print(accuarcy) ##17% accuracy
}
