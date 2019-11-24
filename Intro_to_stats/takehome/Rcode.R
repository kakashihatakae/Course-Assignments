k <- read.csv('handwashing.txt', sep=' ')

handwash <- k[k$Condition==1,]
controlGroup <- k[k$Condition == 0,]

mean.sample.handwash <- mean(handwash$Trolley)
mean.sample.control <- mean(controlGroup$Trolley)

sample.s.sd.handwash <- sd(handwash$Trolley)
sample.s.sd.control <- sd(controlGroup$Trolley)

delta <- mean.sample.handwash - mean.sample.control
se <- sqrt(var(handwash$Trolley)/63 + var(controlGroup$Trolley)/69)
welch_stat <- delta/se
degree_f <- ((var(handwash$Trolley)/63+var(controlGroup$Trolley)/69)^2)/((var(handwash$Trolley)/63)^2/62+(var(controlGroup$Trolley)/69)^2/68)
P_val <-  2*(1-pt(abs(welch_stat), df=degree_f))
# Reject the null hypothesis

#c
k$Total <- rowSums(k[2:7])

k.temp <- cbind(k, k$Total)

boxplot(k.temp[8:9],boxfill = NA, border = NA)
boxplot(controlGroup$Total, add=TRUE)
boxplot(handwash$Total, ylab='score', xlab='features', add=TRUE, at = 0+2)

#d
total.mean <- mean(k$Total)

total.mean.sample.handwash <- mean(handwash$Total)
total.mean.sample.control <- mean(controlGroup$Total)

sample.s.sd.handwash <- sd(handwash$Total)
sample.s.sd.control <- sd(controlGroup$Total)
