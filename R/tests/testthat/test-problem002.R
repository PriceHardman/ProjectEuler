test_that("Problem 2 is correct", {
  expect_equal(problem002(), 4613732)
})

test_that("fibonacci_first_n_terms produces the first n terms of the Fibonacci sequence", {
  expect_equal(fibonacci_first_n_terms(1),c(1))
  expect_equal(fibonacci_first_n_terms(1,c(1)),c(1))

  expect_equal(fibonacci_first_n_terms(2),c(1,2))
  expect_equal(fibonacci_first_n_terms(2,c(1)),c(1,2))
  expect_equal(fibonacci_first_n_terms(2,c(1,2)),c(1,2))

  expect_equal(fibonacci_first_n_terms(10),c(1, 2, 3, 5, 8, 13, 21, 34, 55, 89))
  expect_equal(fibonacci_first_n_terms(10, c(1,2,3,5)),c(1, 2, 3, 5, 8, 13, 21, 34, 55, 89))
})

test_that("fibonacci_terms_up_to_n produces all terms of the fibonacci that don't exceed n", {
  expect_equal(fibonacci_terms_up_to_n(1), c(1))
  expect_equal(fibonacci_terms_up_to_n(2), c(1,2))
  expect_equal(fibonacci_terms_up_to_n(10), c(1,2,3,5,8))
  expect_equal(fibonacci_terms_up_to_n(100), c(1,2,3,5,8,13,21,34,55,89))
  expect_equal(fibonacci_terms_up_to_n(1000), c(1,2,3,5,8,13,21,34,55,89,144,233,377,610,987))
})
