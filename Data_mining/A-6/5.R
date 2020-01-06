give_labels <- function(clus, centers){
    d <- c()
    labels <- c()
    for(i in 1:200){
        d1 <- dist(clus[i,], centers[1,])
        d2 <- dist(clus[i,], centers[2,])
        d3 <- dist(clus[i,], centers[3,])
        d4 <- dist(clus[i,], centers[4,])
    # d < c(, dist(clus[i,], c[2,]), dist(clus[i,], c[3,]), dist(clus[i,], c[4,]))
        d <- c(d1, d2, d3, d4)
        labels <- c(labels, which(d == min(d)))
        d <- c()
    }
    clus <- cbind(clus, labels)
    # View(clus)
    
    # new_centers <- c(mean(clus[clus[3] == 1,]), mean(clus[clus[3]==2,]), mean(clus[clus[3]==3,]), mean(clus[clus[3]==4,]))
    # new_centers
    clus
}

dist <- function(x, c){
    sum((x-c)^2)
}

mean_center <- function(c){
    x <- mean(c[,1])
    y <- mean(c[,2])
    c(x,y)
}

assign_center <- function(new_clus, n){
    if(sum(new_clus[,3]==n)>1){
        x <- new_clus[new_clus[,3] == n,]
        # View(x)
        x <- mean_center(x)
    } else {
        x <- centers[n,]
    }
    x
}

# cluster1
z <- cbind(rnorm(50, mean=0,sd=1), rnorm(50, mean=0, sd=1))
T <- rnorm(4, mean=0, sd=1)
b <- rnorm(2, mean=0, sd=10)
T <- cbind(c(T[1], T[2]), c(T[3], T[4]))
cluster1 <- T %*% t(z) + b
cluster1 <- t(cluster1)

# cluster2
z <- cbind(rnorm(50, mean=0,sd=1), rnorm(50, mean=0, sd=1))
T <- rnorm(4, mean=0, sd=1)
b <- rnorm(2, mean=0, sd=10)
T <- cbind(c(T[1], T[2]), c(T[3], T[4]))
cluster2 <- T %*% t(z) + b
cluster2 <- t(cluster2)

# cluster3
z <- cbind(rnorm(50, mean=0,sd=1), rnorm(50, mean=0, sd=1))
T <- rnorm(4, mean=0, sd=1)
b <- rnorm(2, mean=0, sd=10)
T <- cbind(c(T[1], T[2]), c(T[3], T[4]))
cluster3 <- T %*% t(z) + b
cluster3 <- t(cluster3)

# cluster4
z <- cbind(rnorm(50, mean=0,sd=1), rnorm(50, mean=0, sd=1))
T <- rnorm(4, mean=0, sd=1)
b <- rnorm(2, mean=0, sd=10)
T <- cbind(c(T[1], T[2]), c(T[3], T[4]))
cluster4 <- T %*% t(z) + b
cluster4 <- t(cluster4)

# clusters <- c()

# for(i in 0:3){
#     # z <- rnorm(100, mean=0, sd=1)
#     # z <- cbind(z[1:50], z[51:100])
#     z <- cbind(rnorm(50, mean=0,sd=1), rnorm(50, mean=0, sd=1))
#     T <- rnorm(4, mean=0, sd=1)
#     b <- rnorm(2, mean=0, sd=10)
#     T <- cbind(c(T[1], T[3]), c(T[2], T[4]))
#     cluster4 <- T %*% t(z) + b
#     clusters <- c(clusters, t(cluster4))
# }

clus <- rbind(cluster1, cluster2, cluster3, cluster4)

centers<- cbind(rnorm(4, mean=0, sd=1), rnorm(4, mean=0, sd=1))

count=500
while(count >0){
    # print(count)
    new_clus <- give_labels(clus, centers)
    c1 <- assign_center(new_clus, 1)
    c2 <- assign_center(new_clus, 2)
    c3 <- assign_center(new_clus, 3)
    c4 <- assign_center(new_clus, 4)
    
    count = count - 1
    centers <- c()
    centers <- rbind(c1, c2, c3, c4)
    # print(centers)
}

print(centers)

color <- rep(0, 200)


plot(new_clus[,1:2], col=new_clus[,3])
points(centers, pch='x',col=1:4, cex=3)