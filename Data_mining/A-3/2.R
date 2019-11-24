#------ part [a] --------

data <- read.csv('Arrests.csv')
table_r_c <- table(data$released, data$colour)
p_released <- prop.table(table_r_c, 1)
png(filename='2_a.png')
mosaicplot(table_r_c)
dev.off()

#------ part [b] --------
data_yes_employment <- data[data['employed'] == 'Yes',]
data_no_employment <- data[data['employed'] == 'No',]

table_r_c_e_y <- table(data_yes_employment$released, data_yes_employment$colour)
table_r_c_e_n <- table(data_no_employment$released, data_no_employment$colour)
png(filename='2_b.png')
par(mfrow=c(1,2))
mosaicplot(table_r_c_e_y)
mosaicplot(table_r_c_e_n)
dev.off()
#not independent

#------ part [c] --------
data_0_c<- data[data['checks'] == 0,]
data_1_c<- data[data['checks'] == 1,]
data_2_c<- data[data['checks'] == 2,]
data_3_c<- data[data['checks'] == 3,]
data_4_c<- data[data['checks'] == 4,]
data_5_c<- data[data['checks'] == 5,]

png(filename="2_c.png")

par(mfrow=c(2,3))
mosaicplot(table(data_0_c$colour, data_0_c$released))
mosaicplot(table(data_1_c$colour, data_1_c$released))
mosaicplot(table(data_2_c$colour, data_2_c$released))
mosaicplot(table(data_3_c$colour, data_3_c$released))
mosaicplot(table(data_4_c$colour, data_4_c$released))
mosaicplot(table(data_5_c$colour, data_5_c$released))
dev.off()
#colour released

#not independent

#------ part [d] --------
k <- table(data$employed, data$colour)
mosaicplot(k)

#sex, released, employed