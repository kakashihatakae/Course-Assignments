music_data <- read.csv('/home/shreyas/Documents/Masters_stuff/IU_assignments/Data_mining/rachmaninov_pc2_onset.csv')
#music_data <- t(music_data)
music_data <- music_data[,2:13]
ts.plot(t(music_data), col=3:15)
