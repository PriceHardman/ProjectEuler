# Problem 16: Power digit sum
# 2^15 = 32768 and the sum of its digits is 3+2+7+6+8=26.
# Whats the sum of the digits of the number 2^1000?

problem016 <- function(){
  # 2^1000 is a very big number, so we'll iteratively perform long multiplication
  # to build up our answer.
  by2 <- function(N){
    # Given a vector N containing the decimal digits of a number n arranged in natural
    # base-10 positional notation with the largest digit first (e.g. 32768 -> c(3,2,7,6,8)).
    # This function performs long multiplication to multiply the number by 2, returning
    # a new vector of the output digits.

    output <- c()
    carry <- 0
    for(i in length(N):1){ # starting at the smallest digit of N
      # Multiply by 2 and add any carry from previous iterations.
      product <- N[i] * 2 + carry
      digit <- product %% 10
      carry <- floor(product / 10)
      output <- c(output,digit)
    }
    if(carry > 0){
      # add any remaining carry to the end. The carry will never be more than 9 since we're multiplying only by 2.
      output <- c(output,carry)
    }

    rev(output)
  }

  total <- c(1)
  for(power in 1:1000){
    total <- by2(total)
  }
  sum(total)
}
