
twoSeven <- function(){

  nullHp <- 25
  dimension <- 30
  level <- .05
  empiricalMean <- 26.3
  standardError <- 2.4/sqrt(dimension)
  superiorQuart <- qt(df=dimension-1, p=level/2, lower.tail=FALSE)
  tOss <- (empiricalMean - nullHp)/standardError

  return(list(           
           tOss=tOss,
           confidenceInterval= c(empiricalMean - superiorQuart*standardError,
             empiricalMean + superiorQuart*standardError),
           pValue=pt(df=dimension-1, lower.tail=FALSE, q=tOss)
           ))    
}


