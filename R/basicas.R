#' ¿No está en un vector?
#'
#' @description Determina si un valor o elemento dado **no se encuentra** en un
#'   vector. Es la negación de la función \code{\link{%in%}}. La
#'   función `%in%` arroja `TRUE` si el elemento está en el vector. En cambio,
#'   esta función `%notin%` arroja `TRUE` si el elemento **no se encuentra** en
#'   el vector.
#'
#' @param x **Vector, valor o elemento numérico o de caracter**. Es el que se requiere
#'   determinar si se encuentra en el vector `y`.
#' @param y **Vector**. Es al que se pregunta si no contiene el valor o elemento
#'   `x`.
#'
#' @return Vector con valores lógico **`TRUE`** o **`FALSE`**. La cantidad de valores
#'   será igual a la longitud de x. Si la longitud es igual a 1 (ej: x <- 5), el
#'   resultado será un único valor lógico, `TRUE` o `FALSE`. Si es mayor a 1, el
#'   resultado será un vector de valores lógicos de la longitud de x. Ejemplo:
#'
#'  `(1:3) %notin% c(1,10)`
#'
#'  dará como resultado:
#'
#'  `FALSE TRUE TRUE`.
#'
#' @details El paquete `Hmisc` contiene la función \code{\link[Hmisc]{%nin%}}
#'  que hace la misma operación: determinar si un valor o elemento no se
#'  encuentra en un vector. Su nombre, sin embargo, es poco intuitivo y se
#'  demora el doble de tiempo en ejecutar la misma operación.
#'
#' @author La función fue tomada de una respuesta de \href{https://stackoverflow.com/questions/38351820/negation-of-in-in-r}{stackoverflow}.
#'
#' @export
#'
#' @examples
#' # Para saber si un valor o elemento de una función **si está** en un vector:
#'   "a" %in% letters # Resultado: TRUE, dado que "a" si está en el vector.
#'
#' # La función `%notin%` arroja el resultado contrario:
#'   "a" %notin% letters # Resultado: FALSE
#'
#' # Al igual que `%in%`, `%notin%` tiene gran utilidad en el control de flujo:
#'   dias <- weekdays(x=as.Date(seq(6), origin="1950-01-01"))
#'   if ("domingo" %notin% dias) dias <- c(dias, "domingo")
`%notin%` <- function(x,y) {

  ! x %in% y

  }

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
  else if (is.primitive(x)) {
    cat("Es una FUNCI\u00d3N PRIMITIVA")
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
#' @description Agregar objetos a una lista de forma rápida controlando la
#'   posición y qué pasa con el objeto en el entorno global (GlobalEnv).
#'
#' @param lista **Una lista**. Si la lista no existe en el entorno global
#' (GlobalEnv), la función creará una y le asignará el obejto.
#' @param obj **Objeto de cualquier tipo**. Es necesario que exista previamente en
#'   el entorno global (GlobalEnv).
#' @param pos **Un número**. Puede asumir dos valores: **0** para que el objeto
#'   quede al final de la lista (*predeterminado*); o **1** para que quede en el
#'   primer lugar de la lista.
#' @param rm **Valor lógico**. Si es `TRUE` (*predeterminado*), el objeto será eliminado del entorno
#'   global (GlobalEnvir) después de ser agregado a la lista. Si es `FALSE`,
#'   el objeto será añadido a la lista sin ser eliminado del entorno global.
#'
#' @details Si `obj` no existe antes de aplicar la función, arrojará error. Debe
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

  if(!exists(deparse(substitute(lista)))) {

    listita <- list()

  } else {

    listita <- lista

  }

  if (pos %notin% c(1, 0, "final", "inicio")) {
    stop("La posici\u00f3n en la lista s\u00f3lo admite cuatro valores: \"1\" o \"inicio\" para agregar el objeto al principio de la lista; \"0\" o \"final\" para agregarlo al final. Si no ingresas el argumento, el objeto se agrega al final.")
  }

  if (pos %in% c(0, "final")) {
    listita <- c(listita, list(obj))
    names(listita)[length(listita)] <- deparse(substitute(obj))
  } else if (pos %in% c(1, "inicio")) {
    listita <- c(list(obj), listita)
    names(listita)[1] <- deparse(substitute(obj))
  }

  if (isTRUE(rm)) {
    rm(list = deparse(substitute(obj)), envir = .GlobalEnv)
  }

  if(!exists(deparse(substitute(lista)))) {

    assign(deparse(substitute(lista)), listita, envir = sys.frame(which = -1))

  } else {

    lista <- listita

    return(lista)

  }

}
