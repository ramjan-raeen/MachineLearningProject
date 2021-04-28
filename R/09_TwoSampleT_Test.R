#                  -------------       Two sample t-test           ------------------------

# Note:-  Condition for two sample t-test

# 1. Data values must be independent. Measurements for one observation do not affect measurements for any other observation.
# 2. Data in each group must be obtained via a random sample from the population.
# 3. Data in each group are normally distributed.
# 4. Data values are continuous.
# 5. The variances for the two independent groups are equal.

#https://www.statisticshowto.com/pooled-standard-deviation/

#scenario for Two sample t-test, I've two sample of mall data which contains 
#Mall Spending Score of male and female and my hypothesis is that H0:(mu0 = mu1) and H1:(mu0 > mu1)



rm(list = ls())
library(dplyr)
library(tidyverse)

#dataset link :- https://www.kaggle.com/kondapuramshivani/mall-customerscsv
mall_data <- read_csv("datasets/Mall_Customers.csv")
head(mall_data)
str(mall_data)

#Rename column names
colnames(mall_data) <- c("CustomerID", "Gender", "Age", "AnnualIncome", "SpendingScore")
head(mall_data)


table(mall_data$Gender)


ggplot(mall_data, aes(x = Gender))+
  geom_bar(col = "black", fill = "blue")

qplot(x = Gender, y = SpendingScore,
      geom = "boxplot", 
      data = mall_data,
      fill = I('blue'))



#We are interested only feature spending score by two group male and female, so we selected those features only 

MallSpendingScore <- subset(mall_data, select = c(Gender, SpendingScore))
head(MallSpendingScore)

unique(MallSpendingScore$Gender)

male_score <- MallSpendingScore %>% filter(Gender == "Male")
female_score <- MallSpendingScore %>% filter(Gender == "Female")

dim(male_score)
dim(female_score)



#Group sample should be equal in length
set.seed(123)

male_score <- sample_n(male_score, 80)
female_score <- sample_n(female_score, size = 80)

dim(male_score)
dim(female_score)


# Checking normality 

qqnorm(male_score$SpendingScore, pch = 20, col = "darkgreen")
qqline(male_score$SpendingScore, col = "red")

qqnorm(female_score$SpendingScore, pch = 20, col = "darkgreen")
qqline(female_score$SpendingScore, col = "red")





#Calculate parameters as requirement for to calculate pooled standard deviation

n <- NROW(male_score$SpendingScore)
n

m <- NROW(female_score$SpendingScore)
m

x_bar = mean(male_score$SpendingScore)
std_x   = sd(male_score$SpendingScore)

y_bar = mean(female_score$SpendingScore)
std_y   = sd(female_score$SpendingScore)
x_bar
y_bar

#Pooled standard deviation
#https://www.statisticshowto.com/pooled-standard-deviation/

std_p = sqrt(((n - 1) * std_x ^ 2 + (m - 1) * std_y ^ 2) / (n + m - 2))
std_p


t_test = ((x_bar - y_bar) - 0) / (std_p * sqrt(1 / n + 1 / m))
t_test

#Calculate p-value
#Since alternate hypothesis { H0:(mu0 > mu1)} so to calculate p-value
#I have to use `1- pt()` because  lower.tail = TRUE in default otherwise go alternate/OR way in below

p_value <- 1 - pt(t_test, df = n + m - 2, lower.tail = TRUE) # lower.tail = TRUE (default) 
p_value
#Alternate wary /OR
p_value <- pt(t_test, df = n + m - 2, lower.tail = FALSE)
p_value

#Result:
#Here p_value is greater than significance therefore I can't reject null hypothesis
# i.e H0(mu0 = mu1)



#                      Calculate two-sample t-test using t.test

t_test <- t.test(mall_data$SpendingScore, 
                 mall_data$SpendingScore, 
                 alternative = c("greater"), 
                 var.equal = TRUE)
t_test


#                      Calculate two-sample t-test using wilcox.test

w_test <- wilcox.test(mall_data$SpendingScore,
                      mall_data$SpendingScore, 
                      alternative = c("greater"), 
                      var.equal = TRUE)
w_test






































