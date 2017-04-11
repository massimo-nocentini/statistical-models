threeThree <- function(){

  weight <- rbind(
              c(100.8,102.0,105.9,108.0,92.0,116.7,110.2,
                135.0,123.5,95.0,105.0,85.0,107.2,80.0,
                115.1,103.5,82.0,101.5,103.5,93.0),
              c(97.0,107.5,97.0,108.0,84.0,111.5,102.5,
                127.5,118.5,94.2,105.0,82.4,98.2,83.6,
                115.0,103.0,80.0,101.5,102.6,93.0))

  sample <- weight[1,]-weight[2,]
  
  nullHp <- 0
  dimension <- length(sample)
  level <- .05
  empiricalMean <- mean(sample)
  variance <- var(weight[1,]) + var(weight[2,]) -
    2*cov(weight[1,], weight[2,])
  standardError <- sqrt(variance/dimension)
  superiorQuart <- qt(df=dimension-1, p=level/2, lower.tail=FALSE)
  tOss <- (empiricalMean - nullHp)/standardError

  automaticTest <- t.test(sample, mu = nullHp, alternative = "greater",
                          conf.level = 0.95)
  return(list(
           sample=sample,
           automaticTest=automaticTest,
           empiricalMean=empiricalMean,
           tOss=tOss,
           confidenceInterval= c(empiricalMean - superiorQuart*standardError,
             empiricalMean + superiorQuart*standardError),
           pValue=pt(df=dimension-1, lower.tail=FALSE, q=tOss)
           ))  
}
