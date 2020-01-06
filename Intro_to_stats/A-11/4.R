data <- read.csv("http://www.football-data.co.uk/mmz4281/1415/E0.csv")
data <- data[1:380,]

#Home
max(data$FTHG)
observed <- c()
for(i in 0:8){
    observed <- c(observed, sum(data$FTHG == i))
}

games <- sum(observed)
goals <- sum(c(0:8)*observed)
average <- sum(c(0:8)*observed)/sum(observed)

round(games*dpois(0:20,average), 1)

#6 categories above 5
# 5 or more
#eliminate 3

expected <- rep(NA, 7)
expected[1:6] = games * dpois(0:5, average)
expected[6:8] = games * (1 - ppois(5, average))

G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=4)

X2 <- sum((observed-expected)^2/expected)
1 - pchisq(X2,df=4)


#FTAG
max(data$FTAG)
observed <- c()
for(i in 0:6){
    observed <- c(observed, sum(data$FTAG == i))
}

games <- sum(observed)
goals <- sum(c(0:6)*observed)
average <- sum(c(0:6)*observed)/sum(observed)

round(games*dpois(0:20,average), 1)

#5 categories above 5
# 5 or more
#eliminate 2

expected <- rep(NA, 7)
expected[1:5] = games * dpois(0:4, average)
expected[6:7] = games * (1 - ppois(4, average))

G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=3)

X2 <- sum((observed-expected)^2/expected)
1 - pchisq(X2,df=3)


#combined
combined <- c(data$FTHG, data$FTAG)
observed <- c()
for(i in 0:8){
    observed <- c(observed, sum(combined == i))
}

games <- sum(observed)
goals <- sum(c(0:8)*observed)
average <- sum(c(0:8)*observed)/sum(observed)

round(games*dpois(0:20,average), 1)

#6 categories above 5
# 5 or more
#eliminate 3

expected <- rep(NA, 7)
expected[1:6] = games * dpois(0:5, average)
expected[6:8] = games * (1 - ppois(5, average))

G2 <- 2*sum(observed*log(observed/expected))
1 - pchisq(G2, df=4)

X2 <- sum((observed-expected)^2/expected)
1 - pchisq(X2,df=4)
