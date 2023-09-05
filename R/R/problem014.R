# Problem 14: Longest Collatz sequence
# The following iterative sequence is defined for the set of positive integers:
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
# Using the rule above and starting with 13, we generate the following sequence:
#  13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
# Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
# Which starting number, under one million, produces the longest chain?
# NOTE: Once the chain starts the terms are allowed to go above one million.


# We can use a couple optimizations:
#   - Memoization: Caching the lengths allows us to stop early for many higher values of n.
#   - We can skip ahead 2 places for each odd number, since 3*n+1 will be even, so we go straight to (3*n+1)/2.
#   - Although depending on the


problem014 <- function() {

  # Variant 6 written in C++ is (obv) by far the fastest.
  problem014_variant6()
}

# > bench::mark(problem014_variant1())
# # A tibble: 1 × 13
#     expression                 min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory                  time           gc
#     <bch:expr>            <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>                  <list>         <list>
#   1 problem014_variant1()    4.84s    4.84s     0.207    90.3MB     34.1     1   165      4.84s <int [1]> <Rprofmem [17,728 × 3]> <bench_tm [1]> <tibble>
problem014_variant1 <- function() {
  # chain_length(n) for odd n = 1 + chain_length(3n+1) where 3n+1 is even = 2 + chain_length((3n+1)/2)
  # chain_length(n) for even n = 1 + chain_length(n/2), so chain_length(2n) > chain_length(n) for all n,
  # meaning we need only search for n=500000-999999.

  cache <- vector("numeric", 500000)
  n_with_longest <- 0
  longest_length <- 0

  for(n in 500000:999999){

    l <- 1
    i <- n
    while(i > 1){
      # If we already know the length of i's chain, break
      cache_value <- cache[i]
      if(cache_value > 0 & !is.na(cache_value)){
        l <- l + cache_value - 1 # minus 1 because we're already at i, and don't want to count it twice.
        break
      } else {
        if(i %% 2 == 0){
          l <- l + 1
          i <- i / 2
        } else {
          l <- l + 2
          i <- (3*i+1)/2
        }
      }
    }

    # Update our running tally if we've found a new longest chain
    if(l > longest_length){
      longest_length <- l
      n_with_longest <- n
    }

    # Update the cache with our new datapoint
    cache[n] <- l
  }
  n_with_longest
}


# > bench::mark(problem014_variant2())
# # A tibble: 1 × 13
#      expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory     time           gc
#     <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>     <list>         <list>
#   1 problem014_variant2()    17.3s    17.3s    0.0578    42.1GB     78.8     1  1364      17.3s <dbl [1]> <Rprofmem> <bench_tm [1]> <tibble>
problem014_variant2 <- function() {
  # Vectorized, without memoization.

  X <- 500000:999999 # values whose chain lengths we want to compute
  C <- vector("numeric", length(X)) + 1 # running tally of chain lengths

  while(!all(X == 1)){
    # Update counts, ignoring those that have already been reduced to 1.
    C <- ifelse(X == 1, C, ifelse(X %% 2 == 0, C + 1, C + 2))
    X <- ifelse(X == 1, X, ifelse(X %% 2 == 0, X / 2, (3 * X + 1) / 2))
  }
  which.max(C) + 499999
}

# > bench::mark(problem014_variant3())
# # A tibble: 1 × 13
#     expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory                  time           gc
#       <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>                  <list>         <list>
#   1 problem014_variant3()    27.3s    27.3s    0.0366      63GB     48.2     1  1315      27.3s <dbl [1]> <Rprofmem [26,340 × 3]> <bench_tm [1]> <tibble>
problem014_variant3 <- function() {
  # Vectorized and memoized, but still slow

  lower <- 500000
  upper <- 999999

  X <- lower:upper # values whose chain lengths we want to compute
  C <- vector("numeric", length(X)) + 1 # running tally of chain lengths
  cache <- vector("numeric", length(X)) # cache of stored finished chain lengths
  while(!all(X == 1)){
    # On any given iteration of the loop:
    # X[i] is the current value in the chain originating with i + lower - 1
    # C[i] is the current length of the chain originating with i + lower - 1
    # cache[i] is either 0 (for uncompleted chains) or the total length of the chain
    # originating with i + lower - 1.

    # In order to check for cached values, we'll have to perform an index translation.
    # For example, suppose lower=3 (i.e. we start measuring chain lengths at n=3), and
    # we're 4 iterations into measuring the chain for n=5 (i.e. we've gone 5 -> 16 -> 8 -> 4).
    # At this point, we already would have cached the chain length for n=4 but its at cache index i=lower+1=2.
    # In order to know that cache[2] really stores the value for chain_length(n=4), we must translate our
    # X values (the current counts) downward by (lower - 1). This could introduce indices < 1 though, so we'll
    # make sure to replace those with NA (i.e. we'll never be able to cache the lengths of chains for n < lower).
    translated_X <- X - (lower - 1)
    translated_X[translated_X < 1] <- NA
    is_done <- X == 1
    has_cached_value <- cache[translated_X] > 0 & !is.na(cache[translated_X])
    is_even <- X %% 2 == 0

    C <- ifelse(
      is_done,
      C,
      ifelse(
        has_cached_value,
        C + cache[translated_X] - 1,
        ifelse(is_even, C + 1, C + 2)
      )
    )
    X <- ifelse(
      is_done,
      X,
      ifelse(
        has_cached_value,
        1,
        ifelse(is_even, X / 2, (3 * X + 1) / 2)
      )
    )

    # Update the cache
    cache[which(X==1)] <- C[X==1]
  }
  which.max(C) + lower - 1
}


# > bench::mark(problem014_variant4())
# # A tibble: 1 × 13
#     expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory                  time           gc
#     <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>                  <list>         <list>
#   1 problem014_variant4()    23.8s    23.8s    0.0421      71MB    0.378     1     9      23.8s <int [1]> <Rprofmem [99,796 × 3]> <bench_tm [1]> <tibble [1 × 3]>
problem014_variant4 <- function(){

  cache <- rlang::env("1" = 1)

  chain_length <- function(n){
    cached_value <- cache[[as.character(n)]]
    if(!is.null(cached_value)){
      return(cached_value)
    } else if(n %% 2 == 0){
      cache[[as.character(n)]] <- 1 + chain_length(n/2)
    } else {
      cache[[as.character(n)]] <- 2 + chain_length((3*n+1)/2)
    }
    return(cache[[as.character(n)]])
  }

  longest <- 0
  n_with_longest <- 0
  for(n in 500000:999999){
    l <- chain_length(n)
    if(l > longest){
      longest <- l
      n_with_longest <- n
    }
  }
  n_with_longest
}


# > bench::mark(problem014_variant5())
# # A tibble: 1 × 13
#      expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory                   time           gc
#      <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>                   <list>         <list>
#   1 problem014_variant5()    5.57s    5.57s     0.179    1.19GB     3.95     1    22      5.57s <dbl [1]> <Rprofmem [500,039 × 3]> <bench_tm [1]> <tibble [1 × 3]>
problem014_variant5 <- function(){
  # Admit defeat and use C++ :(

  Rcpp::cppFunction('int chain_length(unsigned int n) {
    int count = 1;
    while(n > 1) {
      if(n % 2 == 0){
        n = n / 2;
        count += 1;
      } else {
        n = (3*n+1)/2;
        count += 2;
      }
    }
    return count;
  }')

  which.max(vapply(500000:999999, chain_length, numeric(1))) + 499999
}

# # A tibble: 1 × 13
#      expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory              time           gc
#      <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>              <list>         <list>
#   1 problem014_variant6()   96.4ms   97.5ms      10.2      28KB        0     6     0      587ms <int [1]> <Rprofmem [22 × 3]> <bench_tm [6]> <tibble [6 × 3]>
problem014_variant6 <- function(){
  # C++ with memoization.
  Rcpp::cppFunction('
#include <unordered_map>

int problem014_cpp() {
    std::unordered_map<unsigned int, int> cache;

    int longest = 0;
    int n_with_longest = 0;

    for(int n = 1; n < 1000000; n++){
      int length = 1;
      unsigned int i = n;
      while(i > 1){
        if(cache.count(i) > 0){
          length += (cache[i] - 1);
          break;
        } else if(i%2==0){
          length += 1;
          i = i/2;
        } else {
          length += 2;
          i = (3*i+1)/2;
        }
      }
      cache[n] = length;

      if(length > longest){
        longest = length;
        n_with_longest = n;
      }
    }
    return n_with_longest;
}')

  problem014_cpp()
}


