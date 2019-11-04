test_that("dictionary regression tests", {
  sanitise <- function(x) {
    gsub(" </p>", "</p>", x, fixed = TRUE)
  }

  test_dict <- function(old, languages, ignore = character()) {
    filter <- function(df, ignore) {
      df[!df$key %in% ignore, ]
    }
    old_1 <- local({
      env <- new.env()
      load(system.file(old, package = "mpt", mustWork = TRUE),
           envir = env)
      filter(as.data.frame(env$mpt_dict), ignore)
    })
    current <- filter(as.data.frame(mpt::mpt_dict), ignore)
    for (l in c("key", languages)) {
      expect_equal(sanitise(old_1[[l]]),
                   sanitise(current[[l]]))
    }
  }

  test_dict("regression-tests/dictionaries/dict-may-2019.rda",
            c("DE", "EN", "FR", "RU"),
            ignore = c("AMPT_0004_I_0001_1", "demo_intro", "click_here_to_play"))

  test_dict("regression-tests/dictionaries/dict-nov-2019.rda",
            c("DE", "EN", "FR", "RU", "DA"))
})
