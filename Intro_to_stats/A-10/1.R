A <- c(37.54, 37.01, 36.71, 37.03, 37.32, 37.01, 37.03, 37.70, 37.36, 36.75, 37.45, 38.85)
B <- c(40.17, 40.80, 39.76, 39.70, 40.79, 40.44, 39.79, 39.38)
C <- c(39.04, 39.21, 39.05, 38.24, 38.53, 38.71, 38.89, 38.66, 38.51, 40.08)

boxplot(A, B,C)

qqnorm(A) # does not look normal 
qqnorm(B) # does not look normal
qqnorm(C) # looks a little normal

sd_a <- sd(A)
sd_b <- sd(B)
sd_c <- sd(C)

sd_a
sd_b
sd_c

n_a <- length(A)
n_b <- length(B)
n_c <- length(C)

mean_a <- mean(A)
mean_b <- mean(B)
mean_c <- mean(C)
mean_g <- mean(c(A,B,C))

SSB <- n_a*(mean_a-mean_g)^2 + 
       n_b*(mean_b-mean_g)^2 + 
       n_c*(mean_c-mean_g)^2
between.df <- 2
between.meansquare <- SSB/2

SSW <- (n_a-1)*var(A)+
       (n_b-1)*var(B)+
       (n_c-1)*var(C)
within.df <- (n_a + n_b + n_c) - 3
within.meansquare <- SSW/within.df

SST <- SSW + SSB

F <- between.meansquare/within.meansquare

1-pf(F,df1=between.df, df2=within.df)

