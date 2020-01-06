observed <- c(74, 18, 12, 68, 16, 12, 
              154, 54, 58, 18, 10, 44)

N <- sum(observed)
P.LP <-sum(c(74, 8, 12))/N
P.NS <- sum(c(68, 16, 12))/N
P.MC <- sum(c(154, 54, 58))/N
P.LD <- sum(c(18, 10, 44))/N
P.Pos <- sum(c(74, 68, 154, 18))/N
P.Par <- sum(c(18, 16, 54, 10))/N
P.None <- sum(c(12, 12, 58, 44))/N

colums <- c(P.Pos, P.Par, P.None)
expected <- N*c(P.LP*colums, P.NS*colums, P.MC*colums, P.LD*colums)

df <- (3-1)*(4-1)

G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=df)

X2 <- sum((observed-expected)^2/expected)
1-pchisq(X2, df=df)