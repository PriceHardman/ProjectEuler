//import {describe, expect, test} from '@jest/globals'
import * as p_1_10 from '../src/problems_1_thru_10'
import * as p_11_20 from '../src/problems_11_thru_20'

describe('problems', () => {
    test('problem001', () => {
        expect(p_1_10.problem001()).toBe(233168)
    })
    test('problem002', () => {
        expect(p_1_10.problem002()).toBe(4613732)
    })
    test('problem003', () => {
        expect(p_1_10.problem003()).toBe(6857)
    })
    test('problem004', () => {
        expect(p_1_10.problem004()).toBe(906609)
    })
    test('problem005', () => {
        expect(p_1_10.problem005()).toBe(232792560)
    })
    test('problem006', () => {
        expect(p_1_10.problem006()).toBe(25164150)
    })
    test('problem007', () => {
        expect(p_1_10.problem007()).toBe(104743)
    })
    test('problem008', () => {
        expect(p_1_10.problem008()).toBe(23514624000)
    })
    test('problem009', () => {
        expect(p_1_10.problem009()).toBe(31875000)
    })
    test('problem010', () => {
        expect(p_1_10.problem010()).toBe(142913828922)
    })
    test('problem011', () => {
        expect(p_11_20.problem011()).toBe(70600674)
    })
    test('problem012', () => {
        expect(p_11_20.problem012()).toBe(76576500)
    })
    test('problem013', () => {
        expect(p_11_20.problem013()).toBe(5537376230)
    })
    test('problem014', () => {
        expect(p_11_20.problem014()).toBe(837799)
    })
    test('problem015', () => {
        expect(p_11_20.problem015()).toBe(137846528820)
    })
    test('problem016', () => {
        expect(p_11_20.problem016()).toBe(1366)
    })
})
