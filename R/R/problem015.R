# Problem 15: Lattice Paths
# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down,
# there are exactly 6 routes to the bottom right corner:
#   R,R,D,D
#   R,D,R,D
#   R,D,D,R
#   D,R,R,D
#   D,R,D,R
#   D,D,R,R
#
# How many such routes are there through a 20x20 grid?

problem015 <- function() {
  # Lets think only about where to put the R's. We have 2N possible spots in which to arrange N R's.
  # The D's will occupy the remaining N spots. How many ways can we choose from 2N spots where to place N
  # objects? 2N choose N = (2N)! / (2N - N)!N! = (2N)! / 2N!

  # So our answer is choose(2N=40, N=20) = 137846528820
  choose(40,20)
}
