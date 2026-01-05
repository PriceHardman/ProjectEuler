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
    return method2()
}

export function method1(): number {
    // Simple brute force (slow)
    let longest_so_far = 0
    let length_of_longest_so_far = 0
    for(let n = 2; n < 1_000_000; n++) {
        let length = 1
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

export function method2(): number {
    // Try again, but this time with memoization. This is over 2x faster.
    // As we calculate the length H(n) of each hailstone sequence starting with n=2,
    // we'll store each result in a lookup object. Then while calculating each chain length,
    // at each iteration of each chain we'll check if we've already calculated the length
    // from here onwards, in which case add it to the already-calculated length and store the
    // result
    const lengths: Record<number, number> = {}
    let longest_so_far = 0
    let length_of_longest_so_far = 0
    for(let n = 2; n < 1_000_000; n++) {
        let length = 1
        let i = n
        while(i > 1) {
            // Lookup if we already know the length from here on out.
            if(i in lengths) {
                // Why lengths[i]-1? Otherwise we double count.
                // Example: For H(n=3) we have sequence 3,10,5,16,8,4,2,1
                // with length H(3)=8. Having already calculated H(2)=2,
                // when i=2 we'll have already traversed 3->10->5->16->8->4->2 and
                // so the length variable will equal 7. Thus we want to do length += (2-1)

                length += (lengths[i] - 1) //
                break
            }
            if(i % 2 == 0) {
                i /= 2
            } else {
                i = 3*i+1
            }
            length += 1
        }

        // Add the length of this chain to the lookup table
        lengths[n] = length

        if(length >= length_of_longest_so_far) {
            longest_so_far = n
            length_of_longest_so_far = length
        }
    }
    return longest_so_far
}
