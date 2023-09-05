# Problem 9: Special Pythagorean triplet
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
# a^2 + b^2 = c^2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

problem009 <- function(){
  is_pythagorean_triple <- function(a,b,c) {
    a^2 + b^2 == c^2
  }

  # We know that a + b + c = 1000 and that
  # in our solution a^2 + b^2 = c^2,
  # so we can specify a < b < c, because we know a+b < c, and because we're only interested
  # in the sums a+b and a^2 + b^2 we don't need to test all reciprocal pairs (a,b) and (b,a),
  # we can limit ourselves to just a < b. Hence a < b < c.
  # We can see that c isn't a free variable, its fixed at 1000-a-b so we just need
  # to test different combinations of a and b such that a < b and a+b+c=1000.
  # What is the possible range of a? The smallest value is clearly a=1. For the
  # largest value, the 3 values would be 1 apart: a + (a+1) + (a+2) = 1000,
  # so max(a) = floor((1000 - 3)/3) = 332.
  # What about b's range? Its minimum value is a + 1 (since a < b < c)

  # Now we just brute force search for a=1:332, b=(a+1):499
  for(a in 1:332){
    for(b in (a+1):499) {
      c <- 1000 - a - b
      if(is_pythagorean_triple(a,b,c)){
        return(a*b*c)
      }
    }
  }
}
