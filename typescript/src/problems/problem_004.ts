
// Problem 4:
// A palindromic number reads the same both ways.
// The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
// Find the largest palindrome made from the product of two 3-digit numbers.

export function main(): number {

    function isPalindrome(n: number): boolean {
        const N = n.toString()
        const N_reverse = N.split("").reverse().join("")
        return N == N_reverse
    }

    let largestSoFar = 0
    for(let i = 1; i < 1000; i++) {
        for(let j = 1; j <= i; j++) { // only test the lower triangular region of the iXj matrix, where j <= i
            if(isPalindrome(i*j) && i*j >= largestSoFar) {
                largestSoFar = i*j
            }
        }
    }
    return largestSoFar
}
