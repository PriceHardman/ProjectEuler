# Problem 23: Non-abundant sums
# A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
# For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28,
# which means that 28 is a perfect number.

# A number n is called deficient if the sum of its proper divisors is less than n
# and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number
# that can be written as the sum of two abundant numbers is 24.
# By mathematical analysis, it can be shown that all integers greater than 28123 can be
# written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further
# by analysis even though it is known that the greatest number that cannot be expressed as the sum
# of two abundant numbers is less than this limit.

# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

problem023 <- function(){
  # All integers greater than 28123 can be written as the sum of two abundant numbers.
  # In other words, for all positive integers n > 28123 there exist positive integers a,b
  # such that a+b=n and a and b are both abundant.
  # To find all numbers n <= 28123 that cannot be expressed as the sum of two abundant numbers,
  # we'll instead find all the numbers n <= 28123 that *can* be expressed as the sum of two abundant
  # numbers, and take the difference.

  # First, we generate all abundant numbers between 12 (the smallest abundant number) and 28123-12=28111
  prime_cache <- primes_up_to_n(28123)
  sum_of_proper_divisors <- function(n){
    if(n <= 1) {
      0
    } else {
      factorization <- prime_factorization(n, prime_cache)
      p_i <- factorization$prime_factor
      e_i <- factorization$exponent
      prod((1-p_i^(e_i+1))/(1-p_i)) - n
    }
  }

  abundants <- tibble(n=1:28111) %>%
    rowwise() %>%
    filter(sum_of_proper_divisors(n) > n) %>%
    ungroup() %>%
    pull()


  # Then we start with all numbers from 1:28123 and mark them as TRUE.
  X <- rep(TRUE, 28123)

  # For each element i of abundants, get all the other elements
  # j such that i+j <= 28123, and mark those i+j's as FALSE.
  for(i in abundants){
    j <- abundants[abundants + i <= 28123]
    X[j+i] <- FALSE
  }

  # Finally, take the sum of the indices that are still marked TRUE.
  sum(which(X))
}
