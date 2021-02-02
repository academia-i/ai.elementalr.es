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
#'   numéricos. Si las columnas ingresadas a la función tienen caracteres además
#'   de números (por ejemplo, punto, comas o símbolos de monedas), sus valores
#'   serán convertidos a NAs.
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
#' @inheritParams a_numeros
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


#' Convertir los NAs de las columnas seleccionadas a ceros
#'
#' @description Convierte los valores NA de las columnas de un data frame a
#'   ceros.
#'
#' @inheritParams a_numeros
#'
#' @return Un dataframe con los valores NA de las columnas del argumento
#'   convertidas a valores cero (0). Si las columnas numéricas obtendrán 0
#'   numéricos; las columnas de caracteres obtendrán 0 como caracteres ("0").
#' @export
#'
#' @details
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
a_cero <- function(df, columnas = 1:NCOL(df)) {
  df <- as.data.frame(df)

  df[, columnas] <- replace(df[, columnas], is.na(df[, columnas]), 0)

  return(df)
}

#' Convertir los valores de las columnas seleccionadas a NAs
#'
#' @description Convierte los valores de las columnas de un data frame a
#'   NAs.
#'
#' @inheritParams a_numeros
#'
#' @return Un dataframe con los valores de las columnas del argumento
#'   convertidas a NAs.
#' @export
#'
#' @details En principio, no es relevante para la función si las columnas
#'   seleccionadas son numéricas, de caracteres o lógicas. El resultado será
#'   siempre todos sus valores convertidos a NAs.
#'
#' @examples
#' datos <- data.frame(a = c(10,15,20, 25), b = c(10, 20, 30, 40))
#' (datos <- a_nas(datos, 1))
#' @family funciones para transformar columnas de data frames
a_nas <- function(df, columnas) {

  df[,columnas] <- NA

  return(df)
}


#' Transformar los elementos de los valores de las columnas seleccionadas
#'
#' @description Toma los valores de una columna numérica y les asigna los elementos
#'   definidos por los argumentos. Se pueden definir la cantidad de números
#'   decimales, el separador de decimales y el separador de miles
#'
#' @param decs **Número de decimales**. Cantidad de decimales, en formato numérico,
#'   que se desea mostrar en los valores. Por defecto, si no se explicita, la
#'   función asigna 1.
#' @param sep_miles **Caracter que se usa para separar miles**. Puede elegirse
#'   cualquiera: espacio, coma, punto. Por defecto, si no se explicita, la
#'   función asigna el punto.
#' @param sep_decs **Caracter que se usa para separar decimales**. Puede elegirse
#'   cualquiera: espacio, coma, punto. Por defecto, si no se explicita,
#'   la función asigna la coma.
#' @param ... **Otros argumentos**
#' @inheritParams a_numeros
#'
#' @return Un dataframe con los valores de las columnas seleccionadas
#'   formateadas con los elementos definidos en los argumentos. **Las columnas serán
#'   convertidas a caracteres**. No existe forma de modificar separadores de
#'   decimales y miles sin transformar una columna numérica en una una columna de
#'   caracteres. Sólo se puede modificar la forma de visualizar los datos con
#'   la función de R base `options(OutDec= ",")`, pero con \href{https://github.com/yihui/knitr/issues/1943}{conocidos riesgos de
#'   quebrar códigos}.
#'
#'   La función exige que las columnas ingresadas para formatear sean numéricas.
#'   Si no son numéricas, la función no realizará ninguna transformación con ellas
#'   y las dejará sin modificación.
#'
#' @export
#'
#' @examples
#' datos <- data.frame(a = c(10.46,15.37,20.28, 25.19), b = c(1000, 2000, 3000, 4000))
#' (datos <- formatear_num(datos, 1:2, decs = 1, sep_miles =".", sep_decs = ","))
#' @family funciones para transformar columnas de data frames
formatear_num <- function(df, columnas, decs = 1, sep_miles =".", sep_decs = ",", ...) {

  for (i in 1:length(columnas)) {

    if (is.numeric(df[, columnas[i]])) {

      df[, columnas[i]] <- format(round(df[, columnas[i]], digits = decs), nsmall = decs,
                              big.mark = sep_miles, decimal.mark = sep_decs)

    }

  }

  return(df)

}
