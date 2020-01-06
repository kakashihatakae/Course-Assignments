observed <- c(3057, 4621, 606, 53, 110, 27)
N <- sum(3110, 4731, 633)

P.No <- sum(3057+4621+606)/N
P.Yes <- sum(53+110+27)/N
P.Low <- sum(3057+53)/N
P.M <- sum(4621+110)/N
P.H <- sum(606+27)/N

rows <- c(P.Low, P.M, P.H)
expected <- N*c(P.No*rows, P.Yes*rows)

df <- (3-1)*(2-1)

G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=df)

X2 <- sum((observed-expected)^2/expected)
1-pchisq(X2, df=df)