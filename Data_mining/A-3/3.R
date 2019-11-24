#-----[a]------------
exp_dist <- rexp(1000)
sort(exp_dist)
exp_dist
emperical_cdf <- ecdf(exp_dist)
# png(filename='3_a.png')
plot(emperical_cdf)
# dev.off()
#-----------[b]--------
# uniform distribution. F(x) has a uniform distribtion
random <- rnorm(1000)
new_emperical <- ecdf(random)
# plot(new_emperical)
k <- new_emperical(sort(exp_dist))
# png(filename='3_c.png')
plot(k)
# dev.off()
#----------[c]------------
#emperical cdf sums 1/n for every argument irrespective of the value 
#it will have the same distribution as long as number of values are similar
