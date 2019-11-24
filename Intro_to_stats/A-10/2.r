ss <- c(7.2, 7.7, 8.0, 8.1, 8.3, 8.4, 8.4, 8.5, 8.6, 8.7, 9.1, 9.1, 9.1, 9.8, 10.1, 10.3)
st <- c(8.1, 9.2, 10.0, 10.4, 10.6, 10.9, 11.1, 11.9, 12.0, 12.1)
sc <- c(10.7, 11.3, 11.5, 11.6, 11.7, 11.8, 12.0, 12.1, 12.3, 12.6, 12.6, 13.3, 13.8, 13.9)

boxplot(ss, st, sc)

qqnorm(ss)
qqnorm(st)
qqnorm(sc)

sd_a <- sd(A)
sd_b <- sd(B)
sd_c <- sd(C)

sd_a
sd_b
sd_c

n_ss <- length(ss)
n_st <- length(st)
n_sc <- length(sc)

mean_ss <- mean(ss)
mean_st <- mean(st)
mean_sc <- mean(sc)
mean_g <- mean(c(ss,st,sc))

SSB <- n_ss*(mean_ss-mean_g)^2 + 
       n_st*(mean_st-mean_g)^2 + 
       n_sc*(mean_sc-mean_g)^2
between.df <- 2
between.meansquare <- SSB/2

SSW <- (n_ss-1)*var(ss)+
       (n_st-1)*var(st)+
       (n_sc-1)*var(sc)
within.df <- (n_ss + n_st + n_sc) - 3
within.meansquare <- SSW/within.df

SST <- SSW + SSB

F <- between.meansquare/within.meansquare

1-pf(F,df1=between.df, df2=within.df)