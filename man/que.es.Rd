% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/basicas.R
\name{que.es}
\alias{que.es}
\title{Determinar el tipo de objeto}
\usage{
que.es(x)
}
\arguments{
\item{x}{\strong{Un objeto cualquiera}, cuyo tipo se desee saber.}
}
\value{
Texto en el terminal indicando el tipo de objeto.
}
\description{
Indica en el terminal cuál es el tipo del objeto que se
introduce como argumento. Lo hace con máxima precisión. Las alternativas
de R base (\code{class} y \code{typeof}) no detectan diferencias entre distintos
tipos de vectores. Y \code{tipeof} no distingue entre listas y data frames.
Esta función subsana ambas limitaciones.
}
\details{
El valor que arroja la función, al ser sólo texto en el terminal,
\emph{\strong{no se puede guardar}} a su vez como un nuevo objeto.
}
\examples{
bbdd <- data(mtcars)
que.es(bbdd)

x <- expression(pi * 5)
que.es(x)
}
