# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#
# What is the sum of the digits of the number 2^1000?

# 1000 = 0b1111101000
#      = 512 + 256 + 128 + 64 + 32 + 8
#      = 2^9 + 2^8 + 2^7 + 2^6 + 2^5 + 2^3
#      = 2^3 * (1 + 2^2 * (1 + 2 + 2^2 * (1 + 2 + 2^2)))


def problem016():
    return sum([int(digit) for digit in str(2**1000)])

