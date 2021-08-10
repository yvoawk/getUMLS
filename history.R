usethis::use_mit_license("Yvon K. AWUKLU")

usethis::use_package('magrittr')
usethis::use_package('dplyr')
usethis::use_package('stringr')
usethis::use_package('httr')
usethis::use_package('jsonlite')
usethis::use_package('rvest')

usethis::use_build_ignore('history.R')
usethis::use_build_ignore('./inst/key')
usethis::use_build_ignore('./vignettes/vignette.Rmd')

key <- readLines("./inst/key")
vocab <- utils::read.delim2("./inst/vocabulary.tsv", sep = "\t", stringsAsFactors = FALSE, encoding = "UTF-8")$Abbreviation

usethis::use_data(key, vocab, internal = TRUE)
