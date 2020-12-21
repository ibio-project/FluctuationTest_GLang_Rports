## SSDScoreTwoParam
# Input: data from fluctuation assay.
# Output: sum of the squared differences between the cumulative distribution
# of the data and the cumulative combined Luria-Delbruck and Poisson distribution with parameters m and lambda = m x d determined from the data.
# Command: SSDScoreTwoParam(data)
# This program requires the following programs to run: findMLmTwoParam, scoreDataTwoParam, generateLD, generatePO, generateTwoParam.

# SSDScoreTwoParam; Last updated on 1/8/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This program calculates the sum-of-the-square difference between the
# cumulative distribution of the data and the cumulative
# Luria-Delbruck/Poisson distribution with parameters "m" and "d"
# determined from the data.

# Lang GI, Murray AW.  Estimating the per-base-pair mutation rate in the
# yeast, Saccharomyces cerevisiae.  Genetics.

# Import "data" from user.
SSDScoreTwoParam <- function (data) {

  # find the most-likely values for "m" and "d" given the data.
  md=findMLmTwoParam(data)

  m=md[1]
  d=md[2]
  # the length of the array "data" is the number of cultures counted in the fluctuation assay
  cultures=length(data)
  dist = generateTwoParam(m,d,1000)
  # the array "actu" is the cumulative Luria-Delbruck/Poisson distribution with parameters "m" and "d".
  actu = cumsum(dist)

  # This loop converts the data from a list of the number of mutants per
  # culture to an array where the position "i+1" corresponds to the number of
  # cultures with "i" mutants.
  tabdata=c()
  for (i in 0:(length(actu)-1)) {
    tabdata[i+1]=length(data[data==i])
  }
  
  # calculate the difference between the cumulative distribution of the data (normalized by the number of cultures) and the cumulative Luria-Delbruck/Poisson distribution.
  score=sum((cumsum(tabdata)/cultures - actu)^2)

  # output the sum-of-the-square difference.
  return (score)
}