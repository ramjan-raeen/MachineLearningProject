
rm(list = ls())

install.packages("devtools")
library(devtools)
devtools::install_github("cardiomoon/webr")

library(webr)



#                   -------------       Paired t.test        ----------------


#Condition for pair t.test


# 1. The sampling method for each sample is simple random sampling.
# 2. The test is conducted on paired data. (As a result, the data sets are not independent.)
# 3. The sampling distribution is approximately normal, which is generally true if any of the following conditions apply.
#       i.   The population distribution is normal.
#       ii.  The population data are symmetric, unimodal, without outliers, and the sample size is 15 or less.
#       ii.  The population data are slightly skewed, unimodal, without outliers, and the sample size is 16 to 40.
#       iv.  The sample size is greater than 40, without outliers.


#Dataset link :- https://www.kaggle.com/unsdsn/world-happiness
happiness_data_2015 <- read.csv("datasets/2015.csv")
happiness_data_2016 <- read.csv("datasets/2016.csv")

str(happiness_data_2015)
col_name <-  c("Country", "Region", "HappinessRank", "HappinessScore","StandardError", 
               "EconomyGDPPerCapita", "Family", "HealthLifeExpectancy","Freedom", 
               "TrustGovernmentCorruption", "Generosity", "DystopiaResidual")


colnames(happiness_data_2015) <- col_name
colnames(happiness_data_2016) <- col_name

head(happiness_data_2015)
head(happiness_data_2016)

dim(happiness_data_2015)
dim(happiness_data_2016)

#Taking only one attributes happiness score from 2015 for sample 1
# and one attributes happiness score from 2016 for sample 2.

# Note:- Make sure length of sample must be same

HScore_2015 <- happiness_data_2015[["HappinessScore"]]
HScore_2016 <- happiness_data_2016[["HappinessScore"]]

length(HScore_2015)
length(HScore_2016)


qqnorm(HScore_2015, pch = 20, col = "darkgreen")
qqline(HScore_2015, col = 'red', lwd = 2.5)

qqnorm(HScore_2016, pch = 20, col = "darkgreen")
qqline(HScore_2016, col = 'red', lwd = 2.5)



#Paire t.test using t.test function

paired_test <- t.test(HScore_2015, HScore_2016, paired = TRUE)

paired_test

paired_test$method

paired_test$statistic

paired_test$p.value

paired_test$conf.int

paired_test$stderr

paired_test$estimate

#Graphical view
plot(paired_test)

#Paire t.test using wilcox.test

w_paired_test <- wilcox.test(HScore_2015, HScore_2016, paired = TRUE)
w_paired_test

w_paired_test$method

w_paired_test$statistic

w_paired_test$p.value












