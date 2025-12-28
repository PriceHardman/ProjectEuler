// Problem 6:
// The sum of the squares of the first ten natural numbers is 1^2 + 2^2 + ... + 10^2 = 385,
// The square of the sum of the first ten natural numbers is (1+2+...+10)^2 = 55^2 = 3025,
// Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640.
// Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

export function main(): number {
    const sum_of_squares = 100 * (100 + 1) * (2*100 + 1) / 6 // formula for sum of squares n(n+1)(2n+1)/6
    const square_of_sum = Math.pow((100 * (100 + 1) / 2),2) // formula for sum n(n+1)/2
    return square_of_sum - sum_of_squares
}
