context("add function")
test_that("adding integers work", {
  expect_equal(add(1, 2), 3)
})

context("substract function")
test_that("substracting integers work", {
  expect_equal(substract(4,3), 1)
})
