# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.

def main():
    largest_so_far = 0
    for i in range(100,1000):
        for j in range(100, 1000):
            if is_palindrome(i*j) and i*j > largest_so_far:
                largest_so_far = i*j
    return largest_so_far

def is_palindrome(n):
    s = str(n)
    return s == s[::-1]