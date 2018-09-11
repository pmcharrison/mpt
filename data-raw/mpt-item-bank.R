item_bank <- read.csv("data-raw/mpt-item-bank.csv", stringsAsFactors = FALSE)
item_bank$answer <- item_bank$which_mistuned
item_bank$difficulty <- item_bank$difficulty_with_ranef

stopifnot(is.numeric(item_bank$answer))
devtools::use_data(item_bank, overwrite = TRUE)
