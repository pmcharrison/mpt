input <- read.csv("data-raw/mpt-dict.csv", stringsAsFactors = FALSE)
names(input)[[1]] <- "key"

russian <- read.csv("data-raw/dict-russian.csv", stringsAsFactors = FALSE)
names(russian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == russian$key))
input$RU <- russian$RU

dutch <- read.csv("data-raw/dict-dutch.csv", stringsAsFactors = FALSE)
names(dutch)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == dutch$key))
input$NL <- dutch$NL

mpt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mpt_dict, overwrite = TRUE)
