data <- read.table("time_series.dat")
n <- nrow(data)
fet1 <- data[1:(n-2),]
fet2 <- data[2:(n-1),]
Y <- data[3:n,]

X <- cbind(fet1, fet2)

w <- solve(t(X) %*% as.matrix(X)) %*% (t(X) %*% Y)
y_pred <- X %*% w

diff <- y_pred - Y

var(Y - X %*% w)