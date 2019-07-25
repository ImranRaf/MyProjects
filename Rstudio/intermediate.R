# Blackjack
blackjack = TRUE
while (blackjack == TRUE) {
  a <- readline("Enter first value: ")
  b <- readline("Enter second value: ")
  if (a > b && a <= 21) {
    print(a)
  }else if (b > a && b <= 21){
    print(b)
  }else if (b > 21 && a > 21){
    print(0)
  }else if (a > 21 && b <= 21){
    print(b)
  }else if (b > 21 && a <= 21){
    print(a)
  }
}

# unique sum
unique <- function(a,b,c){
  if (a != b && a != c && b != c) {
    Total <- a + b + c
    print(Total)
  }else if (a == b) {
    print(inp3)
  }else if (a == c) {
    print(inp2)
  }else if (b == c) {
    print(inp1)
  }else if (a == b && a == b && b == c) {
    print(0)
  }
}
unique(2,0,6)

# temperture
temperture <- function(){
  temp = 75
  isSummer = TRUE
  if (temp >= 60 && temp <= 90) {
    print(temp)
    print ("It's just right")
    if (isSummer == TRUE) {
      print(temp+10)
      print("It's SUMMER BABY!!")
    }else if (temp < 60 || temp >90) {
      print("Out of range")
    }
  }
}
temperture()

# leap year
leap <- function(year){
  for (x in 1:100) {
    if (year %% 4 == 0) {
      if (year %% 100 == 0) {
        if (year %% 400 == 0) {
          print(paste(year, "is a leap year"))
        }else{
          print(paste(year, "is not a leap year"))
        }
      }else{
        print(paste(year, "is a leap year"))
      }
    }else{
      print(paste(year, "is not a leap year"))
    }
    year <- year + 1
  }
}
leap(2019)

# working with files
setwd("C:\\Users\\Admin\\Documents\\Imran")
workingFiles <- function(){
  evens = c(2,4,6,8,10)
  write.csv(evens, 'evens.csv')
  odds <- read.csv('evens.csv')[,2]+1
  write.csv(odds, 'odds.csv')
}
workingFiles()

#plotting
dataplotting <- function(){
  data(iris)
  boxplot(iris)
  plot(iris)
}
dataplotting()

# CO2
myco2 <- function(){
  data(CO2)
  class(CO2)
  # helps know the table column names and layout
  summary(CO2)
  # calculates the mean of uptake
  mean(CO2$uptake)
  # boxplot uptake for both types
  boxplot(uptake~Type, data=CO2)
  # created a subset for quebec
  quebec_CO2 <- subset(CO2,Type=="Quebec")
  # subset for mississippi
  mississippi_CO2 <- subset(CO2,Type=="Mississippi")
  # mean compared using if statement
  if (mean(quebec_CO2$uptake) > mean(mississippi_CO2$uptake)) {
    mean(quebec_CO2$uptake)
  }else{
    mean(mississippi_CO2$uptake)
  }
}

# Orchard sprays
myorchard <- function(){
  data(OrchardSprays)
  summary(OrchardSprays)
  # shows the row with the max value
  OrchardSprays[which.max(OrchardSprays$decrease),]
  # boxplot of the decrease values for each element
  boxplot(decrease~treatment, data=OrchardSprays)
  
}

# Chick data
mychick <- function(){
  data(ChickWeight)
  summary(ChickWeight)
  # uses a graph to compare weight readings of chicks from lowest to highest
  boxplot(weight~Chick, data=ChickWeight)
  # shows the readings of chick 35 that gained the most weight from it's diet, taken from the previous graph
  bestdiet <- subset(ChickWeight, Chick==35)
}












