music_data <- read.csv('/home/shreyas/Documents/Masters_stuff/IU_assignments/Data_mining/rachmaninov_pc2_onset.csv')
music_data <- music_data[2:13]
music_means <- colMeans(music_data)
music_data_minus_means <- t(t(music_data) - music_means)
cov_music <- cov(music_data)
svd_music <- svd(cov_music, nu=12)