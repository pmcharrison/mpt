input <- readr::read_csv("data-raw/mpt-dict.csv")
names(input)[[1]] <- "key"

russian <- readr::read_csv("data-raw/dict-russian.csv")
names(russian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == russian$key))
input$RU <- russian$RU

dutch <- readr::read_csv("data-raw/dict-dutch.csv")
names(dutch)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == dutch$key))
input$NL <- dutch$NL

italian <- readr::read_csv("data-raw/dict-italian.csv")
names(italian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == italian$key))
input$IT <- italian$IT

de_formal <- readr::read_csv("data-raw/dict-de_formal.csv")
names(de_formal)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == de_formal$key))
input$DE_F <- de_formal$DE_F

mpt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mpt_dict, overwrite = TRUE)
