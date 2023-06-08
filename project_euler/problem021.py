# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
# and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110;
# therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.

from utils import number_theory

def problem021():

    def d(n):
        return sum(number_theory.divisors(n)[:-1])

    d_table = {n: d(n) for n in range(0, 10000)}  # {..., 220: 284, ..., 284: 220, ...}

    amicables = []
    for n, d_n in d_table.items():
        if d_n in d_table and d_table[d_n] == n and d_n != n:
            amicables.append(n)

    return sum(amicables)

