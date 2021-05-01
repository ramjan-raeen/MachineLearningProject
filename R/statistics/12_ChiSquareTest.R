#             ---------------      chi-square test        -------------------

# link:- https://stattrek.com/chi-square-test/goodness-of-fit.aspx#:~:text=The%20chi%2Dsquare%20goodness%20of%20fit%20test%20is%20appropriate%20when,variable%20is%20at%20least%205.

# The chi-square goodness of fit test is appropriate when the following conditions are met:
#   
#   1. The sampling method is simple random sampling.
#   2. The variable under study is categorical.
#   2. The expected value of the number of sample observations in each level of the variable is at least 5.


# State the Hypotheses
# Every hypothesis test requires the analyst to state a null hypothesis (Ho) and an alternative hypothesis (Ha). The hypotheses are stated in such a way that they are mutually exclusive. That is, if one is true, the other must be false; and vice versa.
# 
# For a chi-square goodness of fit test, the hypotheses take the following form.
# 
# H0: The data are consistent with a specified distribution.
# H1: The data are not consistent with a specified distribution.

rm(list = ls())

library(ggplot2)

insurance_data <- read.csv('datasets/insurance.csv', stringsAsFactors = T)
head(insurance_data)
dim(insurance_data)
str(insurance_data)



unique(insurance_data$sex)
unique(insurance_data$smoker)
unique(insurance_data$region)


table(insurance_data$sex)
table(insurance_data$smoker)
table(insurance_data$region)


#Graphical view

ggplot(insurance_data, aes(smoker))+
  geom_bar(col = 'black', fill = 'blue')

ggplot(insurance_data, aes(sex))+
  geom_bar(col = 'black', fill = "green")

ggplot(insurance_data, aes(children))+
  geom_bar(col = 'black', fill = "red")

ggplot(insurance_data, aes(region))+
  geom_bar(col = 'black', fill = "red")



#ChiSquare test

chisq_test <- chisq.test(insurance_data$sex, insurance_data$smoker)
chisq_test
plot(chisq_test)

chisq_test$statistic
chisq_test$p.value
chisq_test$method
chisq_test$expected
chisq_test$observed

expected <- as.matrix(chisq_test$expected)
observed <- as.matrix(chisq_test$observed)


barplot(expected, beside = T, col = c("orange", "blue"), 
        main = "Expected frequencies of male and female")
legend("topright", c("orange", "blue"), cex = 1.3, bty = "n", fill = c("orange", "blue"))

barplot(observed, beside = T, col = c("orange", "blue"), 
        main = "Expected frequencies of male and female")
legend("topright", c("orange", "blue"), cex = 1.3, bty = "n", fill = c("orange", "blue"))



#              ---------------     fisher test      ------------------            

fisher_test <- fisher.test(insurance_data$sex, insurance_data$smoker, simulate.p.value = T)
fisher_test

fisher_test$p.value
fisher_test$conf.int
fisher_test$estimate





