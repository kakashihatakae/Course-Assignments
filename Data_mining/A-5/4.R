X1 <- read.table("pred1.dat")
Y1 <- read.table('resp1.dat')

X1_1 <- X1[1:nrow(X1)/2, ]
Y1_1 <- Y1[1:nrow(X1)/2, ]

X1_2 <- X1[(nrow(X1)/2+1):nrow(X1), ]
Y1_2 <- Y1[(nrow(X1)/2+1):nrow(X1), ]

W1 <- solve(t(X1_1) %*% as.matrix(X1_1)) %*% (t(X1_1) %*% Y1_1)

SSE_1 <- sum(((as.matrix(X1_2) %*% as.matrix(W1)) - Y1_2)^2)
SSE_1


X2 <- read.table("pred2.dat")
Y2 <- read.table('resp2.dat')

X2_1 <- X2[1:nrow(X2)/2, ]
Y2_1 <- Y2[1:nrow(X2)/2, ]

X2_2 <- X2[((nrow(X2)/2) + 1):nrow(X2), ]
Y2_2 <- Y2[((nrow(X2)/2) + 1):nrow(X2), ]

W2 <- solve(t(X2_1) %*% as.matrix(X2_1)) %*% (t(X2_1) %*% Y2_1)

SSE_2 <- sum(((as.matrix(X2_2) %*% as.matrix(W2)) - Y2_2)^2)
SSE_2
