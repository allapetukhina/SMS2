rm(list=ls(all=TRUE))
graphics.off()

# install and load packages
libraries = c("MASS", "hexbin", "KernSmooth")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

set.seed(100);

n       = 300;
mu      = c(0,0);
sigma   = diag(x = 1, nrow = 2, ncol = 2);
xx      = mvrnorm(n, mu, sigma);
nd      = 15                                 # number of grid points in each dimension
nd      = matrix(1,1,nrow = dim(xx)[2])*nd   # matrix 2x1 with numbers of grid points in each dimension
d       = c(apply(t(xx), 1, max) - apply(t(xx), 1, min))/(nd-1)
h       = c(2.6073*sqrt(var(xx[,1]))*n^(-1/6),2.6073*sqrt(var(xx[,2]))*n^(-1/6)) # bandwidth a la Scott's rule of thumb
minmaxx = c(min(xx[,1]), max(xx[,1]))
minmaxy = c(min(xx[,2]), max(xx[,2]))
est     = bkde2D(xx, bandwidth=h/2, gridsize=nd, truncate=TRUE, range.x=list(minmaxx, minmaxy))   # estimates 2dimensional density

contour(est$x1, est$x2, est$fhat,  col="blue", frame.plot=TRUE,main="2D kernel estimate")
points(xx,pch=20)
dev.new()
plot(hexbin(xx,xbins=8),main="Hexagon plot",xlab="",ylab="",legend=FALSE)