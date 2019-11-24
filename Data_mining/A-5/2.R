aus_data <- read.csv("ais.csv",stringsAsFactors=FALSE, sep=",")

Y <- aus_data$rcc
X <- aus_data[,3:12]

xtx <- t(X) %*% as.matrix(X)
xty <- t(X) %*% Y

W <- solve(xtx) %*% xty
W

y_pred <- as.matrix(X) %*% W

error <- (Y - y_pred)
error_square <- error^2
sum_error <- sum(error_square)

#d
lis_errors <- c()
for(i in 3:12){
    new_data <- X
    new_data <- new_data[-i] 

    W <- solve(t(new_data) %*% as.matrix(new_data)) %*% (t(new_data) %*% Y)
    y_pred <- as.matrix(new_data) %*% W

    error <- (Y - y_pred)
    error_square <- error^2
    sum_error <- sum(error_square)
    print(sum_error)
    lis_errors <- c(lis_errors, sum_error)
}

#6th variable causes the greates change in error