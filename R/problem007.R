# Problem 7: 10001st prime
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?

problem007 <- function() {
  # We have a function that gives us all the primes up to a certain number n, but we don't know a priori
  # how many primes that will give us. So how high should we look to have a decent chance of getting the 10001st?

  # A rough heuristic for the prime counting function (that is, the # of primes less than or equal to n)
  # is approximately pi(n) = n / log(n).
  # So to give us some wiggle room, lets see what the expected n is to get 10500 primes.
  # uniroot(f = function(n){n/log(n) - 10500}, interval = c(1000,1000000))
  #   $root
  #   [1] 123064.9

  primes_up_to_n(123065)[10001]
}
