data <- read.csv('baseball-wins.txt', sep=' ')

#a
1 - pnorm(84.5, mean=mean(data$year1.wins), sd=sd(data$year1.wins))

#b
#y = year2 wins

dat <- data$year2.wins[data$year1.wins == 95]

r <- cor(data$year2.wins, data$year1.wins)
sd_y1 <- sd(data$year1.wins)
sd_y2 <- sd(data$year2.wins)

b <- r*(sd_y2/sd_y1)
a <- mean(data$year2.wins) - b*mean(data$year1.wins)

pred_95 <- b*95 + a
pred_95

pred_error <- sd(data$year2.wins)*sqrt(1-r^2)

1 - pnorm(84.5, mean=pred_95, sd=pred_error)

#c 

pred_75 <- b*75 + a
pred_75

pred_error_75 <- sd(data$year2.wins)*sqrt(1-r^2)

1 - pnorm(84.5, mean=pred_75, sd=pred_error_75)