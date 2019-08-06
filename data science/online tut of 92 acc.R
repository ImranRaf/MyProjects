#=================================(install packages)=============================#
 install.packages("statsr")
 install.packages("dplyr")
 install.packages("BAS")
 install.packages("corrplot")
 install.packages("GGally")
 install.packages("MASS")
 install.packages("class")
 install.packages("carret")
 install.packages("e1071")
#=================================(library packages)================================#
library(statsr)
library(dplyr)
library(BAS)
library(corrplot)
library(GGally)
library(ggplot2)
library(MASS)
library(class)
library(caret)
library(e1071)
#===================================(set workspace)========================================#
getwd()
setwd("C:/Users/Admin/Desktop/R Work/QA House Price Project")
my_data <- read.csv("train.csv", sep = ",", header = TRUE)

my_test <- my_data[1001 :1460,]
my_data <- my_data[1:1000,]

#Find out column with missing data to not calculate them
k <- colSums(is.na(my_data))
missingval<-sort(k, decreasing = TRUE)[1:20]
barplot(missingval, main = "Missing values", las = 2 )
hist(my_data$SalePrice, main = " House price", xlab = "price", ylab = "amount", col = "green")


summary(my_data$SalePrice)
hist(log(my_data$LotArea), main = "Log:Area", xlab = "area", col = "red")
hist(my_data$YearBuilt, main = "Year of Building", col = "blue")
boxplot(my_data$SalePrice~my_data$OverallCond, main = "Overall Condition", xlab = "condition", col = "yellow")
hist(my_data$OverallCond)

overallcond <- my_data %>% 
  filter(OverallCond != 5)%>%
  group_by(OverallCond)%>%
  summarise(median = median(SalePrice), mean = mean(SalePrice))

table(my_data$OverallCond)
plot(overallcond, col = "red")

plot(my_data$SalePrice~my_data$LotArea, main = "Area vs Price", xlab = "area", col = "red")
plot(log(my_data$SalePrice)~log(my_data$LotArea), main = "Log:Area vs Price", xlab = "area", col = "red")
plot(my_data$SalePrice~my_data$YearBuilt, main = "Year of Building vs Price", col = "blue")
plot(my_data$SalePrice~my_data$OverallCond, main = "Overall Condition vs Price", xlab = "condition", col = "yellow")

#Create model based on dicision of which column is impotant from the plots 
model.lm=lm(log(SalePrice) ~  OverallCond + log(LotArea) + YearBuilt + GarageArea + TotalBsmtSF + GarageCars +  
              FullBath + HalfBath + BedroomAbvGr +  X1stFlrSF + X2ndFlrSF + log(LotArea) +  CentralAir , data=my_data )
summary(model.lm)

model.bic = bas.lm(log(SalePrice) ~  OverallCond + log(LotArea) + YearBuilt + GarageArea + TotalBsmtSF + GarageCars + 
                     FullBath + HalfBath + BedroomAbvGr +  X1stFlrSF + X2ndFlrSF + log(LotArea) +  CentralAir, 
                   prior = "BIC",method = "MCMC", modelprior = uniform(), data=my_data)
image(model.bic)
model.aic = bas.lm(log(SalePrice) ~  OverallCond+ log(LotArea)+ YearBuilt+ GarageArea + TotalBsmtSF + GarageCars + 
                     FullBath + HalfBath + BedroomAbvGr +  X1stFlrSF + X2ndFlrSF + log(LotArea) +  CentralAir, 
                   prior = "AIC", method = "BAS", modelprior = uniform(), data=my_data)
image(model.aic)
summary(model.bic)
summary(model.aic)

model.bic.full=bas.lm(log(SalePrice) ~  OverallCond+ log(LotArea)+ YearBuilt+ TotalBsmtSF + GarageCars + 
                        BedroomAbvGr + log(LotArea) +  CentralAir, prior = "BIC", method = "MCMC",modelprior = uniform(),data=my_data)
summary(model.bic.full)

lm.bic = lm(log(SalePrice) ~  OverallCond+ log(LotArea)+ YearBuilt+ TotalBsmtSF + GarageCars + 
              BedroomAbvGr + log(LotArea) +  CentralAir,data=my_data)
model.aic.full=bas.lm(log(SalePrice) ~  OverallCond+ log(LotArea)+ YearBuilt+TotalBsmtSF + GarageCars + 
                        FullBath + HalfBath + BedroomAbvGr + X2ndFlrSF + log(LotArea) +  CentralAir,
                      prior = "AIC", method = "BAS", modelprior = uniform(), data=my_data)
summary(model.aic.full)
lm.aic = lm(log(SalePrice) ~  OverallCond+ log(LotArea)+ YearBuilt+   TotalBsmtSF + GarageCars + FullBath + 
              HalfBath + BedroomAbvGr +   X2ndFlrSF +    log(LotArea) +  CentralAir,data=my_data)

plot(model.bic.full)
abline(h=0)

# Extract Predictions for bic
predict.full.train.bic <- exp(predict(lm.bic, my_data))
# Extract Residuals
resid.full.train.bic <- my_data$SalePrice - predict.full.train.bic
# Calculate RMSE
rmse.full.train.bic <- sqrt(mean(resid.full.train.bic^2, na.rm = TRUE))
rmse.full.train.bic
# Extract Predictions for aic
predict.full.train.aic <- exp(predict(lm.aic, my_data))
# Extract Residuals
resid.full.train.aic <- my_data$SalePrice - predict.full.train.aic
# Calculate RMSE
rmse.full.train.aic <- sqrt(mean(resid.full.train.aic^2, na.rm = TRUE))
rmse.full.train.aic



# Extract Predictions
predict.full.test <- exp(predict(lm.bic, my_test))
# Extract Residuals
resid.full.test <- my_test$SalePrice - predict.full.test
# Calculate RMSE
rmse.full.test.bic <- sqrt(mean(resid.full.test^2, na.rm = TRUE))
rmse.full.test.bic
rmse.full.train.bic > rmse.full.test.bic

allvar.model.step1 = lm(SalePrice ~ LotArea + OverallCond + YearBuilt + YearRemodAdd + Heating + CentralAir +  BedroomAbvGr+ KitchenAbvGr +
                          KitchenQual  + TotRmsAbvGrd+ Fireplaces + GarageYrBlt + GarageArea + PoolArea , data = my_data)
summary(allvar.model.step1)
train_normal <- my_data%>% filter(SaleCondition == "Normal" )%>%
  dplyr::select(SalePrice, LotArea, OverallCond, YearBuilt, YearRemodAdd, Heating, CentralAir, BedroomAbvGr, KitchenAbvGr, KitchenQual, TotRmsAbvGrd,Fireplaces, GarageYrBlt,GarageArea, PoolArea)

allvar.model.step2 = lm(log(SalePrice) ~ log(LotArea)  + OverallCond + YearBuilt + YearRemodAdd + Heating + CentralAir +  BedroomAbvGr+ KitchenAbvGr +  KitchenQual  + TotRmsAbvGrd+ Fireplaces + GarageYrBlt + log(GarageArea) + PoolArea , data = train_normal)
summary(allvar.model.step2)

train_normal_2 <- my_data%>%
  filter(SaleCondition == "Normal")%>% dplyr::select(SalePrice, LotArea, OverallCond, YearBuilt, YearRemodAdd, Heating, CentralAir, BedroomAbvGr, KitchenAbvGr, KitchenQual, Fireplaces, GarageArea) 

allvar.model.step3 = lm(log(SalePrice) ~ ., data = train_normal_2)
summary(allvar.model.step3)

ggpairs(train_normal_2, columns = c(5,6), main = "Years of Remodeling and Building")
ggpairs(train_normal_2, columns = c(7,8), main = "Heating and Air")
ggpairs(train_normal_2, columns = c(2, 8,9, 12), main = "Areas")
ggpairs(train_normal_2, columns = c(10, 2), main = "Kitchen vs area")

train_normal_3 <- my_data%>%  filter(SaleCondition == "Normal" )%>%
  dplyr::select(SalePrice, LotArea, OverallCond, YearBuilt, CentralAir, KitchenAbvGr, KitchenQual, Fireplaces) 

allvar.model.step4 = lm(log(SalePrice) ~ log(LotArea)+ OverallCond+ YearBuilt+CentralAir+KitchenAbvGr+ KitchenQual+ Fireplaces, data = train_normal_3)
summary(allvar.model.step4)

model.step4.bas = bas.lm(log(SalePrice) ~ log(LotArea)+ OverallCond+ YearBuilt+CentralAir+ KitchenQual+ Fireplaces, prior = "BIC",
                         method = "MCMC",
                         modelprior = uniform(), data = train_normal_3)
summary(model.step4.bas)

image(model.step4.bas, top.models = 5)
final.model=lm(log(SalePrice) ~ log(LotArea)+ OverallCond+ YearBuilt+CentralAir+ KitchenQual+ Fireplaces, data = train_normal_3)

model.train<-mean(exp(predict(final.model, my_data)))
model.test<-mean(exp(predict(final.model, my_test)))
model.train>model.test

# Predict prices train
predict.train <- exp(predict(final.model, my_data, interval = "prediction"))

# Calculate proportion of observations that fall within prediction intervals
coverage.prob.train <- mean(my_data$SalePrice > predict.train[,"lwr"] &
                              my_data$SalePrice < predict.train[,"upr"])
coverage.prob.train

# Predict prices test
predict.full <- exp(predict(final.model, my_test, interval = "prediction"))

# Calculate proportion of observations that fall within prediction intervals
coverage.prob.full <- mean(my_test$SalePrice > predict.full[,"lwr"] &
                             my_test$SalePrice < predict.full[,"upr"])
coverage.prob.full

accuracy <- (coverage.prob.train+coverage.prob.full)/2
print(paste("Accuracy is ", accuracy))
