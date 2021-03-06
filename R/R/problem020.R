# Problem 20: Factorial Digit Sum
# n! means n × (n − 1) × ... × 3 × 2 × 1
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!

problem020 <- function(){
  # If we really had to, we could implement long multiplication again like in the 2^1000 problem.
  # Also, R's base factorial() function gives incorrect results for large arguments such as 100.
  # So we'll use gmp::factorialZ

  sum(as.integer(strsplit(format(gmp::factorialZ(100), scientific=FALSE),"")[[1]]))
}
