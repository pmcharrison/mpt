#' MPT feedback (no score)
#'
#' Here the participant is given no feedback at the end of the test.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @export
#' @examples
#' \dontrun{
#' demo_mpt(feedback = mpt.feedback.no_score())}
mpt.feedback.no_score <- function(dict = mpt::mpt_dict) {
  psychTestR::new_timeline(
    psychTestR::one_button_page(
      psychTestR::i18n("AMPT_0017_I_0001_1"),
      button_text = psychTestR::i18n("AMPT_0015_I_0001_1")
    ),
    dict = dict
  )
}
