test_that("listar works", {
  x <- c(1:5)
  my_list <- listar(my_list, x, rm = F)
  expect_type(my_list, "list")
})

#> Test passed
