`%notin%` <- Negate(`%in%`)

#' Determinar el tipo de objeto
#'
#' @description Indica en el terminal cuál es el tipo del objeto que se
#'   introduce como argumento. Lo hace con máxima precisión. Las alternativas
#'   de R base (`class` y `typeof`) no detectan diferencias entre distintos
#'   tipos de vectores. Y `tipeof` no distingue entre listas y data frames.
#'   Esta función subsana ambas limitaciones.
#'
#' @param x **Un objeto cualquiera**, cuyo tipo se desee saber.
#'
#' @return Texto en el terminal indicando el tipo de objeto.
#' @details El valor que arroja la función, al ser sólo texto en el terminal,
#'   ***no se puede guardar*** a su vez como un nuevo objeto.
#'
#' @export
#'
#' @examples
#' bbdd <- data(mtcars)
#' que.es(bbdd)
#'
#' x <- expression(pi * 5)
#' que.es(x)
que.es <- function(x) {
  if (!exists(as.character(substitute(x)))) {
    cat("No existe. No es un objeto definido o asignado. Def\u00ednelo primero con \"x <- algo \" ")
  }
  if (nargs() > 1) {
    cat("Se puede comprobar un \u00fanico objeto a la vez. Ingresa s\u00f3lo uno")
  } else if (is.vector(x) & !is.matrix(x) & !is.expression(x)) {

    if(is.logical(x)) cat("Es VECTOR de valores l\u00f3gicos (T/F)")

    else if(is.character(x)) cat("Es VECTOR de caracteres")

    else  if(is.numeric(x)) cat("Es VECTOR de valores num\u00e9ricos")

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
  else if (is.language(x) & !is.expression(x)) {
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
#' @description Sirve para agregar objetos a una lista de forma rápida controlando la posición
#'
#' @param lista **Una lista**. Es necesario que exista previamente en el entorno
#'   global (GlobalEnvir).
#' @param obj **Objeto de cualquier tipo**. Es necesario que exista previamente en
#'   el entorno global (GlobalEnvir).
#' @param pos **Un número**. Puede asumir dos valores:
#'      **0** para que el objeto quede al final de la lista (*predeterminado*:
#'      `lista[[length(lista)]])`; o
#'      **1** para que quede en el primer lugar de la lista (`lista[[1]]`).
#' @param rm **Valor lógico**. Si es `TRUE` (*predeterminado*), el objeto será eliminado del entorno
#'   global (GlobalEnvir) después de ser agregado a la lista. Si es `FALSE`,
#'   el objeto será añadido a la lista sin ser eliminado del entorno global.
#'
#' @details Si `lista` no existe en el entorno global cuado se aplica la
#'   función, arrojará error. Debe crearse antes. Puede ser una lista que ya
#'   tenga otros objetos o una lista vacía: `lista <- list()`.
#'
#'   Si `obj` no existe antes de aplicar la función, arrojará error. Debe
#'   existir antes en el entorno global.
#'
#'   Si `listar()` se usa dentro de una función personalizada, debe definirse
#'   `rm = FALSE`. De lo contrario, arrojará error.
#'
#' @return Una *`lista`* con el *`obj`* incorporado en la posición indicada con el
#'   argumento *`pos`*.
#' @export
#'
#' @examples
#' mis_cosas <- list(
#'    libros = c("El péndulo de Foucault", "Germinal", "Artificios", "Angela's Ashes"),
#'    vinilos = c("Abbey Road", "Kind of blue", "Nevermind",
#'     "Bigger, better, faster, more", "Parte de la religión")
#'   )
#'
#' computadoras <- c("Notebook", "Workstation", "Raspberry Pi")
#'
#' # Agregando el objeto al final de la lista y conservándolo en el entorno global:
#'   mis_cosas <- listar(mis_cosas, computadoras, pos = 0, rm = FALSE)
#'
#' # Agregando el objeto al primer lugar de la lista y eliminándolo del entorno global:
#'   mis_cosas <- listar(mis_cosas, computadoras, pos = 1, rm = TRUE)
listar <- function(lista, obj, pos = 0, rm = T) {

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
