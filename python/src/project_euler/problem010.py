# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

from project_euler.utils.number_theory import primes_up_to

def main():
    return sum(primes_up_to(2_000_000))