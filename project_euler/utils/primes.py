import math
import itertools

def primes_up_to(n):
    # Generates a list of all the primes up to n using the Sieve of Eratosthenes
    candidates = {i: True for i in range(2, n)}
    for i in range(2, math.ceil(math.sqrt(n))):
        if candidates[i]:
            j = 0
            while i*i + j*i <= n:
                candidates[i*i + j*i] = False
                j += 1
    return sorted([i for i in candidates.keys() if candidates[i]])


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
