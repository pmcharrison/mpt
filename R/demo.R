#' @export
demo_mpt <- function(num_items = 30L,
                     take_training = TRUE,
                     feedback = psychTestRCAT::cat.feedback.graph("MPT"),
                     admin_password = "demo",
                     researcher_email = "p.m.c.harrison@qmul.ac.uk",
                     dict = mpt::mpt_dict) {
  elts <- c(
    mpt::mpt(num_items = num_items,
             take_training = take_training,
             feedback = feedback,
             dict = dict),
    psychTestR::new_timeline(
      psychTestR::final_page(psychTestR::i18n("you_may_close_browser")),
      dict = dict
    )
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::test_options(title = "MPT demo",
                                   admin_password = admin_password,
                                   researcher_email = researcher_email,
                                   demo = TRUE,
                                   languages = "EN"))
}
