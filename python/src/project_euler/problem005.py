# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?


def main():
    # This one is pretty easy to figure out analytically:
    # The answer is whatever number can be constructed as
    # the product of the smallest # of factors such that we can
    # create all the numbers from 1 - 20 out of them.
    # Obviously we'll need all the primes from 2 - 19: 2*3*5*7*11*13*17*19
    # Together these allow us to also make 6 (2*3), 10 (2*5), 14 (2*7), and 15 (3*5).
    # But we're still missing 4, 8, 9, 12, 16, 18, and 20.
    # Adding another 2 gets us 4, 12, and 20: 2*2*3*5*7*11*13*17*19
    # Adding another 3 gets us 9 and 18: 2*2*3*3*5*7*11*13*17*19
    # Adding another 2 gets us 8: 2*2*2*3*3*5*7*11*13*17*19
    # And yet another 2 gets us 16: 2*2*2*2*3*3*5*7*11*13*17*19 = 232792560

    # But just for fun, lets code this up to find the number by searching each multiple of 2*3*5*7*11*13*17*19
    # until we find the first number divisible by all 20:
    candidate = 2*3*5*7*11*13*17*19
    while True:
        if all(candidate % d == 0 for d in range(1, 21)):
            return candidate
        candidate += (2*3*5*7*11*13*17*19)

