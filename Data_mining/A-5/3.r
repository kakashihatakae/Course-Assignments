data(nottem)
y <- nottem
n <- length(y)
x <- 1:n

plot(x,y,type="b")

x_cos <- cos(2*pi*x/12)
x_sin <- sin(2*pi*x/12)
for_c <- rep(1,n)

sine.cosine.x <- cbind(x_cos, x_sin, for_c)

w <- solve(t(sine.cosine.x) %*% as.matrix(sine.cosine.x)) %*% (t(sine.cosine.x) %*% y)

y_pred <- sine.cosine.x %*% w

plot(x,y,type="b")
par(new=T)
plot(y_pred, col='red', type='l')

#c
sine.cosine.x_new <- cbind(sine.cosine.x, x)
w_new <- solve(t(sine.cosine.x_new) %*% as.matrix(sine.cosine.x_new)) %*% (t(sine.cosine.x_new) %*% y)
y_pred_d <- sine.cosine.x_new %*% w_new

plot(x,y,type="b")
par(new=T)
plot(y_pred_d, col='red', type='l')
