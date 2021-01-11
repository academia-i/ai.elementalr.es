a_numeros <- function(df, columnas, ...) {
  tabla <- as.data.frame(tabla)

  tabla[,columnas] <-  sapply(tabla[,columnas], as.numeric)

  return(tabla)
}


a_caracteres <- function(df, columnas, ...) {
  tabla <- as.data.frame(tabla)

  tabla[,columnas] <- sapply(tabla[,columnas], as.character)

  return(tabla)
}


a_cero <- function(df, columnas) {
  df <- as.data.frame(df)

  df[, columnas] <- replace(df[, columnas], is.na(df[, columnas]), 0)

  return(df)
}
