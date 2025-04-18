# Several problems involve performing basic arithmetic (e.g. addition) on very large numbers
# Here we'll implement some functions for that

def add(X: list[int],Y: list[int]) -> list[int]:
    # Given two lists representing the digits of two integers
    # in natural (little endian) format, returns a list containing
    # the digits of their sum
    # example: 4982 + 67 = 5049
    # x = [4,9,8,2], y = [6,7]
    # output is [5,0,4,9]
    # We'll use these as the example in the comments

    # First step, pad both numbers with zeros so they're the same length
    length = max(len(X),len(Y)) # length = 4
    X = [0 for _ in range(length - len(X))] + X # X = [4,9,8,2]
    Y = [0 for _ in range(length - len(Y))] + Y # Y = [0,0,6,7]

    output = [] # store the output
    carry = 0 # track the carry in each digit place

    # reverse the lists into big-endian format, so we can append
    # instead of prepend as we carry
    X,Y = X[::-1], Y[::-1] # X,Y = [2,8,9,4], [7,9,0,0]
    for i in range(length):
        total = X[i] + Y[i] + carry
        (carry,digit) = divmod(total,10)
        output.append(digit)

    while carry > 0:
        (carry, digit) = divmod(carry,10)
        output.append(digit)

    # Return the output reversed back to natural little endian format
    return output[::-1]
