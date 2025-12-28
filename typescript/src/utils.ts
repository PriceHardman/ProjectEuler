export function range(a: number, b: number): Array<number> {
    const output = [a]
    for(let i = a+1; i <= b; i++) {
        output.push(i)
    }
    return output
}

export function* generateFibonacciNumbers(): Generator<number> {
    // Generates an infinite sequence of fibonacci numbers
    let f2 = 0
    let f1 = 1
    while(true) {
        const f: number = f2 + f1
        yield f
        f2 = f1
        f1 = f
    }
}

export function primesUpTo(n: number): Array<number> {
    // Use the sieve of Eratosthenes to generate an array of primes up to integer n
    
    // Start with a list of n booleans, all set to true except for 0 and 1
    const A = range(0,n).map(() => true)
    A[0] = false
    A[1] = false

    // For every i=2..sqrt(n)
    for(let i = 2; i <= Math.sqrt(n); i++) {
        // if A[i] = true, then mark all j=i^2, i^2 + i, i^2 + 2i, ..., n to false
        if(A[i]){
            for(let j = i*i; j <= n; j += i) {
                A[j] = false
            }
        }
    }

    return range(2,n).filter(i => A[i]) // Finally, return all integers i where A[i] is true
}

export interface PrimeFactor {
    factor: number,
    power: number
}

export function primeFactorization(n: number, precomputed_primes?: number[]): Array<PrimeFactor> {
    // Factors positive integer n into a product of powers of primes n = p1^e1 * p2^e2 ... pi^ei

    const output = Array<PrimeFactor>()

    // The largest possible prime factor of any integer n is n (in the case of n itself being prime).
    // We'll decompose n into its prime factors (and their powers) by iterating upwards through all
    // the primes up to n (although in practice we'll limit ourselves to the first ten million primes, 
    // throwing an error if that isn't sufficient to fully factor n), performing trial division as we go.
    let N = n
    // We'll use a precomputed list of primes if needed
    const list_of_primes = precomputed_primes !== undefined ? precomputed_primes : primesUpTo(Math.min(n, 1_000_000))
    for(const p of list_of_primes){
        if(N % p == 0){
            // If p divides N, keep dividing N by p to see how many powers of p divide N. 
            // Once we can't divide any more, record it in the output
            N /= p
            let e = 1
            while(N % p == 0) {
                N /= p
                e += 1
            }
            output.push({factor:p, power: e})
        }
        if(N == 1) {
            break
        }
    }
    if(N > 1) {
        throw(new Error(`primeFactorization(n=${n}) threw an error because n is too large`))
    }

    return output
}

// export function numberToWord(n: number): string {
//     // Given a positive integer n <= 1000
//     const words = {
//         1: "one",
//         2: "two",
//         3: "three",
//         4: "four",
//         5: "five",
//         6: "six", 
//         7: "seven",
//         8: "eight",
//         9: "nine",
//         10: "ten",
//         11: "eleven",
//         12: "twelve",
//         13: "thirteen",
//         14: "fourteen",
//         15: "fifteen",
//         16: "sixteen",
//         17: "seventeen",
//         18: "eighteen",
//         19: "nineteen",
//         20: "twenty",
//         30: "thirty",
//         40: "forty",
//         50: "fifty",
//         60: "sixty",
//         70: "seventy",
//         80: "eighty",
//         90: "ninety"
//     }
// }
