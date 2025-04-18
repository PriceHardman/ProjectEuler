# Problem 25: 1000-digit Fibonacci number
# The Fibonacci sequence is defined by the recurrence relation:
#   F(N) = F(N-1) + F(N-1), where F(1) = 1 and F(2) = 1
# The first terms are:
#   F(1) = 1
#   F(2) = 1
#   F(3) = 2
#   F(4) = 3
#   F(5) = 5
#   F(6) = 8
#   F(7) = 13
#   F(8) = 21
#   F(9) = 34
#   F(10) = 55
#   F(11) = 89
#   F(12) = 144

# The 12th term is the first to contain 3 digits
# What is the index of the first term to contain 1000 digits?
from project_euler.utils import big_arithmetic

def main():
    FN_2 = [1]
    FN_1 = [1]
    FN = big_arithmetic.add(FN_1,FN_2)
    N = 3
    while len(FN) < 1000:
        N += 1
        FN_2, FN_1 = FN_1, FN
        FN = big_arithmetic.add(FN_1,FN_2)
    return N

