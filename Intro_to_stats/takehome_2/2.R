exam <- read.table('examanxiety.txt', header=TRUE)

X <- exam$Anxiety
Y <- exam$Exam

corelation <- cor(X,Y)
sy <- sd(Y)
sx <- sd(X)

b <- corelation*(sy/sx)
a <- mean(Y) - b*mean(X)

pred_Y <- a + b*(X)
pred_Y

plot(X,Y)
abline(a,b, col='red')


#We assumed that the given varialbles have a linear relationship.
#We want to predict the exam score according to the anxiety. The Slope
# is basically the value of increase in exam score for unit increase in anxiety.
# Here the the exam score decreases by around -0.73 for unit increase in anxiety.
# On the other hand the 'a' value is the exam score if the particular candidate has 
# zero anxiety. Here the intercep value is around 111.244. The exam score is out of 100
# not 111, but I don't think there's anyone who will have zero anxiety!!

