twosix <- function(){
  dimension <- 10000
  uniformVector <- rep(0, dimension)
  for (i in 1:dimension) {
    sample <- runif(n=20, min=0, max=100)
    uniformVector[i] <- 2*mean(sample)
  }
    
  results <- list(estimatorVector=uniformVector,
              empiricalMean=mean(uniformVector),
              empiricalVar=var(uniformVector),
              empiricalVarComputedByHand=sum((
                uniformVector-mean(uniformVector))^2)/(dimension-1),
              sd=sqrt(var(uniformVector)))

  
  postscript("two-six.ps", horizontal = FALSE)  # set graphical output file
  hist(twoSixResults$estimatorVector,
       freq=FALSE,
       breaks=20,
       xlab = expression(T=2*bar(Y)),
       ylim=c(0, .04))
  lines(density(twoSixResults$estimatorVector), lty=2, col="blue")
  curve(dnorm(x, 
              mean = twoSixResults$empiricalMean, 
              sd = sqrt(twoSixResults$empiricalVar)), 
        from=50, 
        to=160, 
        add=TRUE, 
        col="red")
  dev.off()  # close the graphical output file
    
  return(results)
}
