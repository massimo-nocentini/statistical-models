twoFifteen <- function(){
  ## we generate a vector with 1000 items in order to build the plane
  generatingVector <- seq(from=-4, to=4, length.out=100)
  n <- length(generatingVector)^2
  matrix <- matrix(nrow=n, ncol=3)
  ro <- .83
  i <- 1
  for (u in generatingVector){
    for (v in generatingVector){
      matrix[i, 1] <- 37.2 + 6.8*u
      matrix[i, 2] <-  39.4 + 7.7*v
      matrix[i, 3] <- multivariateStandardNormal(u, v, ro)
      i <- i+1
    }
  }
  
  rowIndicesForSample <- sample(x=1:n, size=1000, prob=matrix[,3])
  sample <- matrix[rowIndicesForSample,]

  postscript("two-fifteen.ps", horizontal = FALSE)
  plot(sample, xlab="37.2 + 6.8*U", ylab="39.4 + 7.7*V")
  dev.off()                                        
  
  return(list(matrix=matrix,
              sample=sample))
}

multivariateStandardNormal <- function(u, v, ro){
  coeff <- (2*pi*sqrt(1-ro^2))^(-1)
  return(coeff * exp(-((u^2 -2*ro*u*v +v^2)/(2*(1-ro^2)))))
}
