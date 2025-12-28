// Problem 5:
// 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
// What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

// We can solve this one analytically:

// Let our answer be an integer N with prime factorization p1^e1 * p2^e2 * ... = (p1*p1*...) * (p2*p2*...) * ...
// For N to evenly divide all the numbers from 1 to 20, its prime factorization must contain factors that can be
// used to construct all the numbers from 1 to 20. The primes themselves will be the primes below 20 (2,3,5,7,11,13,17,19).
// N is therefore N = 2^e1 * 3^e2 * 5^e3 * 7^e4 * 11^e5 * 13^e6 * 17^e7 * 19^e8, and our task then is simply to figure out the
// smallest set of exponents [e1, ..., e8] that allow us to construct 2-20 using the factors.
// Visually we can do this using the grid below. The columns are the 8 prime factors below 20. The rows are the prime factorizations
// of the numbers from 1 to 20, where the entries in the grid are the power of each given prime factor.
// If we take the maximum value of each column, that gives us our powers for the prime factors of N.

//   Powers of prime factors required to
//   generate all the numbers from 2 to 20
//
//             Prime Factors below 20
//          2  3   5   7   11  13  17  19
// Number
//   2      1
//   3         1
//   4      2
//   5             1
//   6      1  1
//   7                 1
//   8      3
//   9         2
//  10      1       1
//  11                     1
//  12      2  1
//  13                         1
//  14      1          1
//  15         1   1
//  16      4
//  17                              1
//  18      1  2
//  19                                  1
//  20      2      1
//  ----------------------------------------
// col max: 4  2   1   1    1   1   1   1

// => N = 2^4 * 3^2 * 5^1 * 7^1 * 11^1 * 13^1 * 17^1 * 19^1
//      = (2*2*2*2)*(3*3)*5*7*11*13*17*19
//      = 232792560


export function main(): number {
    return 232792560
}
