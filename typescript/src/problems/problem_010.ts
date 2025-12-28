import * as utils from "../utils";

// Problem 10:
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
// Find the sum of all the primes below two million.

export function main(): number {
    return utils
        .primesUpTo(2_000_000)
        .reduce((total, i) => total += i, 0)
}
