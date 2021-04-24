#Reset all variables
rm(list = ls())

#Install library
install.packages('ggcorrplot')

#Load/Import libraries
library(ggplot2)
library(lattice)
library(ggcorrplot)
library(caret)
library(e1071)
library(scales)
library(caTools)

#Read data and see some top records
#dataset link: https://www.kaggle.com/shivachandel/kc-house-data
house_data <- read.csv("datasets/kc_house_data.csv")
head(house_data)
dim(house_data)

#Check missing values
colSums(is.na(house_data))

#Eliminate  irrelevant features
house_data <- subset(house_data, select = -c(id, date, zipcode))
head(house_data)

dim(house_data)
str(house_data)

unique(house_data$waterfront)
unique(house_data$view)
unique(house_data$yr_renovated)

#Since, I saw those houses not renovated assign as zero(0) and with some date (yyyy) which is renovated so
# I decided to remark as 0 is not renovated and 1 as renovated

house_data$yr_renovated <- ifelse(house_data$yr_renovated > 0, 1, 0 )
unique(house_data$yr_renovated)



ggplot(data = house_data, aes(x = yr_renovated)) +
  geom_bar(aes(fill = factor(yr_renovated)), width = 0.75)+
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

boxplot(house_data$sqft_living, col = 'darkred')
boxplot(house_data$sqft_above, col = 'red')



head(house_data)

#Removing outlier using IQR 

# (link:- http://www.mathwords.com/o/outlier.htm, 
# https://stackoverflow.com/questions/13339685/how-to-replace-outliers-with-the-5th-and-95th-percentile-values-in-r)

house_data <- within(house_data, {
  sqft_living <- squish(sqft_living, quantile(sqft_living, c(.05, .95)))
  sqft_lot <- squish(sqft_lot, quantile(sqft_lot, c(.05, .95)))
  sqft_above <- squish(sqft_above, quantile(sqft_above, c(.05, .95)))
  sqft_living15 <- squish(sqft_living15, quantile(sqft_living15, c(.05, .95)))
  sqft_lot15 <- squish(sqft_lot15, quantile(sqft_lot15, c(.05, .95)))
})


boxplot(house_data$sqft_living, col = 'darkgreen')
boxplot(house_data$sqft_above, col = 'green')


ggplot(house_data, aes(x = sqft_living, y = price))+
  geom_point(col = "darkblue", size = 2.5)

ggplot(house_data, aes(x = sqft_lot, y = price))+
  geom_point(col = "darkblue", size = 2.5)

ggplot(house_data, aes(x = sqft_living15, y = price))+
  geom_point(col = "darkblue", size = 2.5)

ggplot(house_data, aes(x = sqft_basement, y = price, col = factor(condition)))+
  geom_point(size = 2)

ggplot(house_data, aes(x = sqft_basement, y = price, col = factor(grade)))+
  geom_point(size = 2)


ggplot(house_data, aes(x = sqft_basement, y = price))+
  geom_point(col = "darkgreen")+
  geom_hline(yintercept = mean(house_data$price))+
  stat_smooth(method = "lm", se = FALSE, col = "red")


#Correlation of matrix
cor_Matrix <- cor(house_data)
#Note:- Click on zoom button to see clear correlation matrix plot
ggcorrplot(cor_Matrix, lab = TRUE, lab_size = 2)


#Splitting training and testing data set
set.seed(1)
mask <- sample.split(house_data$price, SplitRatio = 0.80)

training_data <- subset(house_data, mask == T)
testing_data <- subset(house_data, mask == F)

dim(training_data)
dim(testing_data)


#       ------------     Linear Regression Model          ----------------

#==>  Model Fitting
linear_model <- lm(price ~ ., data = training_data)

linear_model$call
linear_model$coefficients
#Summary of mdel
summary(linear_model)
#Note:- In this summary result which indicate by "**" which is less (not relevant) relevant for making model

#==> Prediction
pred_price <- predict(linear_model, testing_data)

df_pred_actual <- data.frame(predicted = pred_price, actual_price = testing_data$price)
tail(df_pred_actual)

#==> Model Evaluation 
#Testing score
cor(pred_price, testing_data$price)^2

#OR
data.frame(
  RMSE = RMSE(pred_price, testing_data$price),
  Rsquare = R2(pred_price, testing_data$price)
  
)


#      -----------     Linear Regression Model using cross validation          -----------------------

#                       Note:- these are available in caret package

#==>  Model Fitting
tc <- trainControl(method = "cv", number = 5)

lm_withCV <- train(price~., data = training_data, method = "lm", trControl = tc)
lm_withCV
summary(lm_withCV)

#Model Prediction
pred_price <- predict(lm_withCV, testing_data)

df_pred_actual <- data.frame(predicted = pred_price, actual_price = testing_data$price)
tail(df_pred_actual)

#==> Model Evaluation 
#Testing score
cor(pred_price, testing_data$price)^2

#OR
data.frame(
  RMSE = RMSE(pred_price, testing_data$price),
  Rsquare = R2(pred_price, testing_data$price)
  
)











