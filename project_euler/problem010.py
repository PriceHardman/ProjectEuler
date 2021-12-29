# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

from utils import primes

def problem010():
    return sum(primes.primes_up_to(2_000_000))