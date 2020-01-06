x <- c(0:10)
w0 <- 3
w1 <- -0.05
w2 <- -0.08
#a
w <- cbind(w0, w1, w2)
sigmoid <- function(x, w){
    1/(1+exp(-(w[1] + w[2]*x + w[3]*x^2)))
}
plot(sigmoid(x, w), type='l')

#b
dat_chipotle <- read.table('chipotle.dat')

dat_chipotle <- dat_chipotle[1:500,]
fet_dat <- cbind(rep(1, 500), dat_chipotle$V1, (dat_chipotle$V1)^2)
Y <- dat_chipotle$V2
#---------------------------------
learning_rate <- 0.001
#--------------------------------
w <- c(w0, w1, w2)
count <- 100

while(count > 0 ){
    count <- count - 1
    for(i in 1:500){
        # print(w)
        # print(Y[i] - sigmoid(dat_chipotle$V1[i], w))
        w[1] <- w[1] + learning_rate*(Y[i] - sigmoid(dat_chipotle$V1[i], w))
        w[2] <- w[2] + learning_rate*(Y[i] - sigmoid(dat_chipotle$V1[i], w))*dat_chipotle$V1[i]
        w[3] <- w[3] + learning_rate*(Y[i] - sigmoid(dat_chipotle$V1[i], w))*(dat_chipotle$V1[i])^2
        # print(w)
    }
}
print(w)
# View(sigmoid(dat_chipotle$V1, w))
# View(dat_chipotle$V2)

p <- sigmoid(dat_chipotle$V1, w)
logit <- ifelse(p > 0.5,1 ,0)
# class1 = df[,4]

# View(logit)
# View(Y)

sum(logit == Y)/length(logit)

set.seed(100)
w1 = rep(0,3)

X <- cbind(rep(1,500),dat_chipotle$V1, (dat_chipotle$V1)^2)
# Newton ralphson method to optmize w
for (i in 1:1000) { 
  p1 = 1/(1+exp(-t(w1) %*% t(X)))
  p1 = as.vector(p1)
  D = diag(p1*(1-p1))
  H = -t(X) %*% D %*% X
  grad1 = t(X) %*% (Y - p1)
  w1 = w1 - solve(H)%*%grad1
#   print(w1)
} 
print(w1)