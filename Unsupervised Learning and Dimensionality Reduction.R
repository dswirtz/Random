#references
#https://uc-r.github.io/kmeans_clustering
#https://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/
#https://www.r-bloggers.com/maximize-your-expectations/
#https://rstudio-pubs-static.s3.amazonaws.com/278584_c7a332303ef64aafa6911f834c64c85c.html


library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization


#read breast cancer data
bc_dat <- read.csv('D:/Georgia Tech/CS 7641/Assignment 3/breastcancer.csv', stringsAsFactors = FALSE)
bc_dat$Class[bc_dat$Class == 2] <- 'benign'
bc_dat$Class[bc_dat$Class == 4] <- 'malignant'

#read diabetes data
diab_dat <- read.csv('D:/Georgia Tech/CS 7641/Assignment 3/diabetes.csv', stringsAsFactors = FALSE)

#set seed for reproducibility
set.seed(27)

#function for feature scaling
scl <- function(x){ (x - min(x))/(max(x) - min(x)) }

#reduce data to remove label features
bc_dat <- bc_dat[,1:(length(bc_dat)-1)]
diab_dat <- diab_dat[,1:(length(diab_dat)-1)]

#scale diabetes data because of data ranges    
diab_dat <- data.frame(lapply(diab_dat, scl))

#kmeans
##breast cancer data

#elbow diagrams to determine optimal k
fviz_nbclust(bc_dat, kmeans, method = 'wss')
k3 <- kmeans(bc_dat, centers = 3, nstart = 25)
fviz_cluster(k3, data = bc_dat)
k2 <- kmeans(bc_dat, centers = 2, nstart = 25)
fviz_cluster(k2, data = bc_dat)

table(read.csv('D:/Georgia Tech/CS 7641/Assignment 3/breastcancer.csv', stringsAsFactors = FALSE)$Class, k2$cluster)

##diabetes data

#elbow diagrams to determine optimal k
fviz_nbclust(diab_dat, kmeans, method = 'wss')
k4 <- kmeans(diab_dat, centers = 4, nstart = 25)
fviz_cluster(k4, data = diab_dat)
k2 <- kmeans(diab_dat, centers = 2, nstart = 25)
fviz_cluster(k2, data = diab_dat)

table(read.csv('D:/Georgia Tech/CS 7641/Assignment 3/diabetes.csv', stringsAsFactors = FALSE)$Class, k2$cluster)

#EM


#PCA
pcaCharts <- function(x) {
    x.var <- x$sdev ^ 2
    x.pvar <- x.var/sum(x.var)
    print("proportions of variance:")
    print(x.pvar)
    
    par(mfrow=c(2,2))
    plot(x.pvar,xlab="Principal component", ylab="Proportion of variance explained", ylim=c(0,1), type='b')
    plot(cumsum(x.pvar),xlab="Principal component", ylab="Cumulative Proportion of variance explained", ylim=c(0,1), type='b')
    screeplot(x)
    screeplot(x,type="l")
    par(mfrow=c(1,1))
}

bcPCA <- prcomp(scale(bc_dat))
pcaCharts(bcPCA)
plot(x = bcPCA$x[,1:2], col = read.csv('D:/Georgia Tech/CS 7641/Assignment 3/breastcancer.csv', stringsAsFactors = FALSE)$Class)

diabPCA <- prcomp(scale(diab_dat))
pcaCharts(diabPCA)
plot(x = diabPCA$x[,1:2], col = as.factor(read.csv('D:/Georgia Tech/CS 7641/Assignment 3/diabetes.csv', stringsAsFactors = FALSE)$Class))
