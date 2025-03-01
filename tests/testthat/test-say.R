library(crayon)

test_that("say types works as expected", {
  # expect warning on type=warning
  expect_warning(say(type = "warning"), "Hello world!")
  
  # expect string on type=string
  expect_is(say(type = "string"), "character")

  # hypnotoad can say anything
  expect_true(grepl("foo", say(what = "foo", by = "hypnotoad", type = "string")))
})

test_that("say works with multicolor", {
  skip_if_not_installed("multicolor")

  expect_equal(
    length(suppressMessages(say("foo", by_color = "cyan"))) + 1,
    length(suppressWarnings(say("foo", type = "warning")))
  )
  
  expect_equal(
    say(what = "rms", by = "rms",
        what_color = yellow$bgMagenta$bold,
        by_color = cyan$italic),
    say(what = "rms", by = "rms", type = "print")
  )
  
  expect_equal(
    say(what = "I'm a rare Irish buffalo", 
        by = "buffalo", 
        what_color = "pink", 
        by_color = c("green", "white", "orange")),
    say(what = "I'm a rare Irish buffalo", 
        by = "buffalo",
        type = "print")
  )
  
  expect_equal(
    say("I'm not dying, you're dying", "yoda",
        what_color = "green",
        by_color = colors()),
    say("I'm not dying, you're dying", "yoda",
        type = "print")
  )

  expect_equal(
    say("asdfghjkl;'", "chicken",
          what_color = blue,
          by_color = c("rainbow", colors()[sample(100, 1)], "rainbow")),
    say("asdfghjkl;'", "chicken", type = "print")
  )

  skip_if(!crayon::has_color(), message = "Shouldn't fail if colors can't be applied.")
  expect_error(
    say(by_color = 123),
    "All colors must be of class character or crayon"
  )
  
  expect_error(
    say(what_color = mean),
    "All colors must be of class character or crayon"
  )
})

test_that("say by works as expected", {
  expect_equal(suppressMessages(say('%s', by = "chicken", type = "string")), animals[["chicken"]])
  expect_equal(suppressMessages(say('%s', by = "ghost", type = "string")), animals[["ghost"]])
})

test_that("say fails well", {
  expect_error(say(list(4, 5)), "what has to be of length 1")
})

test_that("say fails with certain characters on windows", {
  skip_on_os(c("mac", "linux", "solaris"))
  expect_error(say("Hi", by = "longcat"), "If you're on Windows, you can't use")
})

