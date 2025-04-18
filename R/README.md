
# EulR

<!-- badges: start -->
<!-- badges: end -->

Project Euler in R.

Created using `usethis::create_package()`, as well as other `usethis` helpers as described in 
[R Packages, 2nd Edition](https://r-pkgs.org/whole-game.html).


### Running Tests
Run `testthat` unit tests by calling `test()`. Individual test files can be run by calling `test_file()` in an R REPL:
```r
library(devtools)
test_file("tests/testthat/test-problem001.R")
```

### Development Cycle
Source `devtools`, load package with `load_all()`, run desired function in R REPL, edit code, reload with `load_all()`, run code. Rinse, repeat.

-Optional: Use the debugger in RStudio, or use [profvis](http://rstudio.github.io/profvis/)




