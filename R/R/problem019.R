# Problem 19: Counting Sundays
# You are given the following information, but you may prefer to do some research for yourself.
# - 1 Jan 1900 was a Monday.
# - Thirty days has September,
#   April, June and November.
#   All the rest have thirty-one,
#   Saving February alone,
#   Which has twenty-eight, rain or shine.
#   And on leap years, twenty-nine.
# - A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

problem019 <- function(){

  # Jan 1 1900 was a monday.
  # 1900 wasn't a leap year (not divisible by 400), so Jan 1 1901 was 365 days
  # later, making it a tuesday (365 % 7 == 1, so the day of week advanced by 1).

  days <- 0 # Day 0 is Jan 1 1901, a Tuesday.

  sundays_on_the_1st <- 0

  # Start counting month by month. From here out out, any day such that day %% 7 == 5 is a sunday.
  for(year in 1901:2000){
    is_leap_year <- (year %% 4 == 0 & year %% 100 != 0) | (year %% 400 == 0)

    for(month in 1:12){

      if(days %% 7 == 5){
        sundays_on_the_1st <- sundays_on_the_1st + 1
      }

      if(month %in% c(9,4,6,11)){
        days <- days + 30
      } else if(month == 2) {
        days <- days + ifelse(is_leap_year,29,28)
      } else {
        days <- days + 31
      }
    }
  }
  sundays_on_the_1st
}
