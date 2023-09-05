# [Project Euler](https://projecteuler.net/) problems in Python

### Example: Analyzing Performance Hotspots of Problem 3

In an IPython console session, 
```
%load_ext line_profiler
import project_euler
from project_euler import problem003
```

Start with timing: 
```
%timeit problem003.main()
409 ms ± 5.05 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```

Profile the main function:
```
%lprun -f problem003.main problem003.main()
Timer unit: 1e-09 s
Total time: 1.0695 s
File: /Users/pricehardman/Documents/ProjectEuler/ProjectEuler.py/src/project_euler/problem003.py
Function: main at line 8
Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     8                                           def main():
     9         1 1069488000.0 1069488000.0    100.0      factorization = number_theory.prime_factorization_by_trial_division(600851475143)
    10         1       8000.0   8000.0      0.0      return max(factorization.keys())
```

Unsurprisingly, all the time is spent doing the factorization of 600851475143.
Lets profile the prime factorization function:
```
%lprun -f project_euler.utils.number_theory.prime_factorization_by_trial_division problem003.main()
Timer unit: 1e-09 s
Total time: 1.05247 s
File: /Users/pricehardman/Documents/ProjectEuler/ProjectEuler.py/src/project_euler/utils/number_theory.py
Function: prime_factorization_by_trial_division at line 29
Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    29                                           def prime_factorization_by_trial_division(n):
    30                                               # Factors integer n into a dict of prime factors and powers,
    31                                               # using trial division.
    32                                               # Example: 84 = 2 * 2 * 3 * 7 = 2^2 * 3^1 * 7^1 = {2:2, 3:1, 7:1}
    33                                           
    34                                               # List of possible factors are the primes 2, ..., sqrt(n)+1
    35                                               # NOTE: if n is very very large, this could be quite slow
    36         1 1051858000.0 1051858000.0     99.9      possible_prime_factors = primes_up_to(int(math.sqrt(n))+1)
    37                                           
    38         1          0.0      0.0      0.0      factors = {}    # dict where we'll store the factors and powers thereof
    39         1          0.0      0.0      0.0      x = n   # we'll continually whittle down x until it equals 1
    40                                           
    41       883     198000.0    224.2      0.0      for candidate_factor in possible_prime_factors: # 2, 3, 5, ...
    42                                                   # Stopping condition: We've completely factored n
    43       882     152000.0    172.3      0.0          if x == 1:
    44         1       1000.0   1000.0      0.0              return factors
    45                                           
    46                                                   # Otherwise, test if x is divisible by the candidate factor
    47       882     242000.0    274.4      0.0          while x % candidate_factor == 0:
    48         4      12000.0   3000.0      0.0              factors.setdefault(candidate_factor, 0)
    49         4       3000.0    750.0      0.0              factors[candidate_factor] += 1
    50         4       6000.0   1500.0      0.0              x = int(x / candidate_factor)
    51                                           
    52                                               # By this point, x could be prime. If it is, add it to the factors list then return
    53                                               if is_prime(x):
    54                                                   factors[x] = 1
    55                                               return factors
```

Almost all the time is spent creating the list of primes from which we test for factors.
Now lets profile the prime generation function:
```
%lprun -f project_euler.utils.number_theory.primes_up_to problem003.main()
Timer unit: 1e-09 s
Total time: 1.72179 s
File: /Users/pricehardman/Documents/ProjectEuler/ProjectEuler.py/src/project_euler/utils/number_theory.py
Function: primes_up_to at line 6
Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     6                                           def primes_up_to(n):
     7                                               # Generates a list of all the primes up to n using the Sieve of Eratosthenes
     8         1  113765000.0 113765000.0      6.6      candidates = {i: True for i in range(2, n)}
     9       879     246000.0    279.9      0.0      for i in range(2, math.ceil(math.sqrt(n))):
    10       728     182000.0    250.0      0.0          if candidates[i]:
    11       151      30000.0    198.7      0.0              j = 0
    12   1629729  541845000.0    332.5     31.5              while i*i + j*i <= n:
    13   1629729  666739000.0    409.1     38.7                  candidates[i*i + j*i] = False
    14   1629729  332429000.0    204.0     19.3                  j += 1
    15         1   66552000.0 66552000.0      3.9      return sorted([i for i in candidates.keys() if candidates[i]])
```

The most time is being spent on line 13, marking off multiples as composite.
Notice that we're calculating `i*i + j*i` twice in lines 12 and 13. Perhaps
we could speed things up a bit by calculating it once and assigning it to a variable.

```
%lprun -f project_euler.utils.number_theory.primes_up_to problem003.main()
Timer unit: 1e-09 s
Total time: 1.63198 s
File: /Users/pricehardman/Documents/ProjectEuler/ProjectEuler.py/src/project_euler/utils/number_theory.py
Function: primes_up_to at line 6
Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     6                                           def primes_up_to(n):
     7                                               # Generates a list of all the primes up to n using the Sieve of Eratosthenes
     8         1  111931000.0 111931000.0      6.9      candidates = {i: True for i in range(2, n)}
     9       879     209000.0    237.8      0.0      for i in range(2, math.ceil(math.sqrt(n))):
    10       728     194000.0    266.5      0.0          if candidates[i]:
    11       151      17000.0    112.6      0.0              j = 0
    12       151      59000.0    390.7      0.0              multiple = i*i + j*i
    13   1629729  358657000.0    220.1     22.0              while multiple <= n:
    14   1629729  471744000.0    289.5     28.9                  candidates[multiple] = False
    15   1629729  316399000.0    194.1     19.4                  j += 1
    16   1629729  306002000.0    187.8     18.8                  multiple += i
    17         1   66768000.0 66768000.0      4.1      return sorted([i for i in candidates.keys() if candidates[i]])
```

```
%timeit problem003.main()
294 ms ± 5.73 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```
That sped things up by 30%!


## References:

- https://packaging.python.org/en/latest/tutorials/packaging-projects/
- https://docs.pytest.org/en/latest/explanation/goodpractices.html#goodpractices
- https://github.com/pyutils/line_profiler