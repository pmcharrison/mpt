#' @export
mdt <- function(num_items = 20L,
                take_training = TRUE,
                label = "MDT",
                feedback = mdt.feedback.no_score(),
                audio_dir = "http://media.gold-msi.org/test_materials/MPT/v1-1/audio",
                training_dir = "http://media.gold-msi.org/test_materials/MPT/training",
                next_item.criterion = "bOpt",
                next_item.estimator = "WL",
                final_ability.estimator = "WL",
                constrain_answers = FALSE,
                dict = mdt::mdt_dict) {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(training_dir),
            psychTestR::is.timeline(feedback) ||
              is.list(feedback) ||
              psychTestR::is.test_element(feedback) ||
              is.null(feedback))
  media_dir <- gsub("/$", "", media_dir)

  psychTestR::new_timeline({
    c(
      if (take_training) instructions(training_dir),
      main_test(label = label, audio_dir = audio_dir, num_items = num_items,
                next_item.criterion = next_item.criterion,
                next_item.estimator = next_item.estimator,
                final_ability.estimator = final_ability.estimator,
                constrain_answers = constrain_answers),
      feedback
    )},
    dict = dict)
}
