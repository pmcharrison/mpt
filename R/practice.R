practice <- function(training_dir) {
  unlist(lapply(
    list(list(id = "stim-131-first-mistuned.mp3", answer = "1"),
         list(id = "stim-246-second-mistuned.mp3", answer = "2")
    ),
    function(x) {
      list(
        psychTestR::audio_NAFC_page(
          label = "practice_question",
          prompt = psychTestR::i18n("AMPT_0013_I_0001_1"),
          url = file.path(training_dir, x$id),
          choices = get_choices(),
          labels = get_labels(),
          arrange_choices_vertically = FALSE,
          save_answer = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(shiny::div(
            shiny::p(shiny::HTML(psychTestR::i18n(
              if (answer == x$answer) "AMPT_0009_I_0001_1" else "AMPT_0010_I_0001_1")))))
        }))}))}
