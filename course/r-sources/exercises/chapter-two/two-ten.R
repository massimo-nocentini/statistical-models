twoTen <- function(){

  n <- 100
  r <- 2
  level <- .05
  empiricalMean <- r/n
  superiorQuart <- qnorm(p=level/2, lower.tail=FALSE)

  empiricalMeanAgrestiCoull <- (r + 2)/(n + 4)
  return(
    list(
      asymptotic=c(
        empiricalMean - superiorQuart * sqrt(empiricalMean*(1-empiricalMean)/n),
        empiricalMean + superiorQuart * sqrt(empiricalMean*(1-empiricalMean)/n)),
      AgrestiCoull=c(
        empiricalMeanAgrestiCoull - superiorQuart *
        sqrt(empiricalMeanAgrestiCoull*(1-empiricalMeanAgrestiCoull)/(n+4)),
        empiricalMeanAgrestiCoull + superiorQuart *
        sqrt(empiricalMeanAgrestiCoull*(1-empiricalMeanAgrestiCoull)/(n+4)))))
}
