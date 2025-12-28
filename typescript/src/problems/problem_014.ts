// Problem 14:
// The following iterative sequence is defined for the set of positive integers:
// n → n/2 (n is even)
// n → 3n + 1 (n is odd)

// Using the rule above and starting with 13, we generate the following sequence:
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
// It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
// Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

// Which starting number, under one million, produces the longest chain?

// NOTE: Once the chain starts the terms are allowed to go above one million.

export function main(): number {
    let longest_so_far = 0
    let length_of_longest_so_far = 0
    for(let n = 2; n < 1_000_000; n++) {
        let length = 0
        let i = n
        while(i > 1) {
            if(i % 2 == 0) {
                i /= 2
            } else {
                i = 3*i+1
            }
            length += 1
        }

        if(length >= length_of_longest_so_far) {
            longest_so_far = n
            length_of_longest_so_far = length
        }
    }
    return longest_so_far
}
