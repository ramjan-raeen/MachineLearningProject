rm(list = ls())

library(tidyverse)
library(dplyr)


mall_data <- read_csv("datasets/Mall_Customers.csv")
head(mall_data)
str(mall_data)

#Rename column names
colnames(mall_data) <- c("CustomerID", "Gender", "Age", "AnnualIncome", "SpendingScore")
head(mall_data)

MallSpendingScore <- subset(mall_data, select = c(Gender, SpendingScore))
head(MallSpendingScore)

table(mall_data$Gender)


ggplot(mall_data, aes(x = Gender))+
        geom_bar(col = "black", fill = "blue")

qplot(x = Gender, y = SpendingScore,
      geom = "boxplot", 
      data = mall_data,
      fill = I('blue'))

#               --------------     Requirements for t-test      ----------------


# Note: - Condition for t-test

# i.    Data should be independent.
# ii.   Data should be collected randomly
# iii.  The data should be approximately normally distributed 

#Check condition of normality


#Checking, data approximately normally distributed or not?

hist(mall_data$SpendingScore, breaks = 30, col = 'blue')
qqnorm(mall_data$SpendingScore, col = 'green')
qqline(mall_data$SpendingScore, col = 'red')
# by looking histogram and q-q graph it's look quite normally distributed


#                           scenario for calculating one sided t-test

#Here I'm considering that average height of male is mu_0 = 50.5
# So, Null hypothesis become (H0) and Alternate hypothesis become as (H1)
# So, I've to calculate hypothesis test that H0: mu = mu_0 versus H1:mu != mu_0
# And significance level = 0.05 or 5%

mean_score <- mean(mall_data$SpendingScore)
mean_score

mu_0 <- 50.5
std <- sd(mall_data$SpendingScore)
n <- length(mall_data$SpendingScore)

t_test <- (mean_score - mu_0) / (std - sqrt(n))
t_test

p_value <- pt(t_test, df = n -1)
p_value

#Note:- 
# the p_value > significance level therefore I can't reject null hypothesis (i.e H0:mu = mu_0)

t <- seq(-2, 2, by = .1)

plot(x = t, 
     y = dt(t, n-1), 
     type = "l",
     lty = "dotted",
     col = "red", lwd = 2,
     ylim = c(0,.4),
     xlab = "t", ylab = "f(t)")
abline(v = t_test, col = 'darkgreen', lwd = 2)


t_test  = t.test(mall_data$SpendingScore , mu = 50.5, alternative = c("less"), conf.level = 0.95)
t_test

#Access Parameters
names(t_test)

t_test$statistic

t_test$parameter

t_test$p.value

t_test$conf.int






#find t_test and p_value for two-sided t-test

ts_t.test  = t.test(mall_data$SpendingScore , mu = 50.5, alternative = c("two.sided"), conf.level = 0.95)
ts_t.test

#Access parameters
ts_t.test$statistic

ts_t.test$p.value

ts_t.test$conf.int

ts_t.test$estimate

#Graphical view
plot(x = t, 
     y = dt(t, n-1), 
     type = "l",
     lty = "dotted",
     col = "red", lwd = 2,
     ylim = c(0,.4),
     xlab = "t", ylab = "f(t)")
abline(v=ts_t.test$statistic, col = 'darkgreen', lwd = 2)
abline(v = -ts_t.test$statistic, col = 'darkgreen', lwd = 2)


#           --------------          Wilcoxon signed-rank test      ------------------------------

# t.test by using  using Wilcoxon signed-rank test

w_test <- wilcox.test(mall_data$SpendingScore, mu = 50.5, alternative =c("less"))

w_test

w_test$method

w_test$statistic

w_test$p.value

# t.test by using  using Wilcoxon signed-rank test (two sided)

w_test <- wilcox.test(mall_data$SpendingScore, mu = 50.5, alternative =c("two.sided") )
w_test


w_test$method

w_test$statistic

w_test$p.value


