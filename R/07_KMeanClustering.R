rm(list = ls())

install.packages("cluster")
install.packages("factoextra")
install.packages('ggcorrplot')

library(ggcorrplot)
library(tidyverse)
library(cluster)
library(factoextra)

#Dataset link: -https://www.kaggle.com/kondapuramshivani/mall-customerscsv
mall_data <- read.csv("datasets/Mall_Customers.csv")

head(mall_data)


#Rename columns name for suitable
colnames(mall_data)
colnames(mall_data) <- c("CustomerID", "Gender", "Age", "AnnualIncome", "SpendingScore")
mall_data <- subset(mall_data, select = -c(CustomerID))

#Since, kmeans takes only numerical values so I converted Male 1 and female as 0
mall_data$Gender <- ifelse(mall_data$Gender == "Male", 1, 0)

head(mall_data)
str(mall_data)


#Correlation of dataset
corMatrix <- cor(mall_data)
ggcorrplot(corMatrix, lab = T,lab_size = 3)

#        ------------    KMean clustering        -----------------------

#link:- https://www.datanovia.com/en/lessons/determining-the-optimal-number-of-clusters-3-must-know-methods/#fviz_nbclust-function-elbow-silhouhette-and-gap-statistic-methods
# Initially I'm considering two cluster, so centers = 2

# Note:= nstart is initial configuration 

# Note:-
# cluster: A vector of integers (from 1:k) indicating the cluster to which each point is allocated.
# centers: A matrix of cluster centers.
# totss: The total sum of squares.
# withinss: Vector of within-cluster sum of squares, one component per cluster.
# tot.withinss: Total within-cluster sum of squares, i.e. sum(withinss).
# betweenss: The between-cluster sum of squares, i.e. $totss-tot.withinss$.
# size: The number of points in each cluster.

KMean <- kmeans(mall_data, centers = 2, nstart = 25)

str(KMean)

KMean

KMean$centers

KMean$withinss

KMean$tot.withinss


#See graphical view for two cluster as I consider
fviz_cluster(KMean, geom = "point", data = mall_data)


#Now, I'm considering three cluster, so centers = 3
# Note:= nstart is initial configuration 

KMean <- kmeans(mall_data, centers = 3, nstart = 25)

str(KMean)

KMean

fviz_cluster(KMean, geom = "point", data = mall_data)


# Find the optimal numbers of clusters 
# For this I'll go for following 
# link:- https://medium.com/codesmart/r-series-k-means-clustering-silhouette-794774b46586


# 1. Elbow method, 
# 2. Silhouette method


# Elbow Method

set.seed(123)

wss <- function(k){
  kmeans(mall_data, k, nstart = 20)$tot.withinss
}

k_values <- 2:10
wss_values <- map_dbl(k_values, wss)

#Note:- In the plot  at k = 6 it look likes elbow therefore you can say it has six clusters
# Lets go for Average Silhouette Method for more clarification
plot(k_values, wss_values, 
     type = "b", pch = 19, frame = F, 
     col = "darkgreen",
     xlab = "Number of cluster K",
     ylab = "Total within cluster sum of squares",
     main = "Elbow plot for optimal number of clusters")


#You can do same thing by using "fviz_nbclust" function which is inside "factoextra" package

#Note:- Now, its clear elbow at k = 6
set.seed(123)
fviz_nbclust(mall_data, kmeans, method = "wss", k.max = 10)



#Average Silhouette Method

silhouette_score <- function(k){
  k_means <- kmeans(mall_data, centers = k, nstart = 20)
  sum_square <- silhouette(k_means$cluster, dist(mall_data))
  mean(sum_square[,3])
}


k_values <- 2:10
avg_silhouette <- sapply(k_values, silhouette_score)

plot(k_values, avg_silhouette,
     type='b' , pch = 19,
     frame=FALSE, col = "blue",
     xlab='Number of clusters', 
     ylab='Average Silhouette Width',
     main = "Silhouette width plot for optimal number of clusters")
abline(v = 6, lwd = 2, col = "red")

#you can do same things using "fviz_nbclust" function which is inside "cluster" package

#you can see at k = 6 average silhouette width has max
# therefore you can clearly say that this data has six cluster

fviz_nbclust(mall_data, kmeans, method = "silhouette")



#KMeans at k = 6

KMean <- kmeans(mall_data, centers = 6, nstart = 20)

str(KMean)

KMean

#Plotting six clusters
fviz_cluster(KMean, geom = "point", data = mall_data)














