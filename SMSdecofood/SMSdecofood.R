

rm(list=ls(all=TRUE))
graphics.off()

# setwd("C:/...") # set working directory
# load data
load("food.rda")

x = data.matrix(food[,1:7])
n = nrow(x)
p = ncol(x)


one = matrix(1,n,n)
h   = diag(rep(1,n))-one/n # centering matrix
d   = diag(1/sqrt((apply((x-matrix(apply(x,2,mean),n,p,byrow=T))^2,2,sum)/n)))
xs  = h%*%as.matrix(x)%*%d    # standardized data

xs  = xs/sqrt(n)

# singular value decomposition
deco = svd(xs)
w = (-1)*deco$v[,1:2]%*%diag(deco$d[1:2])
z = (-1)*deco$u[,1:2]%*%diag(deco$d[1:2])

# plot
opar=par(mfrow=c(2,1))

plot(w,type="n",xlim=c(-1,1),ylim=c(-1,1),xlab=expression(w[1]),ylab=expression(w[2]))
title("food")
text(w,colnames(food),xpd=NA)
abline(h=c(0,0),lwd=2)
abline(v=c(0,0),lwd=2)

plot(z,type="n",xlim=c(-1.5,1.5),ylim=c(-1,1),xlab=expression(z[1]),ylab=expression(z[2]))
title("families")
text(z,row.names(food),xpd=NA)
abline(h=c(0,0),lwd=2)
abline(v=c(0,0),lwd=2)
par(opar)