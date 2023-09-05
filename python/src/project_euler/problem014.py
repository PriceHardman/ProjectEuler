# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1)
# contains 10 terms. Although it has not been proved yet (Collatz Problem),
# it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.

def main():
    # We'll calculate the length l(n) of the chains from n=1 to n=1000000,
    # but to speed it up use memoization, where we cache each l(n)
    # in a dict so that when we come across some intermediate m < n,
    # we can rely on the cached value.
    chains = {}
    n_with_longest, longest_chain = 0, 0
    for n in range(1, 1_000_000):
        m = n
        length_of_chain_n = 1
        while m > 1:  # calculate the length of chain n, using cached values if we have them
            if m in chains:
                length_of_chain_n = chains[m] + length_of_chain_n
                chains[n] = length_of_chain_n
                break
            else:
                if m % 2 == 0:
                    m = int(m/2)
                else:
                    m = 3*m+1
                length_of_chain_n += 1
            chains[n] = length_of_chain_n
        if length_of_chain_n > longest_chain:
            n_with_longest, longest_chain = n, length_of_chain_n

    return n_with_longest



