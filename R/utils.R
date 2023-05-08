# Utility functions


primes_up_to_n <- function(n) {
  # Generate a vector of all the primes up to n
  # using the Sieve of Erathosthenes

  if(n < 2) {
    return(c())
  }

  if(n == 2) {
    return(c(2))
  }

  # start with X, a list of all odd integers from 2 through n (keeping 2 in the list)
  X <- 2:n %>%
    subset(. == 2 | . %% 2 == 1)

  # Starting with p=2, remove from the list all multiples of p, except for p itself.
  p <- 2
  while(TRUE) {
    X <- X %>% subset(!(. > p & . %% p == 0))

    # The new p is the smallest number greater than p remaining in the list
    p <- X %>% subset(. > p) %>% head(n=1)

    # We can stop either if there's no such p, or the chosen p is greater than sqrt(n).
    if(length(p) == 0 | p > sqrt(n)) {
      break
    }
  }
  X
}

prime_factorization <- function(n) {
  # Factors a positive integer n into a product of powers of primes: n = p1^e1 + p2^e2 + ... + pi^ei

  # Output, a 2 column tibble
  factorization <- dplyr::tibble(prime_factor = numeric(), exponent = numeric())

  # We'll reassign n to a new variable N, which we'll successively factorize until it reaches 1
  N <- n
  list_of_primes <- primes_up_to_n(10000) # list of possible prime factors.

  # The largest possible prime factor of any integer n is n (in the case of n itself being prime).
  # We'll decompose n into its prime factors (and their powers) by iterating upwards through all
  # the primes up to n (although in practice we'll limit ourselves to the first ten thousand primes,
  # throwing an error if that isn't sufficient to fully factor n), performing trial division as we go.
  for(p in list_of_primes) {
    # If p divides n, keep dividing to find the exponent
    if(N %% p == 0){
      N <- N / p
      e <- 1
      while(N %% p == 0) {
        N <- N / p
        e <- e + 1
      }
      factorization <- factorization %>% add_row(prime_factor = p, exponent = e)
    }
    if(N == 1) {
      break
    }
  }
  # Return our completed factorization
  factorization
}
