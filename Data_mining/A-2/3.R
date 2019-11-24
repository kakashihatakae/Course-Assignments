mystery <- read.csv('~/Documents/Masters_stuff/IU_assignments/Data_mining/mystery.csv')
mystery_means <- colMeans(mystery)
k <- t(mystery) - mystery_means
mystery_minus <- t(k)

cov_mystery <- cov(mystery_minus)
svd_cov <- svd(cov_mystery)
#here the first 5 di have a value greater than 0, so lets consider the first five vectors
svd_cov_U <- svd_cov$u
newU <- svd_cov_U[,1:5]
reduced_cord <- mystery_minus %*% newU
