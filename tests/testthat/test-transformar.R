test_that("a_numeros works", {
  df <- data.frame("a" = as.character(10:15),
                   "b" = seq(50, 100, 10),
                   "c" = c("1,2", "2,3", "3,4", "4,5", "5,6", "6,7"))
  df <- a_numeros(df, 1)
  expect_true(is.numeric(df$a))
  expect_warning(a_numeros(df, 3), "NAs introduced by coercion")
})
#> Test passed

test_that("a_caracteres works", {
  df <- data.frame("a" = as.character(10:15), "b" = seq(50, 100, 10))
  df <- a_caracteres(df, 2)
  expect_true(is.character(df$b))
})
#> Test passed

test_that("a_nas works", {
  df <- data.frame("a" = as.character(10:15), "b" = seq(50, 100, 10))
  df <- a_nas(df, 2)
  expect_true(is.na(all(df$b)))
})
#> Test passed

test_that("a_cero works", {
  df <- data.frame("a" = as.character(10:15),
                   "b" = c(seq(50, 70, 5), NA),
                   "c" = c("1,2", NA, "3,4", "4,5", "5,6", "6,7"))
  df <- a_cero(df, 1:3)
  expect_equal(df[6, 2], 0)
  expect_equal(df[2, 3], "0")
})
#> Test passed
