twoFifteen <- function(){
  n <- 10000
  generatingVector <- seq(from=-4, to=4, length.out=n)
  x <- rep(0, n)
  y <- rep(0, n)
  ro <- .83
  for (i in seq(generatingVector)){
    x[i] <- 37.2 + 6.8*saturateV(generatingVector[i], generatingVector, ro)
    y[i] <- 39.4 + 7.7*saturateU(generatingVector[i], generatingVector, ro)
  }
  return(list(x=x, y=y))

}

saturateV <- function(u, generatingVector, ro){
  sum <- 0
  for(i in seq(generatingVector)){
    sum <- sum + multivariateStandardNormal(u, generatingVector[i], ro)
  }
  return(sum)
}

saturateU <- function(v, generatingVector, ro){
  sum <- 0
  for(i in seq(generatingVector)){
    sum <- sum + multivariateStandardNormal(generatingVector[i], v, ro)
  }
  return(sum)
}

multivariateStandardNormal <- function(u, v, ro){
  coeff <- (2*pi*sqrt(1-ro^2))^(-1)
  return(coeff * exp(-((u^2 -2*ro*u*v +v^2)/(2*(1-ro^2)))))
}
