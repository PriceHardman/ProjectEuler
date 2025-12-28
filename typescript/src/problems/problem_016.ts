// Problem 16:
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
// What is the sum of the digits of the number 2^1000?

export function main(): number {
    // 2^1000 is huge, so to do this we'll need to perform
    // recursive long multiplication. Let by2(X: number[]): number[] be a function
    // that multiplies a number x (represented by an array of digits, 
    // arranged naturally from largest to smallest place value) by 2 and
    // returns the digits of the product also as an array.
    // Using this by2 function we can build up our product, and then
    // simply sum the digits in the array

    // Now we'll build our answer up iteratively (call stack depth issues would likely prevent recursion here)
    function  by2(X: number[]): number[] {
        // Multiplies a number X[] (in the form of an array of single digits) by a scalar number y between 1 and 9

        const output: number[] = []
        let carry = 0
        // Starting from the ones place and moving leftward
        for(let i = X.length-1; i >= 0; i--) {
            const product = 2*X[i] + carry // multiply the digit in the ith position by 2, then add whatever carry exists
            output.push(product % 10) // Add the ones place digit of the product to the output
            carry = Math.floor(product / 10) // add any higher place digits to the carry
        }

        // At this point we might still have some carry from the multilication
        // of X[0] x 2, but the carry is at most 1 (if X[0] = 9), so if carry > 0
        // we just tack it on the end
        if(carry > 0){
            output.push(carry)
        }

        return output.reverse() // return the digits reversed into natural order (ones place last)
    }
    let answer = [1]
    for(let power = 1; power <= 1000; power++) {
        answer = by2(answer)
    }
    return answer.reduce((acc,digit) => acc += digit, 0)
}
