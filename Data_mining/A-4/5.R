classification_data <- read.csv('classification_accuracy.csv')

wins_decision_tree <- sum(classification_data$decision_tree > classification_data$svm) + sum(classification_data$decision_tree>classification_data$naive_bayes)
wins_svm <- sum(classification_data$svm > classification_data$decision_tree) + sum(classification_data$svm>classification_data$naive_bayes)
wins_naive_bayes <- sum(classification_data$naive_bayes > classification_data$svm) + sum(classification_data$naive_bayes>classification_data$decision_tree)

loss_decision_tree <- sum(classification_data$decision_tree < classification_data$svm) + sum(classification_data$decision_tree<classification_data$naive_bayes)
loss_svm <- sum(classification_data$svm < classification_data$decision_tree) + sum(classification_data$svm<classification_data$naive_bayes)
loss_naive_bayes <- sum(classification_data$naive_bayes < classification_data$svm) + sum(classification_data$naive_bayes<classification_data$decision_tree)

draw_decision_tree <- sum(classification_data$decision_tree == classification_data$svm) + sum(classification_data$decision_tree==classification_data$naive_bayes)
draw_svm <- sum(classification_data$svm == classification_data$decision_tree) + sum(classification_data$svm==classification_data$naive_bayes)
draw_naive_bayes <- sum(classification_data$naive_bayes == classification_data$svm) + sum(classification_data$naive_bayes==classification_data$decision_tree)

a <- c(wins_decision_tree, draw_decision_tree, loss_decision_tree)
b <- c(wins_naive_bayes, draw_naive_bayes, loss_naive_bayes)
c <- c(wins_svm, draw_svm, loss_svm)

k <- rbind(a,b,c)
rownames(k) = c('Decision_tree', 'Naive_bayes', 'SVM')
colnames(k) = c('Wins','Draw','Losses')

confusion_matrix <- k


confusion_matrix