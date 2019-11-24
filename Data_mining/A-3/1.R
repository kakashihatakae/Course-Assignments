x <- runif(1000, min=-4, max=4)
y <- -x
z <- rep.int(1,1000)

a <- cbind(x,y,z)
covariance <- cov(a)

svd_xyz <- svd(covariance)

svd_xyz$d
svd_xyz$u