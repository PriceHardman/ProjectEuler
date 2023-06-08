# Problem 3:
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
from project_euler.utils import number_theory

def problem003():
    factorization = number_theory.prime_factorization_by_trial_division(600851475143)
    return max(factorization.keys())
