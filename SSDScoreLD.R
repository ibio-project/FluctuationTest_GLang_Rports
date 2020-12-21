## SSDScoreLD
# Input: data from fluctuation assay.
# Output: sum of the squared differences between the cumulative distribution
# of the data and the cumulative Luria-Delbruck distribution with
# parameter m determined from the data. Command: SSDScore(data)
# This program requires the following programs to run: findMLm, scoreData, generateLD.

# SSDScoreLD; Last updated on 1/8/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This program calculates the sum-of-the-square difference between the
# cumulative distribution of the data and the cumulative Luria-Delbruck
# distribution with the most-likely parameter "m" determined for the data.

# Lang GI, Murray AW.  Estimating the per-base-pair mutation rate in the
# yeast, Saccharomyces cerevisiae.  Genetics.

# Import "data" from user.
SSDScoreLD <- function(data) {
  
  # find the most-likely value for "m" given the data.
  m=findMLm(data)
  # the length of the array "data" is the number of cultures counted in the fluctuation assay
  cultures=length(data);
  # the array "actu" is the cumulative Luria-Delbruck distribtuion with parameter "m".
  actu = cumsum(generateLD(m,1000));
  
  # This loop converts the data from a list of the number of mutants per
  # culture to an array where the position "i+1" corresponds to the number of
  # cultures with "i" mutants.
  tabdata=c()
  for (i in 0:(length(actu)-1)) {
    tabdata[i+1]=length(data[data==i])
  }
  
  # calculate the difference between the cumulative distribution of the data (normalized by the number of cultures) and the cumulative Luria-Delbruck distribution.
#  score =[sum((cumsum(tabdata)/cultures - actu)^2)]
  
  # output the sum-of-the-square difference.
  return (tabdata)
}