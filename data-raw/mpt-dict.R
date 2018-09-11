input <- read.csv("data-raw/mpt-dict.csv", stringsAsFactors = FALSE)
names(input)[[1]] <- "key"

mpt_dict <- psychTestR::i18n_dict$new(input)
devtools::use_data(mpt_dict, overwrite = TRUE)
