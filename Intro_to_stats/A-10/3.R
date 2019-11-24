normal <- c(156, 282, 197, 297, 116, 127, 119, 29, 253, 122, 349,110, 143, 64, 26, 86, 122, 455, 655, 14)
alloxan <- c(391, 46, 469, 86, 174, 133, 13, 499, 168, 62, 127, 276, 176, 146, 108, 276, 50, 73)
insulin <- c(82, 100, 98, 150, 243, 68, 228,131, 73, 18, 20, 100, 72, 133, 465, 40, 46, 34, 44)

qqnorm(normal)
qqnorm(alloxan)
qqnorm(insulin)

boxplot(normal, alloxan, insulin)

sd(normal)
sd(alloxan)
sd(insulin)

sd(normal)/sd(insulin)
#no homoscedacity

sq.normal <- sqrt(normal)
sq.alloxan <- sqrt(alloxan)
sq.insulin <- sqrt(insulin)

qqnorm(sq.normal)
qqnorm(sq.alloxan)
qqnorm(sq.insulin)

boxplot(sq.normal, sq.alloxan, sq.insulin)

sd(sq.normal)
sd(sq.alloxan)
sd(sq.insulin)

sd(sq.normal)/sd(sq.insulin)
#looks close to normality and variance ratio is less than 2

n_normal <- length(sq.normal)
n_alloxan <- length(sq.alloxan)
n_insulin <- length(sq.insulin)

mean_normal <- mean(sq.normal)
mean_alloxan <- mean(sq.alloxan)
mean_insulin <- mean(sq.insulin)
mean_g <- mean(c(sq.normal,sq.alloxan,sq.insulin))

SSB <- n_normal*(mean_normal-mean_g)^2 + 
       n_alloxan*(mean_alloxan-mean_g)^2 + 
       n_insulin*(mean_insulin-mean_g)^2
between.df <- 2
between.meansquare <- SSB/2

SSW <- (n_normal-1)*var(sq.normal)+
       (n_alloxan-1)*var(sq.alloxan)+
       (n_insulin-1)*var(sq.insulin)
within.df <- (n_normal + n_alloxan + n_insulin) - 3
within.meansquare <- SSW/within.df

SST <- SSW + SSB

F <- between.meansquare/within.meansquare

1-pf(F,df1=between.df, df2=within.df)

# d
t.test(sq.normal, sq.alloxan)

#p-value is higher than 0.05/3

t.test(sq.alloxan, sq.insulin)

t.test(sq.normal, sq.insulin)