# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?

problem003 <- function() {
  prime_factorization(600851475143) %>%
    summarise(largest_factor = max(prime_factor)) %>%
    pull() # extract the scalar value from the results
}


