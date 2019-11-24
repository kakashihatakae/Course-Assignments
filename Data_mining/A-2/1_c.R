music_data <- read.csv('/home/shreyas/Documents/Masters_stuff/IU_assignments/Data_mining/rachmaninov_pc2_onset.csv')
music_data <- music_data[2:13]
music_means <- colMeans(music_data)
cov_music <- cov(music_data)
svd_music <- svd(cov_music, nu=12)

thousand_points <- rnorm(1000)

for(i in 1:12){
  
  colm <- rnorm(1000, sd=sqrt(var(music_data[i])))
  thousand_points <- cbind(thousand_points, colm)
}

thousand_points <- thousand_points[,2:13]
new_points <- thousand_points %*% svd_music$u

new_points <- t(t(new_points) + music_means)
