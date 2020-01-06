fx <- log10(1+1/(1:9))

sum(fx)
#sum of all probabilities in a pmf is 1'

observed <- c(107, 55, 39, 22, 13, 18, 13, 23, 15)
expected <- sum(observed)*fx

#likelihood
G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=8)

X2 <- sum((observed-expected)^2/expected)
1 - pchisq(X2,df=8)

