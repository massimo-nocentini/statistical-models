twoEight <- function(){

  alcoholValues <-c(12.3,12.7,13.6,12.7,12.9,12.6,12.6,13.1,12.6,13.1,12.7,12.5,13.2,
                     12.8,12.4,12.6,12.4,12.4,13.1,12.9,13.3,12.6,12.6,12.7,13.1,12.4,
                     12.4,13.1,12.4,12.9)
  nullHp <- 12
  dimension <- length(alcoholValues)
  level <- .05
  empiricalMean <- mean(alcoholValues)
  standardError <- sqrt(var(alcoholValues)/dimension)
  superiorQuart <- qt(df=dimension-1, p=level/2, lower.tail=FALSE)
  tOss <- (empiricalMean - nullHp)/standardError

  automaticTest <- t.test(alcoholValues, mu = nullHp, alternative = "two.sided")
  return(list(           
           automaticTest=automaticTest,
           tOss=tOss,
           confidenceInterval= c(empiricalMean - superiorQuart*standardError,
             empiricalMean + superiorQuart*standardError),
           pValue=2*pt(df=dimension-1, lower.tail=FALSE, q=tOss)
           ))  
}
