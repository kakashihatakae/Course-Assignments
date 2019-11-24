music_data <- read.csv('/home/shreyas/Documents/Masters_stuff/IU_assignments/Data_mining/rachmaninov_pc2_onset.csv')
music_data <- music_data[,2:13]

cov_music <- cov(music_data)

music_means <- colMeans(music_data)

music_data_minus_means <- t(t(music_data) - music_means)

Calculated_cov <- (t(music_data_minus_means) %*% music_data_minus_means)/6

inds <- all.equal(Calculated_cov, cov_music)
inds

