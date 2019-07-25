strings <- c("Hello","World","Today")
numbers <- c(1,2,3)
myDataframe <- data.frame(strings,numbers)
myTranspose <- t(myDataframe)

# runs a dataframe using the strings and numbers assigned
myDataframe

# outputs the strings in the parameter 'string'
strings

# a condition of the dataframe that outputs the strings less than 3
myDataframe[myDataframe$numbers < 3, ]

# conditionals 1
param = TRUE
number <- function(x = 10){
  if (param == FALSE){
    
    Total <- x * x
  }else {
    Total <- x + x
  }
  return (Total)
}
number()

# Conditionals 2
fun <- function(){
  input1 <- readline("Enter first value: ")
  input2 <- readline("Enter second value: ")
  if(input1 == 0){
    return(input2)
  }else if(input2 == 0){
    return(input1)
  }else{
    input1 <- as.numeric(input1)
    input2 <- as.numeric(input2)
    Total <- input1 + input2
    return (Total)
  }
}
fun()

# used for recursion
part1 <- function(x=1,y=2){
  if(x == 0){
    return(y)
  }else if(y == 0){
    return(x)
  }else{
    Total <- x + y
    return (Total)
  }
}
# recursion
recur <- function(counter){
  print(part1(1,counter))
  counter = counter + 1
  if(counter < 10){
    recur(counter)
  }
}

# Anonymous functions
evaluate <- function(func,data){
  func(data)
}
evaluate(function(x){x+1},6)

