## sampleTwoParam
# Input: m, number of samples.
# Output: Random variables from a combined Luria-Delbruck and Poisson
# distribution with parameters m and lambda = m x d. Command: sampleTwoParam(m, d, samples)
# This program requires the following programs to run: generateLD, generatePO, generateTwoParam.

# sampleTwoParam; Last updated on 1/8/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This program simulates a fluctuation experiment by sampling from the
# combined Luria-Delbruck/Poisson distribution.

sampleTwoParam <- function(m,d,samples) {
#   the imput requires three variables:  
#   m = the expected number of mutations per culture
#   d = post-plating growth (the number of cell divisions per plated cell)
#   samples = the number of cultures to be simulated
  
  # "r" is the output array: each number in the array is a different culture.  The maximum value for "r" is 101--this is set by the m-file, "generateTwoParam"
  r=c()
  
  # define the variable "dist" = the combined Luria-Delbruck (parameter "m") and Poisson (parameter "d") distributions
  dist=generateTwoParam(m,d,1000)
  # sets "cdist" = the cumulative of "dist".  the "1" ensures that the cumulateve distribution ends at unity.
  cdist=c(cumsum(dist))

  # loop - each loop calculates the number of mutants in one culture
  for (i in 1:samples) {
    # subtract a uniform random number [0,1] from the cumulative distribution
    samp=cdist-runif(1)
    # convert all positive values to 0
    samp[samp > 0] = 0
    # convert all negative values to 1
    samp[samp < 0] = 1
    # sum the positive values and add this number to the array of mutants per culture
    r=c(r, sum(samp))
  }
  
  # output the cultures
  return (r)
}