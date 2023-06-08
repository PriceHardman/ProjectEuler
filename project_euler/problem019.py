# You are given the following information, but you may prefer to do some research for yourself.
#
# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

def problem019():
    n_first_month_sundays = 0  # We'll increment this to keep track
    day_of_week = 0  # We'll increment this mod 7 every day. 0 == monday, ..., 6 == sunday
    for year in range(1900, 2001):

        # Determine if this is a leap year
        is_leap_year = False
        if year % 100 == 0:  # if a century, its only a leap year if its divisible by 400
            is_leap_year = (year % 400 == 0)
        else:
            is_leap_year = (year % 4 == 0)

        for month in range(1, 13):

            # Figure out how many days are in this month
            n_days_in_month = 31
            if month in [4, 6, 9, 11]:
                n_days_in_month = 30
            if month == 2:
                if is_leap_year:
                    n_days_in_month = 29
                else:
                    n_days_in_month = 28

            for day_of_month in range(1, n_days_in_month + 1):

                if (year >= 1901) and (year <= 2000) and (day_of_month == 1) and (day_of_week == 6):
                    n_first_month_sundays += 1

                # increment the day of the week mod 7
                day_of_week = (day_of_week + 1) % 7

    return n_first_month_sundays
