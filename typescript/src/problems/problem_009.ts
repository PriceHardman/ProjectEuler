// Problem 9:
// A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a^2 + b^2 = c^2
// For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

// There exists exactly one Pythagorean triplet for which a + b + c = 1000.
// Find the product abc.

export function main(): number {
    let output = 0
    loop_c:
        for(let c = 1; c < 1000; c++){
            for(let b = 1; b < c; b++) {
                for(let a = 1; a < b; a++) {
                    if(a*a + b*b == c*c && a + b + c == 1000){
                        output = a*b*c
                        break loop_c
                    }
                }
            }
        }
    return output
}
