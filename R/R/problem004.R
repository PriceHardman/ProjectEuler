# Problem 4: Largest palindromic product
# A palindromic number reads the same both ways. The largest palindrome made from the
# product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

problem004 <- function() {

  # Handy function to get string reverse of an integer
  reverse <- function(n) {
    as.integer(paste(rev(strsplit(as.character(n), '')[[1]]), collapse = ''))
  }

  largest_found_so_far <- 0
  for(i in 999:100) {
    for(j in 999:i) {
      product <- i*j
      if(product <= largest_found_so_far) { # we don't need to consider this j anymore
        break
      }
      if(product == reverse(product) & product > largest_found_so_far) {
        largest_found_so_far <- product
      }
    }
  }
  largest_found_so_far
}
