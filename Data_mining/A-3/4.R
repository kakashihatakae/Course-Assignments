time_data <- read.csv('time_series.csv')

d <- diff(as.numeric(time_data[3,]))
plot(d, type='o')
diff(d)
log_d <- log(d)

plot(time_data$V6^10)
#------------[b]----------

variance <- var(means_minus)
svd_time <- svd(variance)
new_point <- means_minus %*%svd_time$u[,1:2] 
final <- t(t(new_point) + means[1:2]) 



# means <- colMeans(time_data)
# means_minus <- t(t(time_data) - means)
time_data <- read.csv('time_series.csv')
covariance <- cov(t(time_data))
svd_time <- svd(covariance)
svd_time$d
svd_time$u 
s <- svd_time$u[,1:4]
data_new <- t(time_data) %*%  s

png(filename='4_a.png')
ts.plot(data_new, col=c('black', 'blue','red','violet'))
dev.off()



library("forecast")
amp = apply(time_data, 1, max)
time_t= t(time_data)
freq = rep(NA,200)
for (i in 1:ncol(df_t))
freq[i] = findfrequency(time_t[,i])
plt = plot(freq,amp)


max_amplitude = c()
min_amplitude = c()
# Now deriving these feautures

for(i in c(1:nrow(time_data))){

  obj = time_data[i,]

  max_amplitude <<- append(max_amplitude, max(time_data[i,]), after = length(max_amplitude))

  min_amplitude <<- append(min_amplitude, min(time_data[i,]), after = length(min_amplitude))

}

png(filename='4_b.png')
plot(max_amplitude, min_amplitude)
dev.off()