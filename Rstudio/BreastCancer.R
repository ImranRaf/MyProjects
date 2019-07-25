#install.packages("class")
library(class)
library(ggplot2)

RawBCD <- read.table("BreastCancerData.data", sep = ',')

names (RawBCD) <- c("ID","Result","Mean_Radius","Mean_Texture","Mean_Perimeter",
                    "Mean_Area","Mean_Smoothness","Mean_Compactness","Mean_Concavity",
                    "Mean_ConcavePoints","Mean_Symmetry","Mean_FractalDimension",
                    "SE_Radius","SE_Texture","SE_Perimeter",
                    "SE_Area","SE_Smoothness","SE_Compactness","SE_Concavity",
                    "SE_ConcavePoints","SE_Symmetry","SE_FractalDimension",
                    "Worst_Radius","Worst_Texture","Worst_Perimeter",
                    "Worst_Area","Worst_Smoothness","Worst_Compactness","Worst_Concavity",
                    "Worst_ConcavePoints","Worst_Symmetry","Worst_FractalDimension")

# Removes the ID column that's not a needed index
BCD_NoID <- RawBCD[,-1]

# Removes the results column as it's also not needed
BCD_NoResults <- BCD_NoID[,-1]

# Applies the equation given in the example slides
FeatureScalling <- function(x){ ((x - min(x)) / (max(x) - min(x))) }

# Normalises the feature scalling function
BCD_Normalised <- as.data.frame(lapply(BCD_NoResults, FeatureScalling))

# A good time to split the data about 75:25 (ish)
BCD_Training <- BCD_Normalised[1:450,]  #leave the value after the comma empty to
                                        #capture all columns
# The 25 (ish) part of the data
BCD_Test <- BCD_Normalised[451:569,]

# Now let's compute a K-Value to use with the classifier
# The rule of thumb is the square root of the number of observations
# Trained with
K_Value <- floor(sqrt(length(BCD_Training[,1])))

# Now I use the KNN algorithm that comes with the 'class' package to classify our data
BCD_Predictions <- knn(BCD_Training,BCD_Test,BCD_NoID[1:450,1], k=K_Value)

# Subset the reference data into it's own data frame
BCD_Reference <- BCD_NoID[451:569,1]

# Now I can tabulate the two
table(BCD_Predictions,BCD_Reference)

# Further analysis of the results can give further insights into the suitability
# Of the model, and of it's parameters

