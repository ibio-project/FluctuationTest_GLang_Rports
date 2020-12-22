## findMLmTwoParam
# Input: data from fluctuation assay.
# Output: most likely values of m and d given the data. Command: findMLmTwoParameter(data)
# This program requires the following programs to run: scoreDataTwoParam, generateLD, generatePO, generateTwoParam.

# findMLmTwoParam; Last updated on 03/10/10; 
# Greg Lang; Harvard University
# ported to R by Toshinori Endo; Hokkaido University 2020.12.21

# This is a program which finds the most-likely value of "m" and "d" given data from a Luria-Delbruck fluctuation assay.

# Lang GI, Murray AW.  Estimating the per-base-pair mutation rate in the
# yeast, Saccharomyces cerevisiae.  Genetics.

findMLmTwoParam <- function(data){

  # To perform a maximum likelihood analysis, you first need to make a guess of "m".  Here we guess that "m" is the median value of from the fluctuation data.  We add 0.1 to the median to ensure that our initial guess is > 0.
  m=median(data)+0.1;
  # If the median is > 10, we set the initial guess at 10.
  m[m>10]=10;
  d=0;

  previous_m = 0
  while (m != previous_m) {
    previous_m = m

    # OPTIMIZE "m":  Below the five loops optimize one digit at a time.
    for (margin in 10^(0:-4)) {

      # Set the "scores" array to a trivial value which fails the below test "scores(2) > min(scores)"
      scores=c(0, 1, 0)
      while (scores[2] > min(scores)) {
        # the "ms" array the current estimate for "m" and the two adjacent values
        ms=c(m-margin, m, m+margin)
        # Using the m-file "scoreData," determine the log probability of "m" given the data
        scores=sapply(1:3,function(x) scoreDataTwoParam(data,ms[x],d))
        # Maximize the score for ms<0 to remove negative m values
        # original: scores(find(ms<0))=max(scores)+1;
        scores[ms<0]=max(scores)+1;
        # Set the value for "m" to the lowest of the three scores
        # original: m=ms(find(scores==min(scores)));
        m=ms[scores==min(scores)]
      }
    }

    # OPTIMIZE "d":  The two loops below optimize "d" one digit at a time.

    # Set the "scores" array to a trivial value which fails the below test "scores(2) > min(scores)"
    for (margin in 10^(-1:-2)) {
      scores=c(0, 1, 0)
      while (scores[2] > min(scores)) {
        # the "ds" array the current estimate for "d" and the two adjacent values
        ds=c(d-margin, d, d+margin)
        ds[ds<0]=margin
        # Using the m-file "scoreDataTwoParam," determine the log probability of "m" given the data
        scores=sapply(1:3,function(x) scoreDataTwoParam(data,m,ds[x]))
        # Maximize the score for ds<0 to remove negative d values
        scores[ds<0]=max(scores)+1
        # Set the value for "m" to the lowest of the three scores
        d=ds[scores==min(scores)]
      }
    }
  }   
  # Output the maximum likelihood values for "m" and "d"
  return (c(m,d))
}