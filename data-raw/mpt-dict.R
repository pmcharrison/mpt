input <- read.csv("data-raw/mpt-dict.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(input)[[1]] <- "key"

russian <- read.csv("data-raw/dict-russian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(russian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == russian$key))
input$RU <- russian$RU

dutch <- read.csv("data-raw/dict-dutch.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(dutch)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == dutch$key))
input$NL <- dutch$NL

italian <- read.csv("data-raw/dict-italian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(italian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == italian$key))
input$IT <- italian$IT

spanish <- read.csv("data-raw/dict-spanish.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(spanish)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == spanish$key))
input$ES <- spanish$ES

formal_german <- read.csv("data-raw/dict-de_formal.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(formal_german)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == formal_german$key))
input$DE_F <- formal_german$DE_F

latvian <- read.csv("data-raw/dict-latvian.csv", stringsAsFactors = FALSE)
names(latvian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == latvian$key))
input$LV <- latvian$LV

portuguese <- read.csv("data-raw/dict-portuguese.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(portuguese)[[1]] <- "key"
stopifnot(all(input$key == portuguese$key))
input$PT <- portuguese$PT

mpt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mpt_dict, overwrite = TRUE)
