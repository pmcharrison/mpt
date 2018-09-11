#' @export
mpt.feedback.no_score <- function(dict = mpt::mpt_dict) {
  psychTestR::new_timeline(
    psychTestR::one_button_page(
      psychTestR::i18n("AMPT_0017_I_0001_1")
    ),
    dict = dict
  )
}
