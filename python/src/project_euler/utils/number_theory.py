# Functions and classes for number-theoretic stuff (e.g. primes, divisibility, Fibonacci numbers, etc.)

import math
import itertools
import numpy as np

def primes_up_to(n):
    return optimized_sieve_of_erathosthenes(n)

def sieve_of_erathosthenes(n):
    # Generates a list of all the primes up to (but not including) n using the Sieve of Eratosthenes.
    candidates = {i: True for i in range(2, n)}  # Initially every number [2,n) is considered prime

    # Don't need to consider p above sqrt(n), as for any such composite p > sqrt(n),
    # it'll have a factor < sqrt(n) that we'd already have covered.
    for p in range(2, math.ceil(math.sqrt(n))):
        if candidates[p]: # If p is prime, starting at p^2 we mark every multiple p^2 + j*p <= n as composite.
            j = 0
            while p*p + j*p < n:
                candidates[p*p + j*p] = False
                j += 1
    return sorted([i for i in candidates.keys() if candidates[i]])  # Return whatever is still marked prime.

def optimized_sieve_of_erathosthenes(n):
    # Generates a list of all the primes up to (but not including) n using the Sieve of Eratosthenes.
    # Uses several optimizations to speed things up.

    # Base cases
    if n <= 2:
        return []
    if n == 3:
        return [2]

    # Our first optimization will be to only consider odd candidates p=3,5,...,n
    # This will require some extra complexity when reasoning about indices,
    # but saves significant time and space.
    # We'll use a numpy array of ones and zeros, lets call it X.
    # X[0] corresponds to p=3, X[1] to 5, X[2] to 7, and X[i] to 2i+3.
    # So how long should X be?
    # If n=3, length is 0.
    # If n=4 or 5, length is 1
    # If n=6 or 7, length is 2
    # Length is therefore ceil((n-3)/2)
    X = np.ones(math.ceil((n-3)/2))

    # Starting at p=3, we want to consider every odd p < sqrt(n).
    # But for any given n (where we want all the primes less than n),
    # which p's should we consider?
    # For any n in [4,25], we only want to consider p=3.
    # But once n > 25, sqrt(n) > 5, so we want to consider p=3,5,...
    # Likewise, once n > 49, we want to consider p=3,5,7,...
    # Therefore we want [3, max(ceil(sqrt(n)),4))
    for p in range(3, max(math.ceil(math.sqrt(n)), 4), 2):
        # Perform index translation
        i = int((p-3)/2)

        if X[i] == 1:
            # Mark any multiple of p in (p^2, n] as composite.
            values_to_mark = np.arange(p*p, n, 2*p)  # from p^2 to n, in strides of size 2p (i.e. only odds).
            indices_to_mark = ((values_to_mark - 3)/2).astype(int)  # translate to indices
            X[indices_to_mark] = 0

    # Get the indices of the positions still marked as prime,
    # translate to their values and return them, adding 2 at the start
    return [2] + list(2*np.nonzero(X)[0] + 3)




def is_prime(n):
    # Primality test using trial division
    if n <= 1:
        return False
    if n == 2:
        return True
    for p in primes_up_to(math.ceil(math.sqrt(n))+1):
        if n % p == 0:
            return False
    return True

def prime_factorization_by_trial_division(n):
    # Factors integer n into a dict of prime factors and powers,
    # using trial division.
    # Example: 84 = 2 * 2 * 3 * 7 = 2^2 * 3^1 * 7^1 = {2:2, 3:1, 7:1}

    # List of possible factors are the primes 2, ..., sqrt(n)+1
    # NOTE: if n is very very large, this could be quite slow
    possible_prime_factors = primes_up_to(int(math.sqrt(n))+1)

    factors = {}    # dict where we'll store the factors and powers thereof
    x = n   # we'll continually whittle down x until it equals 1

    for candidate_factor in possible_prime_factors: # 2, 3, 5, ...
        # Stopping condition: We've completely factored n
        if x == 1:
            return factors

        # Otherwise, test if x is divisible by the candidate factor
        while x % candidate_factor == 0:
            factors.setdefault(candidate_factor, 0)
            factors[candidate_factor] += 1
            x = int(x / candidate_factor)

    # By this point, x could be prime. If it is, add it to the factors list then return
    if is_prime(x):
        factors[x] = 1
    return factors


def divisors(n):
    # Returns a list in ascending order of the divisors of an integer n, including n

    # First step is to build a list of all the factors of n, from the prime factorization
    factors = [1]
    for factor, power in prime_factorization_by_trial_division(n).items():
        for _ in range(power):
            factors.append(factor)

    # The divisors of n are the products of each unique subset
    # of the factors of n. So we'll iterate through every possible
    # subset of factors.
    divisors = {}
    for subset_size in range(len(factors)):
        for subset in itertools.combinations(factors, subset_size):
            if subset not in divisors:
                divisors[subset] = math.prod(subset)

    return sorted(list(set(divisors.values())))

class FibonacciSequence:
    # Generates an infinite sequence of Fibonacci numbers.
    # Usage:
    def __init__(self):
        self.Fn_2 = 0
        self.Fn_1 = 1
        self.Fn = 1

    def __repr__(self):
        return f"Fibonacci(0,1,...,{self.Fn})"

    def __iter__(self):
        while True:
            yield self.Fn
            self.Fn_2 = self.Fn_1
            self.Fn_1 = self.Fn
            self.Fn = self.Fn_1 + self.Fn_2
