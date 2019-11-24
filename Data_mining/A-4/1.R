library('caret')
return_probs <- function(row){
row <- as.numeric(row)

product_1 <- p_v1_v11[,1][row[1]+1]* p_v2_v11[,1][row[2]+1]* p_v3_v11[,1][row[3]+1]* p_v4_v11[,1][row[4]+1]*p_v5_v11[,1][row[5]+1]*p_v6_v11[,1][row[6]+1]*p_v7_v11[,1][row[7]+1]*p_v8_v11[,1][row[8]+1]*p_v9_v11[,1][row[9]+1]*p_v10_v11[,1][row[10]+1]
product_2 <- p_v1_v11[,2][row[1]+1]* p_v2_v11[,2][row[2]+1]* p_v3_v11[,2][row[3]+1]* p_v4_v11[,2][row[4]+1]*p_v5_v11[,2][row[5]+1]*p_v6_v11[,2][row[6]+1]*p_v7_v11[,2][row[7]+1]*p_v8_v11[,2][row[8]+1]*p_v9_v11[,2][row[9]+1]*p_v10_v11[,2][row[10]+1]
product_3 <- p_v1_v11[,3][row[1]+1]* p_v2_v11[,3][row[2]+1]* p_v3_v11[,3][row[3]+1]* p_v4_v11[,3][row[4]+1]*p_v5_v11[,3][row[5]+1]*p_v6_v11[,3][row[6]+1]*p_v7_v11[,3][row[7]+1]*p_v8_v11[,3][row[8]+1]*p_v9_v11[,3][row[9]+1]*p_v10_v11[,3][row[10]+1]

c(P_1*product_1, P_2*product_2, P_3*product_3)

}

binary_data <- read.csv('naive_bayes_binary.csv')
binary_data_train <- binary_data[1:(length(binary_data$V1)/2),]
binary_data_test <- binary_data[2501:5000,]
true_values <- binary_data_test$V11
binary_data_test <- binary_data_test[1:10]

length(binary_data_train$V1)

#create tables of all variables and derive their conditional probs

table_v1_v11 <- table(binary_data_train$V1, binary_data_train$V11)
table_v2_v11 <- table(binary_data_train$V2, binary_data_train$V11)
table_v3_v11 <- table(binary_data_train$V3, binary_data_train$V11)
table_v4_v11 <- table(binary_data_train$V4, binary_data_train$V11)
table_v5_v11 <- table(binary_data_train$V5, binary_data_train$V11)
table_v6_v11 <- table(binary_data_train$V6, binary_data_train$V11)
table_v7_v11 <- table(binary_data_train$V7, binary_data_train$V11)
table_v8_v11 <- table(binary_data_train$V8, binary_data_train$V11)
table_v9_v11 <- table(binary_data_train$V9, binary_data_train$V11)
table_v10_v11 <- table(binary_data_train$V10, binary_data_train$V11)

# table_vecs <- 

p_v1_v11 <- prop.table(table_v1_v11,2)
p_v2_v11 <- prop.table(table_v2_v11,2)
p_v3_v11 <- prop.table(table_v3_v11,2)
p_v4_v11 <- prop.table(table_v4_v11,2)
p_v5_v11 <- prop.table(table_v5_v11,2)
p_v6_v11 <- prop.table(table_v6_v11,2)
p_v7_v11 <- prop.table(table_v7_v11,2)
p_v8_v11 <- prop.table(table_v8_v11,2)
p_v9_v11 <- prop.table(table_v9_v11,2)
p_v10_v11 <- prop.table(table_v10_v11,2)


View(prob_list)

number_1 <- sum(binary_data_train$V11 ==1)
number_2 <- sum(binary_data_train$V11 ==2)
number_3 <- sum(binary_data_train$V11 ==3)

P_1 <- number_1/length(binary_data_train$V11)
P_2 <- number_2/length(binary_data_train$V11)
P_3 <- number_3/length(binary_data_train$V11)

probs_v11_numbers <- c(P_1, P_2, P_3)

results <- c()
for (i in 1:length(binary_data_test$V1)) {
    temp <- return_probs(binary_data_test[i,])
    results <- c(results, match(max(temp), temp))
}

# preds <- return_probs(binary_data[1,])

mean(results == true_values)

confusion <- table(results, true_values)
confusion