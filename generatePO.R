## generatePO
# Input: lambda, and max.
# Output: The Poisson distribution from 0 to max with parameter lambda. 
# Command: generatePO(lambda, max)

# generatePO; Last updated on 1/8/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This is a program which generates the Poisson distribution for a
# given value for "lambda" and stores the distribution in the array "dist".

generatePO <- function (lambda,max) {

  dist=rep(0,max+1)
  
  # This loop determines the Poisson probability of observing "x" given the
  # chosen "lambda".
  for (x in 0:max) {
    dist[x+1]=(lambda^x/factorial(x)*exp(-lambda));
    x=x+1;
  }

  return (dist) # Output the array "dist"
}