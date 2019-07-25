# Prime numbers sieve algorithm
sieve <- function(n)
{
  n <- as.integer(n)
  primes <- rep(TRUE, n)
  primes[2] <- FALSE
  last.prime <- 2L
  fsqr <- floor(sqrt(n))
  while (last.prime <= fsqr)
  {
    primes[seq.int(2L*last.prime, n, last.prime)] <- FALSE
    sel <- which(primes[(last.prime+1):(fsqr+1)])
    if(any(sel)){
      last.prime <- last.prime + min(sel)
    }else last.prime <- fsqr+1
  }
  length(which(primes))
}
sieve(2000000000) #warning large number (elapsed time: 01:07.39)

# Predicting salaries
salaries <- function(){
  census <- read.csv("C:\\Users\\Admin\\Documents\\Imran\\censusData_train.csv", header = FALSE, stringsAsFactors = FALSE)
  colnames(census) <- c("Age","Workclass","Final weight","Education","Education-num","Martial-status","Occupation","Relationship","Race","Sex","Capital-gain","Capital-loss","Hours-per-week","Native-country","Salary")
  str(census)
  
  # Checking and playing with some variables to give a better understanding of the csv file
  prop.table(table(census$Workclass, census$Race),1)
  prop.table(table(census$Race, census$Salary),1)
  prop.table(table(census$Education, census$Occupation),1)
  prop.table(table(census$Age, census$Salary),1)
  
  # Adding breaks to group ages rather than seperate for each year
  ages <- cut(census$Age, breaks=c(0, 30, 55, 70, Inf), labels=c("17-30","31-55","56-69","70+"))
  agedistib <- table(ages, census$Salary)
  barplot(agedistib)
  
  # Tables shows grouped ages to salary
  prop.table(table(ages, census$Salary),1)
  
  # Factorise and group education levels to similar levels of degree
  census$Education <- factor(census$Education, levels = c(unique(as.character(census$Education)),1,2,3,4))
  census$Education[census$Education %in% c("Preschool","1st-4th", "5th-6th", "7th-8th","9th","10th","11th","12th","HS-grad")] <- 1
  census$Education[census$Education %in% c("Prof-school","Assoc-acdm","Assoc-voc")] <- 2
  census$Education[census$Education %in% c("Some-college","Bachelors")] <- 3
  census$Education[census$Education %in% c("Masters","Doctorate")] <- 4
  # Orders the groups after being numbered to run 1 - 4
  census$Education <- factor(census$Education, levels = c(unique(as.numeric(census$Education))), ordered = TRUE)
  
  # Shows 4 tables grouped by age of the percentage of people earning over or under 50k depending
  # On the level of degree they have earned
  prop.table(table(census$Education, census$Salary, ages),1)
  
  #prop.table(table(census$Sex, census$Salary),1)
  
  # Taking from the resutls of the last table this shows that a higher percentage of people between (30 - 49)% earn
  # Over 50k between the ages of 31-55 and almost 50% of those individuals over 50k have a level 4
  # Education eg. Masters or Doctorate.
} 

prediction <- function(){
  library(rpart)
  library(rpart.plot)
  library(rattle)

  pred <- read.csv("C:\\Users\\Admin\\Documents\\Imran\\censusData_train.csv", header = FALSE, stringsAsFactors = FALSE)
  colnames(pred) <- c("Age","Workclass","Final weight","Education","Education-num","Martial-status","Occupation","Relationship","Race","Sex","CapitalGain","CapitalLoss","HoursPerWeek","Native-country","Salary")
  
  fit <- rpart(Salary~Age+Education+Workclass+CapitalGain+CapitalLoss+HoursPerWeek, data=pred)
  par(mfrow = c(1,1))
  fancyRpartPlot(fit)
  prediction <- predict(fit, pred, type='class')
}

