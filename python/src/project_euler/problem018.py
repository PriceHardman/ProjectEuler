# By starting at the top of the triangle below and moving to adjacent numbers on the row below,
# the maximum total from top to bottom is 23.
#
#    3
#   7 4
#  2 4 6
# 8 5 9 3
#
# That is, 3 + 7 + 4 + 9 = 23.
#
# Find the maximum total from top to bottom of the triangle below:
#
#                 75
#                95 64
#               17 47 82
#              18 35 87 10
#             20 04 82 47 65
#            19 01 23 75 03 34
#          88 02 77 73 07 63 67
#         99 65 04 28 06 16 70 92
#        41 41 26 56 83 40 80 70 33
#       41 48 72 33 47 32 37 16 94 29
#      53 71 44 65 25 43 91 52 97 51 14
#     70 11 33 28 77 73 17 78 39 68 17 57
#    91 71 52 38 17 14 91 43 58 50 27 29 48
#  63 66 04 68 89 53 67 30 73 16 69 87 40 31
# 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
#
# NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route.
# However, Problem 67, is the same challenge with a triangle containing one-hundred rows;
# it cannot be solved by brute force, and requires a clever method! ;o)


def maximum_path_in_triangle(triangle: list[list[int]]) -> int:
    # From position j in row i, we can traverse to either
    # position i or i+1 in row j+1
    # The key is that the maximum path from position (i, j)
    # is going to be equal to element (i,j) plus the larger
    # of the maximum paths from (i+1, j) or (i+1, j+1).
    # This means we can find the maximum path sum by starting
    # at the bottom of the triangle and for each row adding to each element (i,j)
    # the larger of the j'th and j+1'th elements in the row below it.
    # For example:
    #
    # 3           3              3          23
    # 7 4     ->  7 4        ->  20 19  ->
    # 2 4 6       10 13 15
    # 8 5 9 3
    #
    n_rows = len(triangle)
    for i in range(n_rows - 1)[::-1]:  # starting at the 2nd to last row and moving upwards
        for j in range(len(triangle[i])):  # for each element in the row
            # Update (i,j) to be equal to (i,j) + max((i+1,j),(i+1,j+1))
            if triangle[i+1][j] >= triangle[i+1][j+1]:
                triangle[i][j] = triangle[i][j] + triangle[i+1][j]
            else:
                triangle[i][j] = triangle[i][j] + triangle[i + 1][j+1]
    return triangle[0][0]  # The top of the triangle will now contain the max path sum

def main():
    triangle = [
        [75],
        [95, 64],
        [17, 47, 82],
        [18, 35, 87, 10],
        [20,  4, 82, 47, 65],
        [19,  1, 23, 75,  3, 34],
        [88,  2, 77, 73,  7, 63, 67],
        [99, 65,  4, 28,  6, 16, 70, 92],
        [41, 41, 26, 56, 83, 40, 80, 70, 33],
        [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
        [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
        [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
        [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
        [63, 66,  4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
        [ 4, 62, 98, 27, 23,  9, 70, 98, 73, 93, 38, 53, 60,  4, 23]
    ]
    return maximum_path_in_triangle(triangle)