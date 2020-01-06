mt1 <- 75
sd1 <- 10
mt2 <- 64
sd2 <- 12

r <- 0.5

#a
# Y >- t2

b <- r*(sd2/sd1)
a <- mt2 - mt1*b

pred_t2_80 <- b*80 + a
pred_t2_80
#will not advise that

#b 
b <- r*(sd1/sd2)
a <- mt1 - mt2*b
pred <- a + b*76
pred