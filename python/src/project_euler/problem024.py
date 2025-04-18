# A permutation is an ordered arrangement of objects.
# For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4.
# If all of the permutations are listed numerically or alphabetically, we call it lexicographic order.
# The lexicographic permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
import math


def main():
    perm = nth_permutation([0,1,2,3,4,5,6,7,8,9],1_000_000)
    return ''.join([str(i) for i in perm])

def nth_permutation(X,nth):
    # Given an array X of length N and integer nth <= N!, returns
    # the nth lexicographic permutation of X.
    # It does this by representing the permutations as binary tree with N layers.
    # The nodes each consist of two values: A prefix of characters and an array of remaining characters
    # capturing the fact that that branch represents all permutations starting with the prefix
    # and containing the permutations of the remaining characters.
    # For example with X=[0,1,2] we would have
    #                [0,1,2]                This is the input array, with length 3, hence 3 layers of tree below this
    #            /      |       \
    #         0|12     1|02     2|01        1st layer: 3 nodes, prefix length=1, 2!=2 permutations per branch
    #        /   \    /   \     /   \                  We know perms 0-1 on branch 1, 2-3 on 2, 4-5 on branch 3
    #     01|2  02|1 10|2 12|0 20|1 21|0    2nd layer: 3*2 = 6 nodes, prefix length=2, 1!=1 permutations per branch
    #      |     |    |    |    |    |
    #     012   021  102  120  201  210     3rd layer: 3*2*1=6 nodes, prefix length=3, final permutations
    #
    # We can use this structure to figure out which branches to traverse down to find our desired permutation.
    # For example again assume X=[0,1,2] and n=3, meaning we want to find the 4th permutation.
    # Starting at the base of the tree there are 3 branches, each with 2!=2 permutations at the bottom.
    # Branch 1 contains permutations 0 through 1, branch 2 permutations 2 through 3, and branch 3 permutations
    # 4 through 5. Thus, we want to traverse down the 2nd branch which contains permutation n=3.
    # That branch in turn splits into 2 more: The left one containing permutation 2 and the right containing
    # permutation 3. Thus we traverse down the right branch. This has only one permutation "120" so we're done.

    # Moving up to a larger example, suppose we wanted the 19th permutation of [0,1,2,3] i.e. X=[0,1,2,3],n=18
    # The first layer has 4 nodes, each with 3!=6 permutations. The 4th node has permutations 18-23, all of which
    # start with prefix "3" and the remainder comprising the permutations of [0,1,2].
    # Moving down that branch to the next layer we have 3 branches, each with 2!=2 permutations. The 1st branch
    # has permutations 18 and 19, both beginning with "30" and the remainder comprising the permutations of [1,2].
    # Traversing down there we have 2 branches, each with 1 permutation hanging off them. The left branch contains
    # 1 permutation with prefix "301" and remainder [2] so we return [3,0,1,2]

    n = nth - 1 # translate nth permutation to zero index
    X = X.copy()
    N = len(X)
    prefix = []
    remainder = X
    last_permutation_index_checked = -1 # we haven't checked any yet, and -1 prevents off by 1 errors.
    for layer in range(N):
        # Base case: reached the bottom of the tree, return the prefix
        if len(remainder) == 0:
            break
        # How many branches can we go to?
        n_branch_choices = N - layer
        permutations_in_each_branch = math.factorial(N-(layer+1))
        for i in range(n_branch_choices):
            if last_permutation_index_checked < n <= (last_permutation_index_checked + permutations_in_each_branch):
                # if this branch contains the permutation we want
                prefix.append(remainder.pop(i)) # remove the prefix from the remainder and append
                break
            else:
                # otherwise skip this branch and mark the permutations it contains as checked
                last_permutation_index_checked += permutations_in_each_branch
    return prefix












