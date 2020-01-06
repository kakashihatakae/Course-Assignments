sis <- c(69, 64, 65, 63, 65, 62, 65, 64, 66, 59, 62)
bro <- c(71, 68, 66, 67, 70, 71, 70, 73, 72, 65, 66)

#a
1 - pnorm(70, mean=mean(bro), sd=sd(bro)) 

#b
# Y = brother height

r <- cor(sis, bro)
sy <- sd(bro)
sx <- sd(sis)

b <- r*(sy/sx)
a <- mean(bro) - b*mean(sis)

pred_bro_5_1 <- b*(61) + a
pred_bro_5_1
#5'7

#c
height.sis <- which(sis >= 61-0.5 & sis <= 61+0.5)
mean.bro.height <- pred_bro_5_1
corr <- cor(sis,bro)

pred.bro <- a + b*sis
sse <- sum((bro-pred.bro)^2)
pred.bro.error <- sqrt(sse/(length(pred.bro)-2))

prop1 <- 1 - pnorm(70, mean.bro.height, pred.bro.error)
prop1

# Proportion of brothers who are atleast 5'10 when sister is 5'10" is approx
# 12%