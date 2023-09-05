# Problem 21: Amicable numbers
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110;
# therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.


# For an integer n with prime factorization n = p1^e1 * ... * pN^eN,
# The divisors (including n itself) are the cartesian product of the
# prime factors pi raised to each power between 0 and ei:
#
# Divisors = {p1^0,...,p1^e1} X ... X {pN^0,...,pN^eN}.
#
# Similarly, the sum of the divisors of n is simply the product
# sum(divisors(n)) = (p1^0 + ... + p1^e1) X ... X (pN^0 + ... + pN^eN)
#                  = \prod_{i=1}^{N}{\sum_{j=0}^{e_{i}}{p_{i}^{j}}}
#                  = \prod_{i=1}^{N}{(1-p_{i}^{e_{i}+1})/(1-p_{i})}, by the formula for sum of a geometric series.

# The sum of the proper divisors is simply this value minus n.

problem021 <- function(){
  prime_cache <- primes_up_to_n(100000)

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

  is_amicable_number <- function(n){
    m = sum_of_proper_divisors(n)
    m != n & sum_of_proper_divisors(m) == n
  }

  tibble(n=2:9999) %>%
    rowwise() %>%
    filter(is_amicable_number(n)) %>%
    ungroup() %>%
    pull() %>%
    sum()
}
