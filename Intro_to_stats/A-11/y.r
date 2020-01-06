dat <- read.csv("/home/shreyas/Downloads/subject003_stats.csv")

dat <- dat[1:40,]

ave <- c()
for(i in 0:3){
    # dat[5+i]
    temp <- dat[5+i]
    w <- temp[temp <= 2 && temp >= 0.05,]
    ave <- c(ave, sum(w)/length(w))
}


write.csv(dat, 'dat.csv')

