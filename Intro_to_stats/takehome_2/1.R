#H0 ; number of misprints follow poisson
#H1 ; number of misprints not follow poisson

num_mis_print <- c(0:10)
news_pages <- c(9, 23, 40, 30, 31, 26, 19, 10, 5, 4, 3)

mis_print_total <- sum(num_mis_print*news_pages)
news_pages_total <- sum(news_pages)
ave <- mis_print_total/news_pages_total

cats <- news_pages_total*dpois(0:20, ave)
data.frame(0:20, expected=round(cats, 1))

expected <- rep(0, 9)
expected[1:8] <- news_pages_total*dpois(0:7, ave)
expected[9] <- news_pages_total*(1 - ppois(7, ave))
observed <- c(9, 23, 40, 30, 31, 26, 19, 10, 12)

statsL <- 2*sum(observed*log(observed/expected))
1 - pchisq(statsL, df=7)

statsX  <- sum((observed-expected)^2/expected)
1 - pchisq(statsX, df=7)

#If we consider the log likelihood, the calculated probability is more than
#the alpha value. Thus, we fail to reject the null hypothesis. The data is consistent 
#with the null hypothesis and the number of misprtints do follow a poisson distribution.

#If we consider the other test, the calculated probability is less than
#the alpha value. Thus, we  reject the null hypothesis. The data is not consistent 
#with the null hypothesis and the number of misprtints don't follow a poisson distribution.