threeFiveAutomatic <- function(m){
  oddsRatioInfo <- oddsratio(x)
  summary <- summary(oddsRatioInfo)

  ## Log Odds Ratio Std. Error z value  Pr(>|z|)    
  ## summary.oddsratio [1, 1:4] 0.959 0.0761 12.5934 0
  level <- .01
  logOddsRatioEstimator <- summary[1]
  asymptoticError <- summary[2]
  superiorQuart <- qnorm(level/2, lower.tail=FALSE)
  confidenceInterval <- c(
                          logOddsRatioEstimator - superiorQuart*asymptoticError,
                          logOddsRatioEstimator + superiorQuart*asymptoticError)
  return(list(
           matrix=m,
           confidenceIntervalOddsRatio=exp(confidenceInterval),
           confidenceIntervalRisk=exp(confidenceInterval)*
           (1-m[1,1]/(m[1,1]+m[1,2]))/(1-m[2,1]/(m[2,1]+m[2,2]))))
}
