import {suite, add, cycle, complete} from "benny";
import * as problem001 from "../src/problems/problem_001";
import * as problem002 from "../src/problems/problem_002";
import * as problem003 from "../src/problems/problem_003";
import * as problem004 from "../src/problems/problem_004";
import * as problem005 from "../src/problems/problem_005";
import * as problem006 from "../src/problems/problem_006";
import * as problem007 from "../src/problems/problem_007";
import * as problem008 from "../src/problems/problem_008";
import * as problem009 from "../src/problems/problem_009";
import * as problem010 from "../src/problems/problem_010";
import * as problem011 from "../src/problems/problem_011";
import * as problem012 from "../src/problems/problem_012";
import * as problem013 from "../src/problems/problem_013";
import * as problem014 from "../src/problems/problem_014";
import * as problem015 from "../src/problems/problem_015";
import * as problem016 from "../src/problems/problem_016";

// TODO: DRY this up with automatic dynamic imports and parameterized benchmarks, if possible

const options = {
    minSamples: 5,
    maxTime: 2, // seconds
}

suite(
    'Benchmark Problem Solutions',
    add('problem 1', () => problem001.main(), options),
    add('problem 2', () => problem002.main(), options),
    add('problem 3', () => problem003.main(), options),
    add('problem 4', () => problem004.main(), options),
    add('problem 5', () => problem005.main(), options),
    add('problem 6', () => problem006.main(), options),
    add('problem 7', () => problem007.main(), options),
    add('problem 8', () => problem008.main(), options),
    add('problem 9', () => problem009.main(), options),
    add('problem 10', () => problem010.main(), options),
    add('problem 11', () => problem011.main(), options),
    add('problem 12', () => problem012.main(), options),
    add('problem 13', () => problem013.main(), options),
    add('problem 14', () => problem014.main(), options),
    add('problem 15', () => problem015.main(), options),
    add('problem 16', () => problem016.main(), options),
    cycle(),
    complete(),
)
