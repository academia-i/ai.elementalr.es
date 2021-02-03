
<!-- README.md is generated from README.Rmd. Please edit that file -->

![](https://dl.dropboxusercontent.com/s/6fk9lj2wq3h4jkl/Logo%20Vertical.jpg)

# ai.elementalr.es

<!-- badges: start -->

[![R-CMD-check](https://github.com/academia-i/ai.elementalr.es/workflows/R-CMD-check/badge.svg)](https://github.com/academia-i/ai.elementalr.es/actions)
<!-- badges: end -->

Bienvenides al paquetes de funciones elementales desarrollado por
Academia I (AI).

Las funciones de este paquete han sido creadas y desarrolladas para
quienes se inician en `R` y necesitan empezar a manipular datos sin
tener que memorizar largas instrucciones ni buscar cómo soluciones para
redactarlas, la mayoría de las cuales se encuentran en inglés.

Esta versión de las funciones elementales de AI se encuentra en español
(castellano en estricto rigor; no existe el idioma “español”) para
facilitar la iniciación en `R` de la comunidad castizoparlante.

There is an English version at
<https://github.com/academia-i/ai.elementalr.en>.

Se recomienda dejar de usar progresivamente este paquete a medida que se
adquiera mayor experiencia y conocimiento del lenguaje de programación
de `R` y su mecánica básica. Mientras tanto, es una herramienta útil
para lidiar con problemas básicos de manipulación y transformación de
datos en data frames.

## Instalación

Para instalar este paquete deben ejecutarse las siguientes instrucciones
en el terminal de `R`:

``` r
# Comprobamos primero si está instalado el paquete "devtools"
if(!require(devtools)) install.packages("devtools")

# Instalamos el paquete desde github
devtools::install_github("academia-i/ai.elementalr.es", build_vignettes = TRUE)
```

## ¿Qué sigue?

Empieza a usar las funciones del paquete. Para enteder qué hacen (y por
qué), puedes leer la viñeta que lo acompaña. Para ello debes ejecutar el
siguiente comando:

``` r
vignette("ai.elementalr.es")
```

## Ejemplo

A grandes rasgos, las funciones de este paquete simplican la
manipulación de datos y objetos. Supongamos que queremos aplicar las
siguiente secuencia de manipulación y transformaciones a los datos de la
base `mtcars`:

1.  Transformar a caracteres las primeras cinco columnas;
2.  Revertir la transformación para todas menos la primera;
3.  Transformar a NAs los valores de la primera;
4.  Transformar a caracteres las 3 últimas columnas;
5.  Cambiar el formato de presentación de los datos de las columnas “wt”
    y “qsec”: sustituir el punto (.) por la coma (,) y limitar a dos los
    decimales mostrados.
6.  Sustituir todos los NAs del data frame por 0.

Así se realizarían con las funciones de la base de R:

``` r
data(mtcars)
str(mtcars)
#> 'data.frame':    32 obs. of  11 variables:
#>  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#>  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
#>  $ disp: num  160 160 108 258 360 ...
#>  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
#>  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
#>  $ qsec: num  16.5 17 18.6 19.4 17 ...
#>  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
#>  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
#>  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
#>  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

mtcars[,1:5] <- sapply(mtcars[,1:5], as.character) # 1. 
mtcars[,2:5] <- sapply(mtcars[,2:5], as.numeric) # 2.
mtcars[,1] <- NA # 3.
mtcars[,(NCOL(mtcars)-2):NCOL(mtcars)] <-
  sapply(mtcars[,(NCOL(mtcars)-2):NCOL(mtcars)], as.character) # 4.
mtcars[,c("wt", "qsec")] <- 
  format(round(mtcars[,c("wt", "qsec")], digits = 2), nsmall = 2,
        decimal.mark = ",") # 5.
mtcars[is.na(mtcars)] <- 0 # 6.

# Volvemos a revisar la estructura para corroborar la aplicación de las transformaciones
str(mtcars)
#> 'data.frame':    32 obs. of  11 variables:
#>  $ mpg : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
#>  $ disp: num  160 160 108 258 360 ...
#>  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
#>  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>  $ wt  : 'AsIs' chr  "2,62" "2,88" "2,32" "3,21" ...
#>  $ qsec: 'AsIs' chr  "16,46" "17,02" "18,61" "19,44" ...
#>  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
#>  $ am  : chr  "1" "1" "1" "0" ...
#>  $ gear: chr  "4" "4" "4" "3" ...
#>  $ carb: chr  "4" "4" "1" "1" ...
```

En cambio, con las funciones de este paquete, la manipulación y
transformación queda reducido a esto:

``` r
library("magrittr")
library("ai.elementalr.es")

data(mtcars)
str(mtcars)
#> 'data.frame':    32 obs. of  11 variables:
#>  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#>  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
#>  $ disp: num  160 160 108 258 360 ...
#>  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
#>  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
#>  $ qsec: num  16.5 17 18.6 19.4 17 ...
#>  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
#>  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
#>  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
#>  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

mtcars <- a_caracteres(mtcars, 1:5) %>%  # 1.
  a_numeros(2:5) %>%  # 2.
  a_nas(1) %>%  # 3.
  a_caracteres((NCOL(mtcars)-2):NCOL(mtcars)) %>%  # 4. 
  formatear_num(columnas = c("wt", "qsec"), decs = 2, sep_decs = ",") %>% # 5.
  a_cero() # 6.

# Volvemos a revisar la estructura para corroborar la aplicación de las transformaciones
str(mtcars)
#> 'data.frame':    32 obs. of  11 variables:
#>  $ mpg : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
#>  $ disp: num  160 160 108 258 360 ...
#>  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
#>  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>  $ wt  : chr  "2,62" "2,88" "2,32" "3,21" ...
#>  $ qsec: chr  "16,46" "17,02" "18,61" "19,44" ...
#>  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
#>  $ am  : chr  "1" "1" "1" "0" ...
#>  $ gear: chr  "4" "4" "4" "3" ...
#>  $ carb: chr  "4" "4" "1" "1" ...
```

## Información adicional

Puedes encontrar más información sobre el uso y alcance del paquete en
su página oficial: <https://academia-i.com/desarrollo/r/elementalr>
