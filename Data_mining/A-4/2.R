library('rpart')
library('rpart.plot')
student_data <- read.csv('student/student-mat.csv', sep=';')

student_data$class <- ifelse(student_data$G3 > 10,0,1)
new_dat <- student_data[1:30] 
new_dat <- cbind(new_dat, student_data[34])

sample_ind <- sample(nrow(new_dat),nrow(new_dat)*0.70)
train <- new_dat[sample_ind,]
test <- new_dat[-sample_ind,]

set.seed(100)
fit <- rpart(formula = class~., data = train, method = "class", control = rpart.control(cp = -1))

plot(fit)
# summary(fit)
printcp(fit)
plotcp(fit)

#          CP nsplit rel error  xerror     xstd
# 1  0.312977      0   1.00000 1.00000 0.063328
# 2  0.061069      1   0.68702 0.68702 0.059450
# 3  0.038168      2   0.62595 0.66412 0.058920
# 4  0.030534      3   0.58779 0.68702 0.059450
# 5  0.010687      6   0.49618 0.67939 0.059278
# 6  0.000000     13   0.41985 0.85496 0.062274
# 7 -1.000000     21   0.41985 0.85496 0.062274

test$pred <- predict(fit, test, type = "class")
base_accuracy <- mean(test$pred == test$class)

#pruning
fit_pruned <- prune(fit, cp = 0.038)
test$pred <- predict(fit_pruned, test, type = "class")
accurcy_prune <- mean(test$pred == test$class)


# generalisation error = rootnode error * xerror    training error = rootnde error*relative error
# root_node_error = 0.47
# xerror = 0.6641
# relative error = 0.62

##------------- part2 -----------------
student_data_reg <- read.csv('student/student-mat.csv', sep=';')
new_dat <- student_data[1:30] 
new_dat <- cbind(new_dat, student_data[33])

sample_ind <- sample(nrow(new_dat), nrow(new_dat)*0.70)
train_reg <- new_dat[sample_ind,]
test_reg <- new_dat[-sample_ind,]

set.seed(100)
fit_reg <- rpart(formula = G3~., data = train_reg, method = "anova", control = rpart.control(cp = -1))

plot(fit_reg)
printcp(fit_reg)

#            CP nsplit rel error  xerror     xstd
# 1   0.1235880      0   1.00000 1.00392 0.097113
# 2   0.0762291      1   0.87641 0.90362 0.090044
# 3   0.0258000      2   0.80018 0.81242 0.086316
# 4   0.0234981      4   0.74858 0.91164 0.095049
# 5   0.0192030      7   0.67809 0.90836 0.096999
# 6   0.0153929      8   0.65889 0.89376 0.096556
# 7   0.0115373      9   0.64349 0.90927 0.097631
# 8   0.0112641     10   0.63196 0.90675 0.095669
# 9   0.0101256     11   0.62069 0.90681 0.095764
# 10  0.0094987     12   0.61057 0.90961 0.095318
# 11  0.0088311     13   0.60107 0.92750 0.097520
# 12  0.0087288     14   0.59224 0.93772 0.099166
# 13  0.0084118     15   0.58351 0.93772 0.099166
# 14  0.0074126     16   0.57510 0.95692 0.100647
# 15  0.0072139     18   0.56027 0.95571 0.099703
# 16  0.0068942     19   0.55306 0.95707 0.099689
# 17  0.0056967     20   0.54616 0.95704 0.099669
# 18  0.0055199     21   0.54047 0.95549 0.099844
# 19 -1.0000000     22   0.53495 0.95549 0.099844

test_reg$pred <- predict(fit_reg, test_reg, type = "vector")
base_error <- sum((test_reg$pred - test_reg$G3)^2)

fit_pruned_reg <- prune(fit_reg, cp = 0.025)
test_reg$pred_prune <- predict(fit_pruned_reg, test_reg, type = "vector")
pruned_error <- sum((test_reg$pred_prune - test_reg$G3)^2)


# generalisation error = rootnode error * xerror    training error = rootnde error*relative error
# root_node_error = 19.133
# xerror = 0.81
# relative error = 0.800s