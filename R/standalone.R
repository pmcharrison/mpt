#' @export
standalone_mdt <- function(num_items = 20L,
                           take_training = TRUE,
                           feedback = mdt::mdt.feedback.no_score(),
                           title = "Melody discrimination test",
                           admin_password = "replace-with-secure-password",
                           researcher_email = "p.m.c.harrison@qmul.ac.uk",
                           languages = mdt_languages()) {
  elts <- c(
    psychTestR::get_p_id(),
    mdt::mdt(num_items = num_items,
             take_training = take_training,
             feedback = feedback),
    psychTestR::elt_save_results_to_disk(complete = TRUE),
    psychTestR::new_timeline(
      psychTestR::final_page(shiny::p(
        psychTestR::i18n("results_have_been_saved"),
        psychTestR::i18n("you_may_close_browser")),
        dict = dict
      ))
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::pt_options(title = title,
                                 admin_password = admin_password,
                                 researcher_email = researcher_email,
                                 demo = FALSE,
                                 languages = languages))
}
