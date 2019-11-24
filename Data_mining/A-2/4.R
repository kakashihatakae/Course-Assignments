library('mlbench')
data('Ionosphere')
data <- Ionosphere
data$V1 <- as.numeric(as.character(data$V1))
data$V2 <- as.numeric(as.character(data$V2))
classes <- data['Class']

data_good <- data[data['Class'] == 'good',]
data_bad <- data[data['Class'] == 'bad',]

#-----------------------------------------------------------------------------
#calculate the mahalanobis distance of each class from the mean of each class
#then assign to classes according to distance from each of the means
#-----------------------------------------------------------------------------
# to be changed from here

data_sliced_good <- data_good[,3:34]
good_means <- colMeans(data_sliced_good)

data_sliced_bad <- data_bad[,3:34]
bad_means <- colMeans(data_sliced_bad)

#Good data set
#Good with bad mean
mahala_g_b_mean <- mahalanobis(data_sliced_good, bad_means, cov(data_sliced_good))
#Good with good mean
mahala_g_g_mean <- mahalanobis(data_sliced_good, good_means, cov(data_sliced_good))

#Bad data set
#bad with bad mean 
mahala_b_b_mean <- mahalanobis(data_sliced_bad, bad_means, cov(data_sliced_bad))
#bad with good mean
mahala_b_g_mean <- mahalanobis(data_sliced_bad, good_means, cov(data_sliced_bad))

bad_pred_ind <- mahala_b_b_mean < mahala_b_g_mean
good_pred_ind <- mahala_g_g_mean < mahala_g_b_mean

data_good_new <- cbind(data_good, good_pred_ind)
data_bad_new <- cbind(data_bad, bad_pred_ind)


G_G_ind <- sum(bad_pred_ind)
B_B_ind <- sum(good_pred_ind)
G_B_ind <- 126 - G_G_ind
B_G_ind <- 225 - B_B_ind
#data_update <- data[,1:34]
#data1
#Ionos_means <- colMeans(data_update)
#Ionos_means

#data_minus_means <- t(data_update) - Ionos_means
#data_minus_means <- t(data_minus_means)
#data_minus_means
#cov_mat <- t(data_minus_means) %*% as.matrix(data_minus_means)/350

#first <- as.matrix(data_minus_means) %*% solve(cov_mat)
#second <- first %*% t(data_minus_means)
#second
