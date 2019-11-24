strange_data <- read.csv('strange_binary.csv')

set.seed(100)

fit_strange <- rpart(c~., data=strange_data, method='class', control = rpart.control(cp = 0))

plot(fit_strange)
printcp(fit_strange)

#          CP nsplit rel error xerror    xstd
# 1 0.0572917      0   1.00000 1.0000 0.10308
# 2 0.0312500      3   0.82812 1.0938 0.10540
# 3 0.0156250      4   0.79688 1.1094 0.10574
# 4 0.0078125      5   0.78125 1.1094 0.10574
# 5 0.0000000      9   0.75000 1.0781 0.10504

fit_pruned_strange <- prune(fit_strange, cp = 0.0312)
plot(fit_pruned_strange)

strange_predict <- predict(fit_pruned_strange, strange_data, type='class')
score <- mean(strange_predict == strange_data$c)
#cp should be 0.00781



new_feature <- rowSums(strange_data[1:10])
strange_data$new_fet <- new_feature

set.seed(100)
fit_strange_new <- rpart(c~., data=strange_data, method='class', control = rpart.control(cp = 0))
printcp(fit_strange_new)

fit_pruned_strange_new <- prune(fit_strange_new, cp = 0.009375)
printcp(fit_pruned_strange_new)

#0.32 = root node error
#rel error = 0.703
#xerror = 0.703