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

italian <- read.csv("data-raw/dict-italian.csv", stringsAsFactors = FALSE)
names(italian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == italian$key))
input$IT <- italian$IT

spanish <- read.csv("data-raw/dict-spanish.csv", stringsAsFactors = FALSE)
names(spanish)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == spanish$key))
input$ES <- spanish$ES

formal_german <- read.csv("data-raw/dict-de_formal.csv", stringsAsFactors = FALSE)
names(formal_german)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == formal_german$key))
input$DE_F <- formal_german$DE_F

mpt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mpt_dict, overwrite = TRUE)
