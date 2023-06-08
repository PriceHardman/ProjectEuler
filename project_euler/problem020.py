# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!

import math

def problem020():
    # This is kind of cheating, but Python can calculate
    # large factorials directly
    output = 0
    for digit in str(math.factorial(100)):
        output += int(digit)
    return output

