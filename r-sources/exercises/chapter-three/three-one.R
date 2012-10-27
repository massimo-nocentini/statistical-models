
threeOne <- function(){

  nullHp <- 0 #we keep under test that the two means are different
  nOne <- 5
  nTwo <- 5
  dimension <- nOne + nTwo
  level <- .05
  meansDifference <- 123.8 - 116.4
  varEstimator <- ((nOne - 1)*(4.6^2) + (nTwo - 1)*(16.09^2))/(dimension - 2)
  standardError <- sqrt(varEstimator * (1/nOne + 1/nTwo))
  superiorQuart <- qt(df=dimension-2, p=level/2, lower.tail=FALSE)
  tOss <- (meansDifference - nullHp)/standardError

  return(list(           
           tOss=tOss,
           meansDifference=meansDifference,
           confidenceInterval= c(meansDifference - superiorQuart*standardError,
             meansDifference + superiorQuart*standardError),
           pValue=2*pt(df=dimension-2, lower.tail=FALSE, q=tOss)
           ))    
}


