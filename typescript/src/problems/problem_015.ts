// Problem 15:
// Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down,
// there are exactly 6 routes to the bottom right corner.
// [R, R, D, D],
// [R, D, R, D],
// [R, D, D, R],
// [D, R, R, D],
// [D, R, D, R],
// [D, D, R, R],
// How many such routes are there through a 20×20 grid?

export function main(): number {
    // We can solve this analytically:

    // We can think of this combinatorically as: Given 4 (i.e. 2x2) positions, how many ways can we arrange
    // the 2 right (R) moves (with the understanding that the gaps will be filled by the D moves)?
    // Or even more concisely, how many combinations can we create using 2 objects and 4 positions?
    // The answer is simply 4 choose 2 = 4!/(2!*(4-2)!) = 4! / (2!*2!) = 24 / 4 = 6

    // So for the 20x20 case, it would be 40!/(20!*20!) = 137846528820

    function factorial(n: number): number {
        let total = 1
        for(let i = 1; i <= n; i++){
            total *= i
        }
        return total
    }

    return factorial(40) / (factorial(20)*factorial(20))
}
