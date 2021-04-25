rm(list = ls())

install.packages('rpart')
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)
library(caTools)
library(ggcorrplot)



#Dataset link: https://www.kaggle.com/dell4010/wine-dataset
wine_data <- read.csv("datasets/wine_dataset.csv", stringsAsFactors = T)
head(wine_data)

#unique(wine_data$style)
str(wine_data)
summary(wine_data)


colSums(is.na(wine_data))

# style is target value
unique(wine_data$style)

table(wine_data$style)

ggplot(data = wine_data, aes(x = style)) +
  geom_bar(aes(fill = factor(style)), width = 0.75)+
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

#Histogram

hist(wine_data$fixed_acidity, col = 'green')
hist(wine_data$volatile_acidity, col = 'green')
hist(wine_data$citric_acid, col = 'green')

hist(wine_data$residual_sugar, col = 'darkred')
hist(wine_data$chlorides, col = 'darkred')

hist(wine_data$free_sulfur_dioxide, col = 'darkred')
hist(wine_data$density, col = 'darkred')

# # Transform data using Cube root transformation

wine_data <- within(wine_data, {
  residual_sugar <- sign(residual_sugar) * abs(residual_sugar)^(1/3)
  chlorides <- sign(chlorides) * abs(chlorides)^(1/3)
  free_sulfur_dioxide <- sign(free_sulfur_dioxide) * abs(free_sulfur_dioxide)^(1/3)
  density <- sign(density) * abs(density)^(1/3)
})

#After cube root transformation
hist(wine_data$residual_sugar, col = 'darkgreen')
hist(wine_data$chlorides, col = 'darkgreen')

hist(wine_data$free_sulfur_dioxide, col = 'darkgreen')
hist(wine_data$density, col = 'darkgreen')



#Correlation matrix

corMatrix <- cor(wine_data[, 1:12])
ggcorrplot(corMatrix, lab = T, lab_size = 3)

# Spliting training and testing dataset

#set seed number
set.seed(123)
mask <- sample.split(wine_data$quality, SplitRatio = 0.80)

training_data <- subset(wine_data, mask == T)
testing_data <- subset(wine_data, mask == F)

dim(training_data)
dim(testing_data)



#Model fitting 
tree_cls <- rpart(style ~., data = training_data, method = 'class')

#hierarchical view
rpart.plot(tree_cls, extra = 106)


#Model prediction
pred <- predict(tree_cls, testing_data, type = 'class')


#Confusion matrix
table(pred, testing_data$style)

confusionMatrix(table(pred, testing_data$style))


#               --------------    Naive Bayes Classification       ---------------------

naiveBayes_cls <- naiveBayes(style ~., data = training_data)

pred <- predict(naiveBayes_cls, testing_data)

pred_actual <- data.frame(pred, testing_data$style)

head(pred_actual)
tail(pred_actual)

table(pred, testing_data$style)

confusionMatrix(table(pred, testing_data$style))



