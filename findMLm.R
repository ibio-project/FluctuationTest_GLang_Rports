## findMLm
# Input: data from fluctuation assay.
# Output: most likely value of m given the data. Command: findMLm(data)
# This program requires the following programs to run: scoreData, generateLD.

# findMLm; Last updated on 1/4/07; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21
# 
# This is a program which finds the most-likely value of "m" given data
# from a Luria-Delbruck fluctuation assay.
# 
# Sarkar S, Ma WT, Sandri GH. On fluctuation analysis: a new, simple and
# efficient method for computing the expected number of mutants.
# Genetica. 1992;85(2):173-9.

findMLm <-function (data){  #; Import data from user.

  #; To perform a maximum likelihood analysis, you first need to make a guess of "m".  Here we guess that "m" is the median value of from the fluctuation data.  We add 0.1 to the median to ensure that our initial guess is > 0.
  m=median(data)+0.1
  # If the median is > 10, we set the initial guess at 10.
  m[m>10]=10;

  # Below the five loops optimize one digit at a time.

  #; Set the "scores" array to a trivial value which fails the below test "scores(2) > min(scores)"
  scores=c(0, 1, 0)
  while (scores(2) > min(scores)) {
    #; the "ms" array the current estimate for "m" and the two adjacent values
    ms=c(m-1, m, m+1)
    ms[ms<0]=0
    # Using the m-file "scoreData," determine the log probability of "m" given the data
    scores=c(scoreData(data,ms(1)), scoreData(data,ms(2)), scoreData(data,ms(3)))
    # Set the value for "m" to the lowest of the three scores
    m=ms[scores==min(scores)] 
  }

  for (offset in 0.1^(1:4)) {
    scores=c(0, 1, 0)
    while (scores(2) > min(scores)) {
      ms=c(m-offset, m, m+offset)
      scores=sapply(1:3, function(x) scoreData(data,ms(x)))
      m=ms[scores==min(scores)];
    }
  }
  
  #Output the maximum likelihood value of "m".
  return (m)
}