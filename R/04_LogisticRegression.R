
rm(list = ls())

install.packages("kernlab")

library(caTools)
library(scales)
library(caret)
library(kernlab)
library(ggcorrplot)

#Dataset link: https://www.kaggle.com/sowhardhhonnappa/voice-dataset
voice_data <- read.csv("datasets/voice.csv")
head(voice_data)
summary(voice_data)
str(voice_data)

colSums(is.na(voice_data))

# Here, I'm considering female as 0 and male as 1
voice_data$label <- ifelse(voice_data$label == "female", 0, 1 )

str(voice_data)


hist(voice_data$meanfreq, col = "green")
hist(voice_data$sd, col = "darkgreen")

hist(voice_data$skew, col = "red")
hist(voice_data$kurt, col = "darkred")
hist(voice_data$minfun, col = "red")
hist(voice_data$maxfun, col = "darkred")
hist(voice_data$mindom, col = "red")

voice_data <- within(voice_data, {
  #Transforming the feature
  skew <- log1p(skew)
  kurt <- log1p(kurt)
  minfun <- log1p(minfun)
  maxfun <- log1p(maxfun)
  mindom <- log1p(mindom)
  
  
  # change the data type of label as integer
  label <- as.integer(label)
})

hist(voice_data$maxfun, col = "green")
hist(voice_data$mindom, col = "green")


boxplot(voice_data$meanfreq, col = "green")

boxplot(voice_data$skew, col = "green")
boxplot(voice_data$sd, col = "red")
boxplot(voice_data$kurt, col = "red")

#Capping outliers using IOR
voice_data <- within(voice_data, {
  skew <- squish(skew, quantile(skew, c(.05, .95)))
  sd <- squish(sd, quantile(sd, c(.05, .95)))
  kurt <- squish(kurt, quantile(kurt, c(.05, .95)))
  
})

boxplot(voice_data$skew, col = "green")
boxplot(voice_data$sd, col = "red")
boxplot(voice_data$kurt, col = "red")


ggplot(data = voice_data, aes(x = label)) +
  geom_bar(aes(fill = factor(label)), width = 0.25)+
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6))


#Correlation matrix

corMatrix <- cor(voice_data)
ggcorrplot(corMatrix, lab = T, lab_size = 3)

#set seed number
set.seed(123)
#Splitting training and testing dataset
mask <- sample.split(voice_data$label, SplitRatio = 0.80)

training_data <- subset(voice_data, mask == T)
testing_data <- subset(voice_data, mask == F)

dim(training_data)
dim(testing_data)

#Model fitting

lg_reg <- glm(label~., data = training_data)

#https://discuss.analyticsvidhya.com/t/linear-regression-in-r-coefficients-having-na-in-summary-model/64624

#  Note:- 01
# In this model summary return some NA's values that means these features are not correlated to target value
# OR Two features are collinear that means two or mode feature gives same correlation 

#   Note:- 02 
#   In model summary which gives three asterisk (or *** ) that means you can remove from predictor features
#   to ignoring redundqncies. 
summary(lg_reg)


# therefore, you have to remove features which are collinears and repeat the above process

voice_data <- subset(voice_data, select = -c(centroid, IQR, skew, kurt, sp.ent, mindom, dfrange ))

#set seed number
set.seed(123)
#Splitting training and testing dataset
mask <- sample.split(voice_data$label, SplitRatio = 0.80)

training_data <- subset(voice_data, mask == T)
testing_data <- subset(voice_data, mask == F)

dim(training_data)
dim(testing_data)


#               --------------    Generalize Linear Model (glm)       ---------------------


#Model fitting

lg_reg <- glm(label~., data = training_data)
summary(lg_reg)


#Model Prediction

pred_prob <- predict(lg_reg, newdata = testing_data, type = "response")

pred_label <- ifelse(pred_prob > 0.5, 1, 0)

#Comparison 
pred_actual <- data.frame(predicted = pred_label, actual = testing_data$label)
head(pred_actual, 20)
tail(pred_actual, 20)


#Confusion Matrix

table(pred_label, testing_data$label)

confusionMatrix(table(pred_label, testing_data$label))

#       -------     Generalize linear model(glm) using caret package    -----------

tc <- trainControl(method = "cv", number = 10)

lg_reg <- train(factor(label)~., data = training_data, method = "glm", trControl = tc)

lg_reg
summary(lg_reg)


#Model Prediction

pred_label <- predict(lg_reg, newdata = testing_data)
head(pred_label)


#Comparison 
pred_actual <- data.frame(predicted = pred_label, actual = testing_data$label)
head(pred_actual, 20)
tail(pred_actual, 20)


#Confusion Matrix

table(pred_label, testing_data$label)

confusionMatrix(table(pred_label, testing_data$label))

#               --------------    Least Squares Support Vector Machine or (SVM  Model)       ---------------------



ls_svm <- lssvm(factor(label)~., data = training_data)

ls_svm
summary(ls_svm)

#Model Prediction

pred_label <- predict(ls_svm, newdata = testing_data)

#Comparison 
pred_actual <- data.frame(predicted = pred_label, actual = testing_data$label)
head(pred_actual, 20)
tail(pred_actual, 20)


#Confusion Matrix

table(pred_label, testing_data$label)

confusionMatrix(table(pred_label, testing_data$label))


