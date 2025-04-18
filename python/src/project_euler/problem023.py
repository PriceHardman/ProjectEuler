# A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
# For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28,
# which means that 28 is a perfect number.
# A number n is called deficient if the sum of its proper divisors is less than n and
# it is called abundant if this sum exceeds n.
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16,
# the smallest number that can be written as the sum of two abundant numbers is 24.
# By mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit cannot
# be reduced any further by analysis even though it is known that the greatest number
# that cannot be expressed as the sum of two abundant numbers is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
from project_euler.utils.number_theory import divisors

def main():
    return version2()


# %timeit problem023.version1()
# 2.55 s ± 16.3 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
def version1():
    abundants = []
    for n in range(28124):
        proper_divisors_of_n = divisors(n)[:-1]  # divisors of n, excluding n
        if sum(proper_divisors_of_n) > n:
            abundants.append(n)

    # Given the abundants up to 28123, generate the set of all possible
    # numbers that are the sum of two numbers in our list.
    # i.e. generate all n=a+b where a,b are in abundants.
    # Every integer up to 28124 that is NOT in this set will be
    # the numbers we need to sum for the answer.
    abundant_sums = set(a+b for a in abundants for b in abundants if a <= b)

    return sum(i for i in range(28124) if i not in abundant_sums)

# %timeit problem023.version2()
# 1.95 s ± 22.8 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
def version2():
    abundants = []
    for n in range(28124):
        proper_divisors_of_n = divisors(n)[:-1]  # divisors of n, excluding n
        if sum(proper_divisors_of_n) > n:
            abundants.append(n)

    # abundants contains the abundant numbers up to 28123
    # We want every number between 1 and 28123 that is not the sum
    # of two abundant numbers.
    # So starting with a set of 1:28123 we'll step through every
    # pair of abundants, removing their sum from the set, then
    # take the sum of the set at the end
    remaining = set(range(1,28124))
    for a in abundants:
        for b in [x for x in abundants if x <= a]: # only need lower triangular part of matrix
            remaining.discard(a+b)
    return sum(remaining)