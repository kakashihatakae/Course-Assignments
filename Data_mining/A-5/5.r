X2 <- read.table("pred2.dat")
Y2 <- read.table('resp2.dat')

X2_1 <- X2[1:nrow(X2)/2, ]
Y2_1 <- Y2[1:nrow(X2)/2, ]

X2_2 <- X2[((nrow(X2)/2) + 1):nrow(X2), ]
Y2_2 <- Y2[((nrow(X2)/2) + 1):nrow(X2), ]

W2_r <- solve(t(X2_1) %*% as.matrix(X2_1) + 20*diag(length(X2_1))) %*% (t(X2_1) %*% Y2_1)
y_hat_r <- as.matrix(X2_2) %*% as.matrix(W2_r)
SSE_r <- sum((y_hat_r - Y2_2)^2)

W2_n <- solve(t(X2_1) %*% as.matrix(X2_1)) %*% (t(X2_1) %*% Y2_1)
y_hat_n <- as.matrix(X2_2) %*% as.matrix(W2_n)
SSE_n <- SSE_r <- sum((y_hat_n - Y2_2)^2)

SSE_n
SSE_r

SSE_list <- c()
for(lambda in 10:100){
    if(! lambda %% 5){
        W <- solve(t(X2_1) %*% as.matrix(X2_1) + lambda*diag(length(X2_1))) %*% (t(X2_1) %*% Y2_1)
        y_hat <- as.matrix(X2_2) %*% as.matrix(W)
        SSE <- sum((y_hat - Y2_2)^2)
        print(lambda)
        print(SSE)
        SSE_list <- c(SSE, SSE_list)
    }
}
length(SSE_list)
plot(1:19, SSE_list, type='l')