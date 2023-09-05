# Problem 5: Smallest Multiple
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

problem005 <- function() {
  # Our number N must at least be equal to the product of all the primes from 1 to 20:
  # So 2*3*5*7*11*13*17*19 = 9699690 is a lower bound estimate.
  # But the number also has to be divisible by squares of primes, such as 4, 8, 9, etc.
  # So our number N is equal to the product of all the primes between 1 and 20, with each prime raised to
  # a power such that we can product all the numbers between 1 and 20.
  # So our answer is:

  1 ^ 1 * # covers 1
    2 ^ 4 * # covers 2,4,8,16, contributes factors to 6,10,12,14,18,20
    3 ^ 2 * # covers 3 and 9, contributes factors to 6,12,15,18
    5 ^ 1 * # covers 5, contributes factors to 10 and 15
    7 ^ 1 * # covers 7, contributes factors to 14
    11 ^ 1 *
    13 ^ 1 *
    17 ^ 1 *
    19 ^ 1
}
