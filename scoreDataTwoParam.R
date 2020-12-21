## scoreDataTwoParam
# Input: data from fluctuation assay, m, and d.
# Output: -log probability of observing data given m and d. Command: scoreDataTwoParam(data, m, d)
# This program requires the following programs to run: generateLD, generatePO, generateTwoParam.

# scoreDataTwoParam; Last updated on 1/7/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This is a program which calculates the negative log of the probability of
# observing the data given values for "m" and "d".

# Lang GI, Murray AW.  Estimating the per-base-pair mutation rate in the
# yeast, Saccharomyces cerevisiae.  Genetics.


scoreDataTwoParam <- function(data,m,d) {
  # This loop converts the data from a list of the number of mutants per
  # culture to an array where the position "i+1" corresponds to the number of
  # cultures with "i" mutants.
  tabdata=c()
  for (i in 0:max(data)) {
    tabdata[i+1]=length(data[data==i])
  }

  # Uses the m-file "generateTwoParam" to generate the Luria-Delbruck distribution with parameters "m" and "d" out to 100.
  dist=generateTwoParam(m,d,max(data))
  # Calculate the -log of the probability of observing the data
  score=sum(-log(dist.^tabdata))
  
  # Output the -log probability
  return (score)
}