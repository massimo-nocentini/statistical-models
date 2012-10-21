
twoSeven <- function(){

  dimension <- 30
  level <- .05
  empiricalMean <- 26.3
  standardError <- 2.4/sqrt(30)
  tOss <- qt(df=dimension-1, p=level/2, lower.tail=FALSE)

  return(list(
           tOss=tOss,
           lower=empiricalMean - tOss*standardError,
           upper=empiricalMean + tOss*standardError))
  
}


