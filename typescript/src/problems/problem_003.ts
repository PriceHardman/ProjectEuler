import * as utils from "../utils";

// Problem 3:
// The prime factors of 13195 are 5, 7, 13 and 29.
// What is the largest prime factor of the number 600851475143 ?

export function main(): number {
    const factorization = utils.primeFactorization(600851475143)
    return Math.max(...factorization.map(({factor}) => factor))
}
