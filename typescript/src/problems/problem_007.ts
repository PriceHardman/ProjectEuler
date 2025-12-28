import * as utils from "../utils";

// Problem 7:
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
// What is the 10 001st prime number?

export function main(): number {
    const primes = utils.primesUpTo(1_000_000) // lets make the rather safe assumption the 10001st prime is below 1 million
    return primes[10000] // 1st prime is at index 0, 2nd at index 1, ..., 10001st at index 10000
}
