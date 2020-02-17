#' MPT
#'
#' This function defines a MPT module for incorporation into a
#' psychTestR timeline.
#' Use this function if you want to include the MPT in a
#' battery of other tests, or if you want to add custom psychTestR
#' pages to your test timeline.
#' For demoing the MPT, consider using \code{\link{demo_mpt}()}.
#' For a standalone implementation of the MPT,
#' consider using \code{\link{standalone_mpt}()}.
#'
#' @param num_items (Integer scalar) Number of items in the test.
#'
#' @param take_training (Logical scalar) Whether to include the training phase.
#'
#' @param label (Character scalar) Label to give the MPT results in the output file.
#'
#' @param feedback Defines the feedback to give the participant
#' at the end of the test. By default no feedback is given.
#' This can be a timeline segment (as created by \code{\link[psychTestRCAT]{new_timeline}}),
#' a test element (as created by e.g. \code{\link[psychTestRCAT]{page}}),
#' or a list of test elements.
#' The following built-in choices are available
#' see function-level documentation for details):
#' - \code{\link{mpt.feedback.no_score}}
#' - \code{\link[psychTestRCAT]{cat.feedback.graph}}
#' - \code{\link[psychTestRCAT]{cat.feedback.irt}}
#' - \code{\link[psychTestRCAT]{cat.feedback.iq}}
#'
#' @param audio_dir (Character scalar) File path to the directory
#' hosting the audio (typically a publicly accessible web directory).
#'
#' @param training_dir (Character scalar) File path to the directory
#' hosting the training items' audio (typically a publicly accessible web directory).
#'
#' @param next_item.criterion (Character scalar)
#' Criterion for selecting successive items in the adaptive test.
#' See the \code{criterion} argument in \code{\link[catR]{nextItem}} for possible values.
#' \code{"bOpt"} corresponds to the setting used in the original MPT paper.
#'
#' @param next_item.estimator (Character scalar)
#' Ability estimation method used for selecting successive items in the adaptive test.
#' See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
#' \code{"BM"}, Bayes modal,
#' corresponds to the setting used in the original MPT paper.
#' \code{"WL"}, weighted likelihood,
#' corresponds to the default setting used in versions <= 0.2.0 of this package.
#'
#' @param next_item.prior_dist (Character scalar)
#' The type of prior distribution to use when calculating ability estimates
#' for item selection.
#' Ignored if \code{next_item.estimator} is not a Bayesian method.
#' Defaults to \code{"norm"} for a normal distribution.
#' See the \code{priorDist} argument in \code{\link[catR]{thetaEst}} for possible values.
#'
#' @param next_item.prior_par (Numeric vector, length 2)
#' Parameters for the prior distribution;
#' see the \code{priorPar} argument in \code{\link[catR]{thetaEst}} for details.
#' Ignored if \code{next_item.estimator} is not a Bayesian method.
#' The default is \code{c(0, 1)}.
#'
#' @param final_ability.estimator
#' Estimation method used for the final ability estimate.
#' See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
#' The default is \code{"WL"}, weighted likelihood,
#' which corresponds to the setting used in the original MPT paper.
#' If a Bayesian method is chosen, its prior distribution will be defined
#' by the \code{next_item.prior_dist} and \code{next_item.prior_par} arguments.
#'
#' @param constrain_answers (Logical scalar)
#' If \code{TRUE}, then item selection will be constrained so that the
#' correct answers are distributed as evenly as possible over the course of the test.
#' We recommend leaving this option disabled.
#'
#' @param dict The psychTestR dictionary used for internationalisation.
#'
#' @note Versions <= 0.2.0 of this package experimented with weighted likelihood
#' ability estimation for item selection.
#' However, subsequent versions of the package revert to Bayes modal
#' ability estimation for item selection, consistent with the original MPT paper.
#'
#' @export
mpt <- function(num_items = 30L,
                take_training = TRUE,
                label = "MPT",
                feedback = mpt.feedback.no_score(),
                audio_dir = "https://media.gold-msi.org/test_materials/MPT/v1-1/audio",
                training_dir = "https://media.gold-msi.org/test_materials/MPT/training",
                next_item.criterion = "bOpt",
                next_item.estimator = "BM",
                next_item.prior_dist = "norm",
                next_item.prior_par = c(0, 1),
                final_ability.estimator = "WL",
                constrain_answers = FALSE,
                dict = mpt::mpt_dict) {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training),
            is.scalar.character(audio_dir),
            is.scalar.character(training_dir),
            psychTestR::is.timeline(feedback) ||
              is.list(feedback) ||
              psychTestR::is.test_element(feedback) ||
              is.null(feedback))
  audio_dir <- gsub("/$", "", audio_dir)
  training_dir <- gsub("/$", "", training_dir)

  psychTestR::join(psychTestR::new_timeline(
    psychTestR::join(
      if (take_training) instructions(training_dir),
      main_test(label = label, audio_dir = audio_dir, num_items = num_items,
                next_item.criterion = next_item.criterion,
                next_item.estimator = next_item.estimator,
                next_item.prior_dist = next_item.prior_dist,
                next_item.prior_par = next_item.prior_par,
                final_ability.estimator = final_ability.estimator,
                constrain_answers = constrain_answers)
    ), dict = dict),
    feedback
  )
}
