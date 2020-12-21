## sampleLD
# Input: m, number of samples.
# Output: Random variables from the Luria-Delbruck distribution with
# parameter m. Command: sampleLD(m, samples)
# This program requires the following program to run: generateLD.

# sampleLD; Last updated on 1/4/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This program simulates a fluctuation experiment by sampling from the
# Luria-Delbruck distribution.


sampleLD <- function (m,samples) {

#   "m" is the parameter which describes the distribution.
#   samples = the number of cultures to be simulated

  # "r" is the output array: each number in the array is a different culture.
  r=c()
  
  # define the variable "dist" = the Luria-Delbruck distribution with parameter "m".  The "1000" sets the maximum value for mutants per culture in this simulation (in this case 1001).
  dist=generateLD(m,1000)
  # sets "cdist" = the cumulative of "dist".
  cdist=cumsum(dist)

  # loop - each loop calculates the number of mutants in one culture
  for (i in 1:samples) {
    # subtract a uniform random number [0,1] from the cumulative distribution
    samp=cdist-runif(1)
    # convert all positive values to 0
    samp[samp > 0] = 0
    # convert all negative values to 1
    samp[samp < 0] = 1
    # sum the positive values and add this number to the array of mutants per culture
    r=c(r,sum(samp))
  }
  
  # output the cultures
  return (r)
}