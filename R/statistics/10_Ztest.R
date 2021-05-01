# m2-demo-11-Ztest
#link :- https://www.rdocumentation.org/packages/BSDA/versions/1.2.0/topics/z.test
rm(list = ls())
install.packages("BSDA")
library(BSDA)

#Take normal distributes sample
age_men <- rnorm(150, mean = 78)
age_men

age_women <- rnorm(150, mean = 82)
age_women

mean(age_men)
mean(age_men)


# Two-sided one-sample z-test
# Assumption H0:mu0 = 76.5 is equal to  H1:mu1

z_test <- z.test(age_men, mu = 76.5, sigma.x = 1)
z_test


# Two-sided two-sample z-test
# Assumption H0:mu0 - H1:mu1 = 5

std_x <- sd(age_men)
std_y <- sd(age_women)

z_test <- z.test(age_men, sigma.x =std_x, age_women, sigma.y = std_y, mu = 5 )
z_test


# Two-sided standard two-sample z-test
# Assumption is that H0:mu0 - H1:mu1 = 0

z_test <- z.test(age_men, sigma.x = std_x, age_women, sigma.y = std_y, conf.level = 0.90)
z_test


#            ---------------------    z.test       -------------------------

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


#I'm interested only to analysis bmi of smoker and non-smoker
smoker_bmi <- subset(insurance_data, select = c(smoker, bmi))
head(smoker_bmi)

table(smoker_bmi$smoker)



#Graphical view

ggplot(smoker_bmi, aes(smoker))+
  geom_bar(col = 'black', fill = 'blue')


qplot(x = smoker, y = bmi,
      geom = "boxplot", 
      data = smoker_bmi,
      fill = I('blue'))


#separating two group, first group smoker and second group non-smoker 
smoker <- smoker_bmi %>% filter(smoker == "yes")
non_smoker <- smoker_bmi %>% filter(smoker == "no")


#Group sample should be equal
dim(smoker)
dim(non_smoker)


set.seed(123)
smoker <- sample_n(smoker, 270, replace = F)
non_smoker <- sample_n(non_smoker, 270, replace = F)

dim(smoker)
dim(non_smoker)



#Checking normalization of data set 
hist(smoker$bmi, col = "blue")
hist(non_smoker$bmi, col = "green")

#OR
qqnorm(smoker$bmi, pch = 20, col = "darkgreen")
qqline(smoker$bmi, col = "red")

qqnorm(non_smoker$bmi, pch = 20, col = "darkgreen")
qqline(non_smoker$bmi, col = "red")





# Assumption H0:mu0 - H1:mu1 = 5

std_x <- sd(smoker$bmi)
std_y <- sd(non_smoker$bmi)

z_test <- z.test(smoker$bmi, sigma.x =std_x, non_smoker$bmi, sigma.y = std_y, mu = 5 )
z_test


# Two-sided standard two-sample z-test
# Assumption is that H0:mu0 - H1:mu1 = 0

z_test <- z.test(smoker$bmi, sigma.x = std_x, non_smoker$bmi, sigma.y = std_y, conf.level = 0.90)
z_test







