rm(list = ls())

library(ggplot2)
library(caTools)

#Dataset link: -https://www.kaggle.com/unsdsn/world-happiness
happiness_score <- read.csv("datasets/2015.csv")

summary(happiness_score)
head(happiness_score)
str(happiness_score)

happiness_score <- subset(happiness_score, select = -c(Country, Region))

colnames(happiness_score) <- c("HappinessRank", "HappinessScore","StandardError", "EconomyGDPPerCapita", 
                               "Family", "HealthLifeExpectancy","Freedom", "TrustGovernmentCorruption", 
                               "Generosity", "DystopiaResidual")
colnames(happiness_score)
head(happiness_score)

dim(happiness_score)

hist(happiness_score$HappinessScore, col = "blue")
hist(happiness_score$StandardError, col = "blue")
hist(happiness_score$EconomyGDPPerCapita, col = "blue")
hist(happiness_score$Family, col = "blue")

boxplot(happiness_score$HappinessScore, col = "green")
boxplot(happiness_score$StandardError, col = "green")
boxplot(happiness_score$HealthLifeExpectancy, col = "green")
boxplot(happiness_score$EconomyGDPPerCapita, col = "green")

ggplot(happiness_score, aes(x = StandardError, y = HappinessScore))+
  geom_point(size = 2.5, col = "red")

ggplot(happiness_score, aes(x = HealthLifeExpectancy, y = HappinessScore))+
  geom_point(size = 2.5, col = "darkgreen")


ggplot(happiness_score, aes(x = EconomyGDPPerCapita, y = HappinessScore))+
  geom_point(size = 2.5, col = "darkgreen")

ggplot(happiness_score, aes(x = Freedom, y = HappinessScore))+
  geom_point(size = 2.5, col = "darkgreen")

ggplot(happiness_score, aes(x = Family, y = HappinessScore))+
  geom_point(size = 2.5, col = "red")

ggplot(happiness_score, aes(x = Generosity, y = HappinessScore))+
  geom_point(size = 2.5, col = "blue")



#Correlation matrix

corMatrix <- cor(happiness_score)
ggcorrplot(corMatrix, lab = T, lab_size = 3)


#Splitting training and testing dataset
set.seed(1)
mask <- sample.split(happiness_score$HappinessScore, SplitRatio = 0.80)

training_data <- subset(happiness_score, mask == T)
testing_data <- subset(happiness_score, mask == F)

dim(training_data)
dim(testing_data)

library(caret)
#Random forest

lm_withRF <- train(HappinessScore ~., data = training_data, method = "rf")
lm_withRF

#Model Prediction
pred_HappinessScore <- predict(lm_withRF, testing_data)

pred_actual <- data.frame(predicted = pred_HappinessScore,
                          actual_HappinessScore = testing_data$HappinessScore)
head(pred_actual)

#==> Model Evaluation 
#Testing score
cor(pred_HappinessScore, testing_data$HappinessScore)^2

#OR
data.frame(
  RMSE = RMSE(pred_HappinessScore, testing_data$HappinessScore),
  Rsquare = R2(pred_HappinessScore, testing_data$HappinessScore)
  
)



#      ----------------   Using cross validation       ----------------------


tc <- trainControl(method = "cv", number = 10)

lm_withRFCV <- train(HappinessScore ~., data = training_data, method = "rf", trControl = tc)
lm_withRFCV


#Model Prediction
pred_HappinessScore <- predict(lm_withRFCV, testing_data)

pred_actual <- data.frame(predicted = pred_HappinessScore,
                             actual_HappinessScore = testing_data$HappinessScore)
tail(pred_actual)

#==> Model Evaluation 
#Testing score
cor(pred_HappinessScore, testing_data$HappinessScore)^2

#OR
data.frame(
  RMSE = RMSE(pred_HappinessScore, testing_data$HappinessScore),
  Rsquare = R2(pred_HappinessScore, testing_data$HappinessScore)
  
)




















