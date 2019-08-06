setwd("C:/Users/pughs/Documents/QA Coding")
train <- read.csv("train.csv")
train$Id <- NULL
#install.packages("plyr")
library(plyr)
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
#summary(train$MSZoning)
train$MSZoning <- NULL
#summary(train$Street)
train$Street <- NULL
#summary(train$Alley)
train$Alley <- NULL
#summary(train$LandContour)
train$LandContour <- NULL
#summary(train$Utilities)
train$Utilities <- NULL
#summary(train$LandSlope)
train$LandSlope <- NULL
#summary(train$Condition1)
train$Condition1 <- NULL
#summary(train$Condition2)
train$Condition2 <- NULL
#summary(train$BldgType)
train$BldgType <- NULL
#summary(train$RoofStyle)
train$RoofStyle <- NULL
#summary(train$RoofMatl)
train$RoofMatl <- NULL
train$Foundation <- NULL
#summary(train$Heating)
train$Heating <- NULL
#summary(train$CentralAir)
train$CentralAir <- NULL
#summary(train$Electrical)
train$Electrical <- NULL
#summary(train$Functional)
train$Functional <- NULL
#summary(train$PavedDrive)
train$PavedDrive <- NULL
train$WoodDeckSF <- NULL
train$OpenPorchSF <- NULL
train$EnclosedPorch <- NULL
train$X3SsnPorch <- NULL
train$ScreenPorch <- NULL
#summary(train$Fence)
train$Fence <- NULL
#summary(train$PoolQC)
train$PoolQC <- NULL
#summary(train$MiscFeature)
train$MiscFeature <- NULL
#summary(train$SaleCondition)
train$SaleCondition <- NULL
