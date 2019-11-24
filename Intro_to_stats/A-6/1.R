x = scan("http://pages.iu.edu/~mtrosset/StatInfeR/Data/sample774.dat")

#------- a ----------
x_ecdf <- ecdf(x)
plot(x_ecdf)

#------- b ----------
x_mean <- mean(x)
x_var <- var(x)
x_mean
x_var

#----- c -----------
x_median <- median(x)
x_median
IQR <- IQR(x)

#------- d ----------
x_IQR_to_sd <- IQR/sqrt(x_var)

#------ e ----------
boxplot(x)

#------f --------
qqnorm(x)
qqline(x)

#---g
#---h
