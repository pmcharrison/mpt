mpt.options <- function(next_item.criterion,
                        next_item.estimator,
                        final_ability.estimator,
                        constrain_answers,
                        item_bank) {
  psychTestRCAT::adapt_test_options(
    next_item.criterion = next_item.criterion,
    next_item.estimator = next_item.estimator,
    final_ability.estimator = final_ability.estimator,
    constrain_answers = constrain_answers,
    avoid_duplicates = "song"
  )
}
