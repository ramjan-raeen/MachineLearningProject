rm(list = ls())

install.packages("class")
library(class)
library(caret)

#Read dataset

#Data set link: https://www.kaggle.com/sootersaalu/amazon-top-50-bestselling-books-2009-2019
amazon_book <- read.csv("datasets/bestsellers with categories.csv")

head(amazon_book)
str(amazon_book)

colnames(amazon_book)

amazon_book <- subset(amazon_book, select = -c(Name, Author))

colSums(is.na(amazon_book))

#Data transformation

amazon_book <- within(amazon_book, {
  User.Rating <- log1p(User.Rating)
  Reviews <- log1p(Reviews)
})

head(amazon_book)

#Covert Genre as numerical as Non Fiction is 0 and Fiction as 1 because knn takes numerical input only 

amazon_book$Genre <- ifelse(amazon_book$Genre == "Non Fiction", 0, 1)

head(amazon_book)

# Splitting training and testing
set.seed(123)
mask <- sample(1:nrow(amazon_book), size = nrow(amazon_book) * 0.8, replace = F)
training_data <- amazon_book[mask, ]
testing_data <- amazon_book[-mask, ]

# Splitting label as training and testing label data
train_labels <- amazon_book[mask, 5]
test_labels<- amazon_book[-mask, 5]

#Calculate knn values (Generally we calculate as below)
k_nn <- ceiling(sqrt(NROW(train_labels)))


#Fitting and predicting model

knn_model <- knn(train = training_data, test = testing_data, cl = train_labels, k = k_nn)
#Predicted labels
knn_model

summary(knn_model)

#Confusion matrix
table(knn_model, test_labels)

confusionMatrix(table(knn_model, test_labels))

#In confusion matrix Specificity low, its about 0.6346. So you have to improve your model 
# To do this, find k optimum i.e at which k value accuracy will maximum


#i = 0
k_optimum = 1

for (i in 1:k_nn+1){
  knn_model <- knn(train = training_data, test = testing_data, cl = train_labels, k = i)
  k_optimum[i] <- 100 * sum(test_labels == knn_model) / NROW(test_labels)
  k = i
  cat(k, "=", k_optimum[i], "\n")
}

#Accuracy plot
plot(k_optimum, type = "o",
     xlab = "k - value", 
     ylab = "Accuracy level",
     col = "red", frame = T)

#In the graph of above plot show that at  k = 3 has maximum accuracy and hence knn value will be 3 (i.e k = 3) nearest neighbour 
# for excellent model 
# 


knn_model_new <- knn(train = training_data, test = testing_data, cl = train_labels, k = 3)

knn_model_new

summary(knn_model_new)

table(knn_model_new, test_labels)

#In confusion matrix Specificity improved and it's now becomes 0.8654. that's a good improvement of model accuracy
confusionMatrix(table(knn_model_new, test_labels))

