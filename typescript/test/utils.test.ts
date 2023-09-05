import * as utils from "../src/utils"

describe('utils', () => {
    test('fibonacciNumbers', () => {
        let F = utils.generateFibonacciNumbers()
        
        let expected = [1,2,3,5,8,13,21]
        let actual = expected.map(() => F.next().value)
        for(let i=0; i < expected.length; i++){
            expect(actual[i]).toEqual(expected[i])
        }
    })

    test('primesUpTo', () => {
        let cases: Array<[number, Array<number>]> = [
            [1,[]],
            [2, [2]],
            [3, [2,3]],
            [4, [2,3]],
            [5, [2,3,5]],
            [6, [2,3,5]],
            [7, [2,3,5,7]],
            [8, [2,3,5,7]],
            [9, [2,3,5,7]],
            [10, [2,3,5,7]],
            [11, [2,3,5,7,11]],
            [100, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]]
        ]

        for(let [n, expected] of cases){
            let actual = utils.primesUpTo(n)
            expect(actual).toEqual(expected)
        }
    })

    test('primeFactorization', () => {
        let cases: Array<[number, Array<utils.PrimeFactor>]> = [
            [2, [{factor: 2, power: 1}]],
            [3, [{factor: 3, power: 1}]],
            [4, [{factor: 2, power: 2}]],
            [5, [{factor: 5, power: 1}]],
            [6, [{factor: 2, power: 1}, {factor: 3, power: 1}]],
            [7, [{factor: 7, power: 1}]],
            [8, [{factor: 2, power: 3}]],
            [9, [{factor: 3, power: 2}]],
            [10, [{factor: 2, power: 1}, {factor: 5, power: 1}]],
            [49, [{factor: 7, power: 2}]],
            [5558322550, [{factor: 2, power: 1},{factor: 5, power: 2},{factor: 11, power: 3},{factor: 17, power: 4}]],
        ]

        for(let [n, expected] of cases){
            let actual = utils.primeFactorization(n)
            expect(actual).toEqual(expected)
        }
    })
})