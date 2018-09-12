#' @export
standalone_mpt <- function(num_items = 30,
                           take_training = TRUE,
                           feedback = mpt::mpt.feedback.no_score(),
                           title = "Mistuning perception test",
                           admin_password = "replace-with-secure-password",
                           researcher_email = "p.m.c.harrison@qmul.ac.uk",
                           languages = mpt_languages(),
                           dict = mpt::mpt_dict) {
  elts <- c(
    psychTestR::new_timeline(
      psychTestR::get_p_id(prompt = psychTestR::i18n("enter_p_id"),
                           button_text = psychTestR::i18n("AMPT_0015_I_0001_1")),
      dict = dict
    ),
    mpt::mpt(num_items = num_items,
             take_training = take_training,
             feedback = feedback),
    psychTestR::elt_save_results_to_disk(complete = TRUE),
    psychTestR::new_timeline(
      psychTestR::final_page(shiny::p(
        psychTestR::i18n("results_have_been_saved"),
        psychTestR::i18n("you_may_close_browser")),
      ), dict = dict)
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::test_options(title = title,
                                   admin_password = admin_password,
                                   researcher_email = researcher_email,
                                   demo = FALSE,
                                   languages = languages))
}
