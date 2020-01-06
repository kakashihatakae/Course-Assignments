library(quadprog)

N <- 50
X <- matrix(0,nrow = N, ncol = 2);
W <- rnorm(5)
C <- matrix(0, nrow=N, ncol=1)
data <- matrix(0, nrow=N, ncol=5)
A <- matrix(0, nrow=N, ncol=5)

for(i in 1:N){
    X[i,] = runif(2, -pi, pi)
    data[i,][1] = 1
    data[i,][2] = X[i,][1]
    data[i,][3] = X[i,][2]
    data[i,][4] = cos(X[i,][1])
    data[i,][5] = sin(X[i,][1])

    C[i] <- sign(t(W) %*% data[i,])
    A[i,] <- C[i,]*data[i,]
}

plot(X, pch=(C+5), col=(C+3))

data <- as.matrix(data)

Q <- diag(5)
Q[5,5] <- 0.01
q <- rep(0, 5)
b <- rep(1, N)
result <- solve.QP(Q,q,t(A),b)

What <- result$solution
x <- runif(1000, -pi, pi)
y <- -(What[1] + What[2]*x + What[4]*cos(x) + What[5]*sin(x))/What[3]
plot(x,y, col='red')
lines(X, pch=C+3, type='p', col=(C+5))