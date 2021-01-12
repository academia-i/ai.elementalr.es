#' Convertir columnas de un data frame a números
#'
#' @description Convierte las columnas de un data frame a vectores numéricos.
#'
#' @param df **Un data frame**. La función admite sólo data frames, no objetos
#'   derivados, como tibles.
#' @param columnas **Un vector con las columnas a transformar**. Puede ser
#'   vector numérico con el índice de las columnas (`columnas = 2:4`) o
#'   vector de caracteres con el nombre de las columnas
#'   (`columnas = c("a", "b"`)).
#'
#' @return Un dataframe con las columnas del argumento convertidas a vectores
#'   numéricos. Si las columnas tienen caracteres y no números, sus valores serán
#'   convertidos a NAs.
#' @export
#'
#' @details Muchas operaciones aplicadas a data frames, fundamentalmente a
#'  través de las funciones de `dplyr`, transforman las columnas numéricas a
#'  columnas de caracteres. Esta función convierte las columnas de caracteres en
#'  columnas numéricas.
#'
#'  El requisito para el funcionamiento de esta función: que **todos los elementos
#'  o ítems del vector de la columna tengan sólo números entre las comillas**. Si
#'  existe al menos un ítem o elemento del vector con al menos un caracter no
#'  numérico, como una coma, un punto o un signo monetario ($, €, £, 元), la
#'  función transformará todos los valores del vector en NAs.
#'
#'  Sólo se admiten objetos del tipo data frame en el argumento `df`. Las
#'  `tibles` u otros objetos derivados de data frames podrían arrojar error. La
#'  función intenta coercionar el objeto ingresado en el argumento `df` a la
#'  clase `data frame` antes de iniciar cualquier transformación.
#'
#' @examples
#' cuadro <- data.frame (a = as.character(c(1:5)), b = as.character(c(6:10)))
#'
#' # La función convertirá las columnas señaladas en el argumento a formato numérico:
#'   cuadro <- a_numeros(df = cuadro, columnas = 1:2)
#'
#' # También es posible aplicar la función a llamando las columnas por sus nombres:
#'   cuadro <- a_numeros(cuadro, c("a", "b"))
#'
#' # Las columnas con vectores de caracteres que tengan algo más que números generará NAs.
#'   cuadro <- cbind(cuadro, letters[1:5])
#'   cuadro <- a_numeros(cuadro, 3) # La tercera columna, de caracteres, queda sólo con NAs
#' @family funciones para transformar columnas de data frames
a_numeros <- function(df, columnas) {
  df <- as.data.frame(df)

  df[,columnas] <-  sapply(df[,columnas], as.numeric)

  return(df)
}


#' Convertir columnas de un data frame a caracteres
#'
#' @description Convierte las columnas de un data frame a vectores de caracteres.
#'
#' @param df **Un data frame**. La función admite sólo data frames, no objetos
#'   derivados, como tibles.
#' @param columnas **Un vector con las columnas a transformar**. Puede ser
#'   vector numérico con el índice de las columnas (`columnas = 2:4`) o
#'   vector de caracteres con el nombre de las columnas
#'   (`columnas = c("a", "b"`)).
#'
#' @return Un dataframe con las columnas del argumento convertidas a vectores
#'   de caracteres.
#' @export
#'
#' @details Sólo se admiten objetos del tipo data frame en el argumento `df`. Las
#'  `tibles` u otros objetos derivados de data frames podrían arrojar error. La
#'  función intenta coercionar el objeto ingresado en el argumento `df` a la
#'  clase `data frame` antes de iniciar cualquier transformación.
#'
#' @examples
#' # Las columnas se pueden ingresar por su índice:
#'   mtcars <- a_caracteres(df = mtcars, columnas = 3:7)
#'
#' # O también por el nombre:
#'   mtcars <- a_caracteres(df = mtcars, columnas = c("hp", "wt", "am"))
#' @family funciones para transformar columnas de data frames
a_caracteres <- function(df, columnas) {
  df <- as.data.frame(df)

  df[,columnas] <- sapply(df[,columnas], as.character)

  return(df)
}


#' Convertir los NA del data frame a ceros en las columnas seleccionadas
#'
#' @description Convierte los valores NA de las columnas de un data frame a
#'   ceros.
#'
#' @param df **Un data frame**. La función admite sólo data frames, no objetos
#'   derivados, como tibles.
#' @param columnas **Un vector con las columnas a transformar**. Puede ser
#'   vector numérico con el índice de las columnas (`columnas = 2:4`) o
#'   vector de caracteres con el nombre de las columnas
#'   (`columnas = c("a", "b"`)).
#'
#' @return Un dataframe con los valores NA de las columnas del argumento
#'   convertidas a valores cero (0).
#' @export
#'
#' @details Para que esta función no arroje errores, es necesario convertir
#'   antes las columnas a formato numérico. Puede usarse la función
#'   \code{\link{a_numeros}}.
#'
#'  Sólo se admiten objetos del tipo data frame en el argumento `df`. Las
#'  `tibles` u otros objetos derivados de data frames podrían arrojar error. La
#'  función intenta coercionar el objeto ingresado en el argumento `df` a la
#'  clase `data frame` antes de iniciar cualquier transformación.
#'
#' @examples
#' datos <- data.frame(a = c(10,15,NA, 25), b = c(NA, NA, 30, 40))
#' (datos <- a_cero(datos, 1:2))
#'
#' # También es posible aplicar la función llamando a las columnas por sus nombres:
#'   (datos <- a_cero(datos, c("a", "b")))
#' @family funciones para transformar columnas de data frames
a_cero <- function(df, columnas) {
  df <- as.data.frame(df)

  df[, columnas] <- replace(df[, columnas], is.na(df[, columnas]), 0)

  return(df)
}
