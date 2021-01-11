#' Convertir columnas de un data frame a números
#'
#' @param df
#' @param columnas
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
#' # Teniendo un data frame con columnas que tienen números pero, por diversas
#'  circunstancias, como vectores de caracteres....
#' cuadro = data.frame (a = as.character(c(1:5)), b = as.character(c(6:10)))
#' # a_numeros generará
#' # cuadro <- a_numeros(cuadro, 1:2)
a_numeros <- function(df, columnas, ...) {
  df <- as.data.frame(df)

  df[,columnas] <-  sapply(df[,columnas], as.numeric)

  return(df)
}


#' Convertir columnas de un data frame a caracteres
#'
#' @param df
#' @param columnas
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
#' # Las columnas se pueden ingresar por su índice...
#' mtcars <- a_caracteres(df = mtcars, columnas = 3:7)
#'
#' # O también por el nombre:
#' mtcars <- a_caracteres(df = mtcars, columnas = c("hp", "wt", "am"))
#'
a_caracteres <- function(df, columnas, ...) {
  df <- as.data.frame(df)

  df[,columnas] <- sapply(df[,columnas], as.character)

  return(df)
}


#' Convertir los NA a ceros en columnas de data frame
#'
#' @param df
#' @param columnas
#'
#' @return
#' @export
#'
#' @examples
a_cero <- function(df, columnas) {
  df <- as.data.frame(df)

  df[, columnas] <- replace(df[, columnas], is.na(df[, columnas]), 0)

  return(df)
}
