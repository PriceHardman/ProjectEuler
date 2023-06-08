# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#
# a^2 + b^2 = c^2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

#

def problem009():
    # According to Euclid's Formula, for 0 < n < m,
    # a = m^2 - n^2, b = 2mn, c = m^2 + n^2 is a Pythagorean Triplet
    # Therefore, a+b+c = m^2 - n^2 + 2mn + m^2 + n^2 = 2m^2 + 2mn = 2m*(m+n) = 1000
    for m in range(1, 1000):
        for n in range(1, m):
            if 2*m*(m+n) == 1000:
                a = m**2 - n**2
                b = 2*m*n
                c = m**2 + n**2
                return a * b * c

