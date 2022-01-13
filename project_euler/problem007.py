# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
#
# What is the 10 001st prime number?


from utils import primes

def problem007():
    # primes_up_to(n) will give us a list X of length m, and so we merely need
    # to use a large enough n such that m >= 10001. As a heuristic we'll start
    # with n = 10000 and multiply n by 10 until m is large enough, then index to
    # the desired number
    n = 10000
    X = primes.primes_up_to(n)
    while len(X) < 10001:
        n *= 10
        X = primes.primes_up_to(n)
    return X[10000]
