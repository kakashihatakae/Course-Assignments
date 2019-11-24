data <- scan("http://pages.iu.edu/~mtrosset/StatInfeR/Data/sample774.dat")

#----- a ----
data_ecdf <- ecdf(data)
plot(data_ecdf)

#------ b -----
data_mean <- mean(data)
data_var <- var(data)
data_median <- media(data)

IQR <- qnorm(0.75, m=data_mean, sd=sqrt(data_var)) - qnorm(0.25, m=1.48, sd=sqrt(data_var))

#------ c -------
sqrt_var <- sqrt(data_var)
sqrt_var
IQR
# here 

#---- d -------
qqnorm(data)
qqline(data)

#---- e ---
data_y <- log(x)
par(mfrow=c(1,3))

hist(data_y)
plot(data_y)
qqnorm(data_y)
qqline(data_y)