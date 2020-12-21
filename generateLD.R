## generateLD
# Input: m, and max.
# Output: The Luria-Delbruck distribution from 0 to max with parameter m. Command: generateLD(m, max)

# generateLD; Last updated on 1/4/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This is a program which generates the Luria-Delbruck distribution for a
# given value for "m" and stores the distribution in the array "ldDist."

# Sarkar S, Ma WT, Sandri GH. On fluctuation analysis: a new, simple and
# efficient method for computing the expected number of mutants.
# Genetica. 1992;85(2):173-9.


generateLD <- function(m, max) {
  # the first value of the array is the probability of observing zero mutants.
  ldDist = c(exp(-m))
  
  # This loop fills out the array "ldDist," and for each run, determines the
  # probability of observing "i" mutants in a culture.

  for (i in 1:max) {
    x = seq(0,length(ldDist)-1)
    ldDist = c(ldDist, m / length(x)*sum(ldDist/(length(x)-x+1)))
  }
  
  # Output the array "ldDist"
  return (ldDist)
}