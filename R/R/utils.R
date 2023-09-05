# Utility functions


primes_up_to_n <- function(n) {
  # Generate a vector of all the primes up to n
  # using the Sieve of Erathosthenes

  if(n < 2){
    return(c())
  }

  if(n == 2){
    return(c(2))
  }

  # We make use of 4 optimizations:
  # - All odd numbers except 2 can safely be ignored.
  # - For a given prime p, we can start eliminating multiples starting at p^2, and moving in increments of 2p.
  # - We stop when p > sqrt(n), since any composite number x > sqrt(n)  needing elimination would necessarily
  #   have to have a factor less than sqrt(n), and so would already have been eliminated.
  # - We use odd-numbered indexing, where the indices i=1:N of our array A correspond to the odd numbers 2*i+1,
  #   so the 1st element A[1] corresponds to 3, A[2] to 5, A[3] to 7, etc. This saves on space and time considerably,
  #   but makes things a bit more confusing.

  # We'll use lower-case variables to denote untranslated integer values and upper case for their corresponding
  # values mapped into odd-indexed space (e.g. a prime candidate p=7 will correspond to P=3 in our odd-indexed array).

  # How big should we make our odd-index array A?
  # We want the last index N to correspond to the biggest odd number less than or equal to n, hence
  # 2*N+1 = n => N = (n-1)/2. That makes our stopping condition also when (p-1)/2 = P > floor(sqrt(n)-1/2)

  # Our boolean array corresponding to the (n-1)/2 odd numbers from 3:n
  A <- rep(TRUE, (n-1)/2)
  N <- floor((n-1)/2)
  for(P in 1:((sqrt(n)-1)/2)){
    # for P=1, that corresponds to p = 2*P+1 = 3.
    # In a normal-indexed array, we'd start by crossing out p^2 = 9, and then continue
    # crossing out odd multiples of p=3 by moving in steps of size 2p=6: 9, 15, 21, 27, 33, ...
    # But here we start at index P = (p^2-1)/2 = (9-1)/2 = 4, and then then move in steps of size p=3 instead of 2p=6.
    # Hence in our first pass we want to remove indices P=c(4,7,10,13,...,) = seq(4,N,3) = seq((p*p-1)/2,N,p).
    # But for small n, say n=3, then N=1 and so (p^2-1)/2 > N. We'll continue the loop in this case.
    p <- 2*P+1
    if((p*p-1)/2 > N){
      next
    }
    p <- 2*P+1
    A[seq((p*p-1)/2,N,p)] <- FALSE
  }
  c(2,2*which(A)+1)
}


prime_factorization <- function(n, primes_cache = NULL) {
  # Factors a positive integer n into a product of powers of primes: n = p1^e1 * p2^e2 * ... * pi^ei

  # Keep track of the factors and exponents we find. We'll convert to a dataframe at the end.
  factorization <- list()
  n_factors_found <- 0

  # We'll reassign n to a new variable N, which we'll successively factorize until it reaches 1
  N <- n
  list_of_primes <- if(is.null(primes_cache)) primes_up_to_n(pmin(n,10000)) else primes_cache # list of possible prime factors.

  # The largest possible prime factor of any integer n is n (in the case of n itself being prime).
  # We'll decompose n into its prime factors (and their powers) by iterating upwards through all
  # the primes up to n (although in practice we'll limit ourselves to the first ten thousand primes,
  # throwing an error if that isn't sufficient to fully factor n), performing trial division as we go.
  for(p in list_of_primes) {

    # If p divides n, keep dividing to find the exponent
    if(N %% p == 0){
      N <- N / p
      e <- 1
      while(N %% p == 0) {
        N <- N / p
        e <- e + 1
      }

      n_factors_found <- n_factors_found + 1
      factorization[[n_factors_found]] <- c(p,e)

      if(N == 1){
        break
      }
    }
  }
  # Return our completed factorization
  as.data.frame(do.call(rbind,factorization)) %>%
    `colnames<-`(c("prime_factor", "exponent"))
}
