#Automated testing for MPT
library(psychTestR)
library(testthat)

dir <- system.file("MPT", package = "mpt", mustWork = TRUE)

number_items <- 20 #number of items

app <<- AppTester$new(dir)

# ID
app$expect_ui_text("Please enter your participant ID. Continue")
app$set_inputs(p_id = "abcde")
app$click_next()

# Training
app$expect_ui_text("This test assesses your ability to perceive mistuning in pieces of music. You will be played some music clips. In some clips, the vocalist will be in tune with the background music, but in other clips the vocalist will be out of tune. Your task is to decide whether the vocalist is in tune or out of tune. Click 'Continue' to hear some examples. Continue")
app$click_next()

app$expect_ui_text("Example - in tune In this example the vocalist is in tune with the background music. Click here to play Continue")
app$click("Continue")

app$expect_ui_text("Example - out of tune In this example the vocalist is out of tune with the background music. Click here to play Continue")
app$click("Continue")

app$expect_ui_text("In the test you will be played two versions of the same music clip, one after the other. In one version the vocalist will be in tune, and in the other version the vocalist will be out of tune. Your task is to identify which version was out of tune. Click 'Continue' to try some examples. Continue")
app$click_next()

app$expect_ui_text("Which version was out of tune? If you don't know, give your best guess! Click here to play First Second")
app$click("1")

app$expect_ui_text("Correct! Continue")
app$click_next()

app$expect_ui_text("Which version was out of tune? If you don't know, give your best guess! Click here to play First Second")
app$click("1")

app$expect_ui_text("Incorrect! Continue")
app$click_next()

app$expect_ui_text("Press 'Go back' to read the instructions and try the examples again, or press 'Continue' to continue to the main test. Go back Continue")
app$click("continue") # "go back"

app$expect_ui_text("You are about to start the main test, where your results will be recorded. Good luck! Continue")
app$click_next()

# Main test
q <- 1 # number of question
for (i in sample(1:2, number_items, replace=TRUE)){
  app$expect_ui_text(paste("Question", q, "out of", number_items, "Which version was out of tune? If you don't know, give your best guess! Click here to play First Second"))
  app$click(i)
  q <- q + 1
}
app$expect_ui_text("You completed the tuning perception test! Next")
app$click_next()

if (FALSE) {
  # Results
  results <- app$get_results() %>% as.list()
  MPT_ability_sem <<- results[["MPT"]][["ability_sem"]]
  MPT_ability <<- results[["MPT"]][["ability"]]

  print(paste("Standard error of measurement of MPT", MPT_ability_sem))
}

app$stop()
