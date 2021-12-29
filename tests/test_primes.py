from project_euler.utils import primes


def test_primes_up_to():
    assert primes.primes_up_to(1) == []
    assert primes.primes_up_to(2) == []
    assert primes.primes_up_to(3) == [2]
    assert primes.primes_up_to(4) == [2, 3]
    assert primes.primes_up_to(5) == [2, 3]
    assert primes.primes_up_to(6) == [2, 3, 5]
    assert primes.primes_up_to(7) == [2, 3, 5]
    assert primes.primes_up_to(8) == [2, 3, 5, 7]
    assert primes.primes_up_to(9) == [2, 3, 5, 7]
    assert primes.primes_up_to(10) == [2, 3, 5, 7]
    assert primes.primes_up_to(20) == [2, 3, 5, 7, 11, 13, 17, 19]
    assert primes.primes_up_to(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    assert primes.primes_up_to(40) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37]
    assert primes.primes_up_to(50) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    assert primes.primes_up_to(100) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
                                        79, 83, 89, 97]


def test_is_prime():
    primes_up_to_100 = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
    for i in range(100):
        assert primes.is_prime(i) == (i in primes_up_to_100)

    assert primes.is_prime(5915587277)  # try it on a relatively big number


def test_prime_factorization_by_trial_division():
    assert primes.prime_factorization_by_trial_division(1) == {}
    assert primes.prime_factorization_by_trial_division(2) == {2: 1}
    assert primes.prime_factorization_by_trial_division(3) == {3: 1}
    assert primes.prime_factorization_by_trial_division(4) == {2: 2}
    assert primes.prime_factorization_by_trial_division(5) == {5: 1}
    assert primes.prime_factorization_by_trial_division(6) == {2: 1, 3: 1}
    assert primes.prime_factorization_by_trial_division(7) == {7: 1}
    assert primes.prime_factorization_by_trial_division(8) == {2: 3}
    assert primes.prime_factorization_by_trial_division(9) == {3: 2}
    assert primes.prime_factorization_by_trial_division(10) == {2: 1, 5: 1}
    assert primes.prime_factorization_by_trial_division(19) == {19: 1}
    assert primes.prime_factorization_by_trial_division(20) == {2: 2, 5: 1}
    assert primes.prime_factorization_by_trial_division(29) == {29: 1}
    assert primes.prime_factorization_by_trial_division(30) == {2: 1, 3: 1, 5: 1}
    assert primes.prime_factorization_by_trial_division(39) == {3: 1, 13: 1}
    assert primes.prime_factorization_by_trial_division(40) == {2: 3, 5: 1}
    assert primes.prime_factorization_by_trial_division(49) == {7: 2}
    assert primes.prime_factorization_by_trial_division(50) == {2: 1, 5: 2}
    assert primes.prime_factorization_by_trial_division(99) == {3: 2, 11: 1}
    assert primes.prime_factorization_by_trial_division(100) == {2: 2, 5: 2}
