## generateTwoParam
# Input: m, d, and max.
# Output: The combined Luria-Delbruck and Poisson distribution from 0 to
# max with parameters m and lambda = m x d. Command: generateTwoParam(m, d, max)
# This program requires the following programs to run: generateLD, generatePO.

# generateTwoParam; Last updated on 1/8/07; 
# Greg Lang; Harvard University

# This script generates a Luria-Delbruck distribution overlaid with a
# Poisson, simulating the effect of post-plating growth on the
# Luria-Delbruck distribution.
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# Any cultures with more than "max" colonies are lumped into the "max" group.

generateTwoParam <- function(m,d,max){
  
  # Generate a Luria-Delbruck distribution with parameter "m" up to "max".
  LD=generateLD(m,max)
  # Generate the Poisson distribution with parameter "lambda" = "m*d" up to "max".
  PO=generatePO(m*d,max)
  # This line of code finds all values in the Poisson dist that are so small that they register as NaN ("Not a Number") and sets them to 0.
  PO[is.nan(PO)]=0
  # Create an empty array "coDist".
  coDist=c()

  # The loop below calculates the probability distribution for the combined
  # Luria-Delbruck/Poisson.  
  for (i in 0:max)
    coDist=rbind(coDist, LD(1:i+1) * rev(PO(1:i+1)))
  
  return (coDist)
}