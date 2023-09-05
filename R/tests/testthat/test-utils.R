test_that("primes_up_to_n produces sequences of primes", {
  expect_equal(primes_up_to_n(n = 1), c())
  expect_equal(primes_up_to_n(n = 2), c(2))
  expect_equal(primes_up_to_n(n = 3), c(2,3))
  expect_equal(primes_up_to_n(n = 4), c(2,3))
  expect_equal(primes_up_to_n(n = 5), c(2,3,5))
  expect_equal(primes_up_to_n(n = 6), c(2,3,5))
  expect_equal(primes_up_to_n(n = 7), c(2,3,5,7))
  expect_equal(primes_up_to_n(n = 8), c(2,3,5,7))
  expect_equal(primes_up_to_n(n = 9), c(2,3,5,7))
  expect_equal(primes_up_to_n(n = 10), c(2,3,5,7))
  expect_equal(primes_up_to_n(n = 25), c(2,3,5,7,11,13,17,19,23))
  expect_equal(primes_up_to_n(n = 100), c(2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97))
})

test_that("prime_factorization produces prime factorizations of positive integers", {
  # Without cache
  expect_equal(prime_factorization(2), data.frame(prime_factor=c(2),exponent=c(1)))
  expect_equal(prime_factorization(50), data.frame(prime_factor=c(2,5),exponent=c(1,2)))
  expect_equal(prime_factorization(100), data.frame(prime_factor=c(2,5),exponent=c(2,2)))
  expect_equal(prime_factorization(999), data.frame(prime_factor=c(3,37),exponent=c(3,1)))
  expect_equal(prime_factorization(9999), data.frame(prime_factor=c(3,11,101),exponent=c(2,1,1)))

  # With cache
  primes_cache <- c(2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101)
  expect_equal(prime_factorization(2,primes_cache), data.frame(prime_factor=c(2),exponent=c(1)))
  expect_equal(prime_factorization(50,primes_cache), data.frame(prime_factor=c(2,5),exponent=c(1,2)))
  expect_equal(prime_factorization(100,primes_cache), data.frame(prime_factor=c(2,5),exponent=c(2,2)))
  expect_equal(prime_factorization(999,primes_cache), data.frame(prime_factor=c(3,37),exponent=c(3,1)))
  expect_equal(prime_factorization(9999,primes_cache), data.frame(prime_factor=c(3,11,101),exponent=c(2,1,1)))
})
