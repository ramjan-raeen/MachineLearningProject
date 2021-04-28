rm(list = ls())

install.packages("glmnet")
library(caret)
library(magrittr)
library(ggplot2)
library(caTools)
library(glmnet)
library(ggcorrplot)


#Dataset link: https://www.kaggle.com/adityadeshpande23/admissionpredictioncsv
admission_data <- read.csv("datasets/Admission_Predict.csv")
head(admission_data)
dim(admission_data)

colSums(is.na(admission_data))

admission_data <- subset(admission_data, select = -c(Serial.No.))
head(admission_data)
dim(admission_data)


colnames(admission_data)

rename_col <- c("GRE_score", "TOEFL_score", "University_rating",
                "SOP", "LOR", "CGPA", "Research", "Chance_Of_Admit")

colnames(admission_data) <- rename_col

colnames(admission_data)
#Normalization

admission_data <- within(admission_data, {
  GRE_score <- (GRE_score - min(GRE_score)) / (max(GRE_score) - min(GRE_score))
  TOEFL_score <- (TOEFL_score - min(TOEFL_score)) / (max(TOEFL_score) - min(TOEFL_score))
})


head(admission_data)

ggplot(admission_data, aes( x = GRE_score, y = Chance_Of_Admit)) + 
  geom_point(size = 2, col = "blue")

ggplot(admission_data, aes( x = GRE_score, y = Chance_Of_Admit, col = factor(Research))) + 
  geom_point(size = 2.5)

ggplot(admission_data, aes( x = CGPA, y = Chance_Of_Admit)) + 
  geom_point(size = 2, col = "darkgreen")

ggplot(admission_data, aes( x = TOEFL_score, y = Chance_Of_Admit)) + 
  geom_point(size = 2, col = "darkblue")


corMatrix <- cor(admission_data)
ggcorrplot(corMatrix, lab = T, lab_size = 3)

# Splitting training and testing data
set.seed(1)
mask <- sample.split(admission_data$Chance_Of_Admit, SplitRatio = 0.80)

trainig_data <- subset(admission_data, mask == T)
testing_data <- subset(admission_data, mask == F)

dim(trainig_data)
dim(testing_data)


#               --------------    Ridge Regression       ---------------------
#Ridge Regrssion :- http://www.sthda.com/english/articles/37-model-selection-essentials-in-r/153-penalized-regression-essentials-ridge-lasso-elastic-net/#elastic-net



#==> model Fitting 


#               !!---------> Note:- <---------!! 

# x: matrix of predictor variables
# y: the response or outcome variable.
# alpha: the elasticnet mixing parameter. Allowed values include:
#   “1”: for lasso regression
# “0”: for ridge regression
# a value between 0 and 1 (say 0.3) for elastic net regression.
# lambda: a numeric value defining the amount of shrinkage. Should be specify by analyst.

# In penalized regression, you need to specify a constant lambda to adjust the amount 
# of the coefficient shrinkage. The best lambda for your data, can be defined as the 
# lambda that minimize the cross-validation prediction error rate. 
# This can be determined automatically using the function cv.glmnet().


set.seed(123)

x <- model.matrix(Chance_Of_Admit~., trainig_data)[,-1]

y <- trainig_data$Chance_Of_Admit

cv <- cv.glmnet(x, y, alpha = 0)

cv$lambda.min


ridge_reg <- glmnet(x, y, alpha = 0, lambda = cv$lambda.min)

coef(ridge_reg)




#==> Model Prediction
x_test <- model.matrix(Chance_Of_Admit~., testing_data)[,-1]
ridge_pred <- predict(ridge_reg, x_test)%>%as.vector()

df_pred_actual <- data.frame(predicted = ridge_pred, actual_price = testing_data$Chance_Of_Admit)
head(df_pred_actual)
tail(df_pred_actual)


#==> Model Evaluation
cor(ridge_pred, testing_data$Chance_Of_Admit)^2

data.frame(RMSE = RMSE(ridge_pred, testing_data$Chance_Of_Admit),
           Rsquare = R2(ridge_pred, testing_data$Chance_Of_Admit))





#               --------------    Lasso Regression       ---------------------


#Model fitting
set.seed(123)

cv <- cv.glmnet(x, y, alpha = 1)
cv$lambda.min

lasso_reg <- glmnet(x, y, alpha = 1, lambda = cv$lambda.min )
coef(lasso_reg)


#Model Predction
lasso_pred <- predict(lasso_reg, x_test) %>% as.vector()


data.frame(
  RMSE = RMSE(lasso_pred, testing_data$Chance_Of_Admit),
  Rsquare = R2(lasso_pred, testing_data$Chance_Of_Admit)
)





#               --------------    Elastic Net  Regression       ---------------------

#Model Fitting
set.seed(123)

enet_model <- train(
  Chance_Of_Admit ~., data = trainig_data, method = "glmnet",
  tc = trainControl("cv", number = 10),
  tuneLength = 10
)

#Best value for alpha and lambda 
enet_model$bestTune

coef(enet_model$finalModel, enet_model$bestTune$lambda)


#Model Prediction

enet_pred <- predict(enet_model, x_test)%>% as.vector()

data.frame(
  RMSE = RMSE(enet_pred, testing_data$Chance_Of_Admit),
  Rsquare = R2(enet_pred, testing_data$Chance_Of_Admit)
)

















