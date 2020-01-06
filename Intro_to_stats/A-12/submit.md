---
title: "Homework 12"
---



# 1

## a

```r
sis <- c(69, 64, 65, 63, 65, 62, 65, 64, 66, 59, 62)
bro <- c(71, 68, 66, 67, 70, 71, 70, 73, 72, 65, 66)

1 - pnorm(70, mean=mean(bro), sd=sd(bro)) 
```

```
## [1] 0.356583
```

## b

```r
r <- cor(sis, bro)
sy <- sd(bro)
sx <- sd(sis)

b <- r*(sy/sx)
a <- mean(bro) - b*mean(sis)

pred_bro_5_1 <- b*(61) + a
pred_bro_5_1
```

```
## [1] 67.22727
```

## c


```r
height.sis <- which(sis >= 61-0.5 & sis <= 61+0.5)
mean.bro.height <- pred_bro_5_1
corr <- cor(sis,bro)

pred.bro <- a + b*sis
sse <- sum((bro-pred.bro)^2)
pred.bro.error <- sqrt(sse/(length(pred.bro)-2))

prop1 <- 1 - pnorm(70, mean.bro.height, pred.bro.error)
prop1
```

```
## [1] 0.1219492
```

# 2

## a


```r
mt1 <- 75
sd1 <- 10
mt2 <- 64
sd2 <- 12

r <- 0.5

b <- r*(sd2/sd1)
a <- mt2 - mt1*b

pred_t2_80 <- b*80 + a
pred_t2_80
```

```
## [1] 67
```
The predicted score for test 2 is way less than what the student asked the professor to enter. My advice would be to
not follow the student.

## b


```r
b <- r*(sd1/sd2)
a <- mt1 - mt2*b
pred <- a + b*76
pred
```

```
## [1] 80
```
There's no harm in following the student.

# 3

## a


```r
data <- read.csv('baseball-wins.txt', sep=' ')

1 - pnorm(84.5, mean=mean(data$year1.wins), sd=sd(data$year1.wins))
```

```
## [1] 0.3808708
```

## b


```r
dat <- data$year2.wins[data$year1.wins == 95]

r <- cor(data$year2.wins, data$year1.wins)
sd_y1 <- sd(data$year1.wins)
sd_y2 <- sd(data$year2.wins)

b <- r*(sd_y2/sd_y1)
a <- mean(data$year2.wins) - b*mean(data$year1.wins)

pred_95 <- b*95 + a
pred_95
```

```
## [1] 88.2238
```

```r
pred_error <- sd(data$year2.wins)*sqrt(1-r^2)

1 - pnorm(84.5, mean=pred_95, sd=pred_error)
```

```
## [1] 0.6485906
```

## c


```r
pred_75 <- b*75 + a
pred_75
```

```
## [1] 77.8783
```

```r
pred_error_75 <- sd(data$year2.wins)*sqrt(1-r^2)

1 - pnorm(84.5, mean=pred_75, sd=pred_error_75)
```

```
## [1] 0.2487529
```
