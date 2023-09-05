# Problem 17: Number letter counts.
# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115
# (one hundred and fifteen) contains 20 letters.
# The use of "and" when writing out numbers is in compliance with British usage.

problem017 <- function(){
  # For any given positive integer n in [1,1000], the written form is:
  #   1: For n=1000, "one thousand"
  #   2: For n in [100,999],
  #     a: Hundreds place: Get the digit in the hundreds place and add "hundred" to it.
  #         e.g. for n="456", for the 4 in the hundreds place we get c("four", "hundred")
  #     b: Remainder if >=20: if the remainder is 20 or above, get the name of tens place and add the digit in the ones place.
  #           e.g for n="456", for the remainder 56 we get c("fifty", "six").
  #     c: Remainder if <20: if the remainder is below 20, we can express the number directly.
  #           e.g for n=517, we turn the 17 directly into c("seventeen").
  #
  #     If either of the hundreds place or the remainder equals 0, we add nothing.

  words <- rlang::env(
    "1"="one",
    "2"="two",
    "3"="three",
    "4"="four",
    "5"="five",
    "6"="six",
    "7"="seven",
    "8"="eight",
    "9"="nine",
    "10"="ten",
    "11"="eleven",
    "12"="twelve",
    "13"="thirteen",
    "14"="fourteen",
    "15"="fifteen",
    "16"="sixteen",
    "17"="seventeen",
    "18"="eighteen",
    "19"="nineteen",
    "20"="twenty",
    "30"="thirty",
    "40"="forty",
    "50"="fifty",
    "60"="sixty",
    "70"="seventy",
    "80"="eighty",
    "90"="ninety"
  )

  to_word <- function(n){
    # base case: n==0, return an empty vector
    if(n==0){
      c()
    } else if(n < 20) {
      # Special case for n in [1,19], we know the whole word
      c(words[[as.character(n)]])
    } else if(n < 100) {
      # classic 10s place. Get the name of the tens place digit and recurse on the remainder.
      tens <- 10*floor(n/10)
      remainder <- n %% 10
      c(c(words[[as.character(tens)]]),to_word(remainder))
    } else if(n < 1000) {
      # hundreds place. Get the name of the biggest digit + "hundred" and recurse on remainder
      hundreds <- floor(n/100)
      remainder <- n %% 100
      c(words[[as.character(hundreds)]], if(remainder > 0){c("hundred", "and")} else {c("hundred")}, to_word(remainder))
    } else if(floor(log10(n)) == 3){
      # Thousands place. Get name of the biggest digit + "thousand" and recurse on remainder.
      thousands <- floor(n/1000)
      remainder <- n %% 1000
      c(words[[as.character(thousands)]],"thousand", to_word(remainder))
    }
  }

  1:1000 %>%
    purrr::map(\(n) nchar(paste(to_word(n),collapse=""))) %>%
    unlist() %>%
    sum()

}
