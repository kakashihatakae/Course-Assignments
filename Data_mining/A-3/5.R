reviewerA <- runif(1000, 0,5 )
reviewerB <- runif(1000, 5,10 )

normalize = function(data) {
    (data-min(data))/(max(data)-min(data))
}

n_reviewerA <- normalize(reviewerA)
n_reviewerB <- normalize(reviewerB)

n_reviewerA <- sort(n_reviewerA)
n_reviewerB <- sort(n_reviewerB)
png(filename='5_c_tabe.png')
View(cbind(n_reviewerA, n_reviewerB, n_reviewerB-n_reviewerA))
dev.off()
difference <- n_reviewerB - n_reviewerA
difference
mean(difference)
png(filename='5_a.png')
plot(n_reviewerA, n_reviewerB)
dev.off()

