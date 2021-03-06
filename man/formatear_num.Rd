% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transformar.R
\name{formatear_num}
\alias{formatear_num}
\title{Transformar los elementos de los valores de las columnas seleccionadas}
\usage{
formatear_num(df, columnas, decs = 1, sep_miles = ".", sep_decs = ",", ...)
}
\arguments{
\item{df}{\strong{Un data frame}. La función admite sólo data frames, no objetos
derivados, como tibles.}

\item{columnas}{\strong{Un vector con las columnas a transformar}. Puede ser
vector numérico con el índice de las columnas (\code{columnas = 2:4}) o
vector de caracteres con el nombre de las columnas
(\verb{columnas = c("a", "b"})).}

\item{decs}{\strong{Número de decimales}. Cantidad de decimales, en formato numérico,
que se desea mostrar en los valores. Por defecto, si no se explicita, la
función asigna 1.}

\item{sep_miles}{\strong{Caracter que se usa para separar miles}. Puede elegirse
cualquiera: espacio, coma, punto. Por defecto, si no se explicita, la
función asigna el punto.}

\item{sep_decs}{\strong{Caracter que se usa para separar decimales}. Puede elegirse
cualquiera: espacio, coma, punto. Por defecto, si no se explicita,
la función asigna la coma.}

\item{...}{\strong{Otros argumentos}}
}
\value{
Un dataframe con los valores de las columnas seleccionadas
formateadas con los elementos definidos en los argumentos. \strong{Las columnas serán
convertidas a caracteres}. No existe forma de modificar separadores de
decimales y miles sin transformar una columna numérica en una una columna de
caracteres. Sólo se puede modificar la forma de visualizar los datos con
la función de R base \code{options(OutDec= ",")}, pero con \href{https://github.com/yihui/knitr/issues/1943}{conocidos riesgos de
quebrar códigos}.

La función exige que las columnas ingresadas para formatear sean numéricas.
Si no son numéricas, la función no realizará ninguna transformación con ellas
y las dejará sin modificación.
}
\description{
Toma los valores de una columna numérica y les asigna los elementos
definidos por los argumentos. Se pueden definir la cantidad de números
decimales, el separador de decimales y el separador de miles
}
\examples{
datos <- data.frame(a = c(10.46,15.37,20.28, 25.19), b = c(1000, 2000, 3000, 4000))
(datos <- formatear_num(datos, 1:2, decs = 1, sep_miles =".", sep_decs = ","))
}
\seealso{
Other funciones para transformar columnas de data frames: 
\code{\link{a_caracteres}()},
\code{\link{a_cero}()},
\code{\link{a_nas}()},
\code{\link{a_numeros}()}
}
\concept{funciones para transformar columnas de data frames}
