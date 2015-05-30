
# Convert a (significand, exponent) to an actual number.

toNumeric <- (function() {
  lookup <- c(K=1e+3,M=1e+6,m=1e+6,B=1e+9)
  function(significand, exponent) {
    multiplier <- lookup[exponent]
    if (is.na(multiplier)) {
      numexp <- suppressWarnings(as.numeric(exponent))
      if (is.na(numexp)) {
        multiplier <- 1
      } else {
        multiplier = 10^numexp
      }
    }
    significand * multiplier 
  }
})()
