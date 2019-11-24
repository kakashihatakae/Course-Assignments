data <- read.csv('Vocab.csv')

X <- cbind(data$education, rep(1, length(data$education))) 
Y <- data$vocabulary #scores
#X t Xw = X t y

xtx <- t(X) %*% X
xty <- t(X) %*% Y

W <- solve(xtx) %*% xty
k <- X%*%W

plot(X[,1], X%*%W)

#d
change_in_marks  <- 1 * W[1]