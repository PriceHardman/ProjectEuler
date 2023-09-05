# Problem 18: Maximum Path Sum 1
# By starting at the top of the triangle below and moving to adjacent numbers on the row below,
# the maximum total from top to bottom is 23.
#     *3
#    *7 4
#   2 *4 6
#  8 5 *9 3
# That is, 3+7+4+9=23

# Find the maximum total from top to bottom of the triangle below:
#                    75
#                   95 64
#                 17 47 82
#                18 35 87 10
#               20 04 82 47 65
#              19 01 23 75 03 34
#             88 02 77 73 07 63 67
#           99 65 04 28 06 16 70 92
#          41 41 26 56 83 40 80 70 33
#         41 48 72 33 47 32 37 16 94 29
#       53 71 44 65 25 43 91 52 97 51 14
#     70 11 33 28 77 73 17 78 39 68 17 57
#    91 71 52 38 17 14 91 43 58 50 27 29 48
#  63 66 04 68 89 53 67 30 73 16 69 87 40 31
# 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

problem018 <- function(){
  raw_triangle <- "
  75
  95 64
  17 47 82
  18 35 87 10
  20 04 82 47 65
  19 01 23 75 03 34
  88 02 77 73 07 63 67
  99 65 04 28 06 16 70 92
  41 41 26 56 83 40 80 70 33
  41 48 72 33 47 32 37 16 94 29
  53 71 44 65 25 43 91 52 97 51 14
  70 11 33 28 77 73 17 78 39 68 17 57
  91 71 52 38 17 14 91 43 58 50 27 29 48
  63 66 04 68 89 53 67 30 73 16 69 87 40 31
  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
  "

  X <- raw_triangle %>%
    gsub("^\\s+","",.) %>% # strip leading spaces
    gsub("\\s+$","",.) %>% # strip trailing spaces
    gsub("\n +", "\n", .) %>% # remove extra interior spaces
    strsplit("\n") %>% # parse into rows
    purrr::map(\(d) strsplit(d," ")) %>% # split each row into elements
    .[[1]] %>%
    purrr::map(as.integer) # convert elements to numbers


  max_path <- function(i, j){
    # From any given starting coordinate X[[i]][j], we have two options for our next move:
    # X[[i+1]][j] or X[[i+1]][j+1]. We'll recursively try both and return whichever path has the longer
    # sum:

    # Base case, we're on row i==15, in which case simply return the current value X[[i]][j]
    if(i==length(X)){
      X[[i]][j]
    } else {
      X[[i]][j] + pmax(max_path(i+1,j),max_path(i+1,j+1))
    }
  }

  # Start from the top
  max_path(1,1)
}
