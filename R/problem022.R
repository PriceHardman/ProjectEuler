# Problem 22: Names scores
#Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names,
# begin by sorting it into alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a name score.
#For example, when the list is sorted into alphabetical order, COLIN,
# which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list.
# So, COLIN would obtain a score of 938 × 53 = 49714.
# What is the total of all the name scores in the file?

problem022 <- function(){

  #

  scan(
      file=paste(usethis::proj_path(),"/data/problem022_names.txt",sep=""),
      sep=",",
      what="character",
      na.strings = c(),
      quiet = TRUE) %>%
    tibble(name=.) %>%
    arrange(name) %>%
    mutate(
      name_rank = row_number()
    ) %>%
    rowwise() %>%
    mutate(
      name_value = sum(utf8ToInt(name) - 64), # utf8ToInt returns vector of decimal utf8 code of characters. A = 65, so offset by 64.
      score = name_rank * name_value
    ) %>%
    ungroup() %>%
    summarise(total=sum(score)) %>%
    pull()
}
