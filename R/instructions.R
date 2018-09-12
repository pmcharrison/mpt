info_page <- function(id) {
  psychTestR::one_button_page(psychTestR::i18n(id),
                              button_text = psychTestR::i18n("AMPT_0015_I_0001_1"))
}

audio_ex_page <- function(prompt_id, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = psychTestR::i18n(prompt_id),
    choices = psychTestR::i18n("AMPT_0015_I_0001_1"),
    url = url,
    save_answer = FALSE
  )
}

instructions <- function(training_dir) {
  c(
    psychTestR::code_block(function(state, ...) {
      psychTestR::set_local("do_intro", TRUE, state)
    }),
    psychTestR::loop_while(
      test = function(state, ...) psychTestR::get_local("do_intro", state),
      logic = c(
        info_page("AMPT_0001_I_0001_1"),
        audio_ex_page("AMPT_0002_I_0001_1", file.path(training_dir, "in-tune.mp3")),
        audio_ex_page("AMPT_0003_I_0001_1", file.path(training_dir, "out-of-tune.mp3")),
        info_page("AMPT_0004_I_0001_1"),
        practice(training_dir),
        ask_repeat()
      )),
    psychTestR::one_button_page(psychTestR::i18n(
      "AMPT_0011_I_0001_1"
    ), button_text = psychTestR::i18n("AMPT_0015_I_0001_1"))
  )
}

ask_repeat <- function() {
  psychTestR::NAFC_page(
    label = "ask_repeat",
    prompt = shiny::HTML(psychTestR::i18n("AMPT_0010_I_0001_1")),
    choices = c("go_back", "continue"),
    labels = lapply(c("AMPT_0016_I_0001_1", "AMPT_0015_I_0001_1"), psychTestR::i18n),
    save_answer = FALSE,
    arrange_vertically = TRUE,
    on_complete = function(state, answer, ...) {
      psychTestR::set_local("do_intro", identical(answer, "go_back"), state)
    }
  )
}
