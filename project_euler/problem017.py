# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are
# 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words,
# how many letters would be used?
#
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two)
# contains 23 letters and 115 (one hundred and fifteen) contains 20 letters.
# The use of "and" when writing out numbers is in compliance with British usage.

def to_words(n: int) -> list[str]:
    # Returns integer n as a list of words (no spaces or hyphens)
    words = {
        "ones_and_teens": {
            1: "one",
            2: "two",
            3: "three",
            4: "four",
            5: "five",
            6: "six",
            7: "seven",
            8: "eight",
            9: "nine",
            10: "ten",
            11: "eleven",
            12: "twelve",
            13: "thirteen",
            14: "fourteen",
            15: "fifteen",
            16: "sixteen",
            17: "seventeen",
            18: "eighteen",
            19: "nineteen"
        },
        "tens": {
            2: "twenty",
            3: "thirty",
            4: "forty",
            5: "fifty",
            6: "sixty",
            7: "seventy",
            8: "eighty",
            9: "ninety"
        }
    }

    # Strategy: Set remaining initially equal to n, and
    # progressively use divmod to pull out the thousands place, hundreds place, etc,
    # setting remaining equal to the remainder.
    remaining = n
    output = []

    if remaining == 1000:
        return ["one", "thousand"]
    if remaining >= 100:
        hundreds_place, remaining = divmod(remaining, 100)
        output.append(words["ones_and_teens"][hundreds_place])
        output.append("hundred")
        if remaining > 0:
            output.append("and")
    if remaining >= 20:
        tens_place, remaining = divmod(remaining, 10)
        output.append(words["tens"][tens_place])
    if remaining >= 1:
        # At this point, all that remains is a number between 1 and 19, which we can
        # look up directly.
        ones_or_teens_place, remaining = divmod(remaining, 1)
        output.append(words["ones_and_teens"][ones_or_teens_place])

    return output


def problem017():
    letter_count = 0
    for n in range(1, 1001):
        for word in to_words(n):
            letter_count += len(word)
    return letter_count