oddcounter <- function(aVector){
  k <- 0
  for (n in aVector){
    if (n %% 2)
      k <- k + 1
  }
  return(k)
}

mediansMaker <- function(sampleDimension, count) {
  medians <- rep(x= 0,...= count)
  for (i in 1:count) {
    y <- rnorm(n=sampleDimension, mean=500, sd=5)
    medians[i] = median(y)
  }
  return (medians)
}