
# test_that unit test - Peer Assessment 2
# Test the 'toNumeric' function.

library("testthat")
context("Test the 'toNumeric' function.")

source("./src/toNumeric.R")
source("./tests/test-toNumeric-df.R")
test_that("match the example output for this function", {
  expect_equal(mapply(toNumeric,c(1), c("K","M","m","B","","1","2","6","7","8","+","-")), df)
})
