baseball_dat_AL <- c(93, 87, 81, 80, 78, 95, 83, 81, 76, 74, 88, 86, 85, 76, 68)
baseball_dat_NL <- c(90, 83, 71, 67, 63, 100, 98, 97, 68, 64, 92, 84, 79, 74, 68)

final <- cbind(baseball_dat_AL, baseball_dat_NL)

boxplot(final)
hist(final)