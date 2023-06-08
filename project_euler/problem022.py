# Using resources/problem022_input.txt, a 46K text file containing over five-thousand first names,
# begin by sorting it into alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list.
# So, COLIN would obtain a score of 938 × 53 = 49714.
#
# What is the total of all the name scores in the file?

from importlib.resources import files


def problem022():
    raw_names = files("project_euler.resources").joinpath("problem022_input.txt").read_text()  # '"MARY","PATRICIA",...'
    names = sorted([raw_name.strip('"') for raw_name in raw_names.split(",")])  # ["AARON", "ABBEY", ...]

    output = 0

    for i, name in enumerate(names):
        position = i + 1
        letter_values = [ord(letter) - 64 for letter in name]
        output += position * sum(letter_values)

    return output
