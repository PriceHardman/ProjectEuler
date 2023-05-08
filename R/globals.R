# For suppressing devtools:check() warnings when using . as a
# reference to passed data when piping with dplyr.
utils::globalVariables(c("."))
