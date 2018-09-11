practice <- function(media_dir) {
  unlist(lapply(
    list(list(id = "ex2", answer = "3"),
         list(id = "ex3", answer = "1")
    ),
    function(x) {
      list(
        psychTestR::audio_NAFC_page(
          label = "practice_question",
          prompt = psychTestR::i18n("AMDI_0013_I_0001_1"),
          url = file.path(media_dir, "examples", paste0(x$id, ".mp3")),
          choices = c("1", "2", "3"),
          arrange_choices_vertically = FALSE,
          save_answer = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(shiny::div(
            shiny::p(shiny::HTML(psychTestR::i18n(
              if (answer == x$answer) "AMDI_0006_I_0001_1" else "AMDI_0010_I_0001_1"))),
            if (answer != x$answer) {
              shiny::p(shiny::HTML(psychTestR::i18n(
                if (x$answer == "3") "AMDI_0012_I_0001_1" else "AMDI_0007_I_0001_1"
              )))
            }))}))}))}
