test_that("dictionary regression tests", {
  test_dict <- function(old, languages) {
    old_1 <- local({
      env <- new.env()
      load(system.file(old, package = "mpt", mustWork = TRUE),
           envir = env)
      as.data.frame(env$mpt_dict)
    })
    current <- as.data.frame(mpt::mpt_dict)
    for (l in c("key", languages)) expect_equal(old_1[[l]], current[[l]])
  }

  test_dict("regression-tests/dictionaries/dict-may-2019.rda",
            c("DE", "EN", "FR", "RU"))

  test_dict("regression-tests/dictionaries/dict-oct-2019.rda",
            c("DE", "EN", "FR", "RU", "DA"))
})
