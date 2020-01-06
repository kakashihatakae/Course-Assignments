observed <- c(121, 84, 118, 226, 226, 123)
p_expected <- c(0.13, 0.14, 0.13, 0.24, 0.20, 0.16)

sum_observed <- sum(observed)
expected <- sum_observed*p_expected

#likelihood ratio version
G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=5)

x2 <- sum((observed-expected)^2/expected)
1 - pchisq(x2, df=5)

#in both cases the p value is way less than 0.05