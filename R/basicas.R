`%notin%` <- Negate(`%in%`)

#' Determinar qué tipo de objeto con precisión
#'
#' @param x
#' @param ...
#'
#' @return vector
#' @export
#'
#' @examples
#' bbdd <- data(mtcars)
#' que.es(bbdd)
que.es <- function(x, ...) {
  if (!exists(as.character(substitute(x)))) {
    cat("No existe. No es un objeto definido o asignado. Def\u00ednelo primero con \"x <- algo \" ")
  }
  if (nargs() > 1) {
    cat("Se puede comprobar un \u00fanico objeto a la vez. Ingresa s\u00f3lo uno")
  } else if (is.vector(x) & !is.matrix(x)) {
    cat("Es VECTOR")
  }
  else if (is.matrix(x)) {
    cat("Es MATRIZ")
  }
  else if (is.list(x) & !is.data.frame(x)) {
    cat("Es LISTA")
  }
  else if (is.factor(x)) {
    cat("Es FACTOR")
  }
  else if (is.array(x)) {
    cat("Es ARRAY")
  }
  else if (is.data.frame(x)) {
    cat("Es DATA FRAME")
  }
  else if (is.function(x)) {
    cat("Es una FUNCI\u00d3N")
  }
  else if (is.environment(x)) {
    cat("Es un ENVIRONMENT")
  }
  else if (is.language(x)) {
    cat("Es un LENGUAJE")
  }
  else if (is.expression(x)) {
    cat("Es una EXPRESI\u00d3N")
  }
  else {
    cat("No es posible determinar qu\u00e9 es ", x)
  }
}

#' Incorporar objetos a una lista
#'
#' @param lista
#' @param obj
#' @param pos
#' @param rm
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
listar <- function(lista, obj, pos = 0, rm = T, ...) {

  if (pos %notin% c(1, 0, "final", "inicio")) {
    stop("La posici\u00f3n en la lista s\u00f3lo admite cuatro valores: \"1\" o \"inicio\" para agregar el objeto al principio de la lista; \"0\" o \"final\" para agregarlo al final. Si no ingresas el argumento, el objeto se agrega al final.")
  }

  if (pos %in% c(0, "final")) {
    lista <- c(lista, list(obj))
    names(lista)[length(lista)] <- deparse(substitute(obj))
  } else if (pos %in% c(1, "inicio")) {
    lista <- c(list(obj), lista)
    names(lista)[1] <- deparse(substitute(obj))
  }

  if (isTRUE(rm)) {
    rm(list = deparse(substitute(obj)), envir = .GlobalEnv)
  }

  return(lista)
}
