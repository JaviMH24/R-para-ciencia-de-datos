# **Capitulo 5. Transformaciones de datos**

#Seccion 5.1.1 Prerequisitos

#Esta sección esta enfocada en cómo usar 
#el paquete dplyr, otro miembro central del tidyverse.

# install.packages("datos")
library(datos)
library(tidyverse)

#NOTA: Visualiza acerca del mensaje de conflictos que se imprime cuando cargas el paquete 
#tidyverse. Te indica que dplyr sobrescribe algunas funciones de R base. Si deseas usar
#la versión base de estas funciones después de cargar dplyr, necesitarás usar sus nombres
#completos: stats::filter() y stats::lag().

#-----------------------------------------------------------------------------------------

#Seccion 5.1.2 **Vuelos**

vuelos

#Para ver todo el conjunto de datos, puedes ejecutar View(vuelos) que abrirá el conjunto
#de datos en el visor de RStudio.

View(vuelos)

#-----------------------------------------------------------------------------------------

#Sección 5.1.3 **Lo basico de dplyr**

#las cinco funciones clave de dplyr que te permiten resolver la gran mayoría de los desafíos 
#de manipulación de datos se mencionan a continuacion:

# filter() : Filtrar o elegir las observaciones por sus valores.

# arrange() : Reordenar las filas.

# select() : Seleccionar las variables por sus nombres.

# mutate(): Crear nuevas variables con transformaciones de variables existentes.

# summarise(): Contraer muchos valores en un solo resumen.

#Todas estas funciones se pueden usar junto con group_by() (del inglés agrupar por),
#que cambia el alcance de cada función para que actúe ya no sobre todo el conjunto de datos
#sino de grupo en grupo. Estas seis funciones proporcionan los verbos para este lenguaje de manipulación de datos.

#-----------------------------------------------------------------------------------------

#Seccion 5.2. **Filtrar filas con filter()**

#filter() permite filtrar un subconjunto de observaciones según sus valores.
#El primer argumento es el nombre del data frame. El segundo y los siguientes argumentos son 
#las expresiones que lo filtran. Por ejemplo, podemos seleccionar todos los vuelos del 1 de enero con:

filter(vuelos, mes==1, dia==1)

#Las funciones de dplyr nunca modifican su input, por lo que si deseas guardar el resultado que es un data frame,
# se requiere usar el operador de asignación, <- para guardarlo en una nueva variable.


ene1 <- filter(vuelos, mes==1, dia==1)

#-----------------------------------------------------------------------------------------

# Seccion 5.2.1 **Comparaciones**

#Para usar el filtrado de manera efectiva, se debe saber cómo seleccionar las observaciones utilizando
#los operadores de comparación. R proporciona el conjunto estándar: >, >=, <, <=, != (no igual) e == (igual).


# Siemore se utilizará el operador == de igualdad, si sea utiliza solamente =, R lanzará una advertencia

# Hay otro problema común que se puede encontrar al usar ==: los números de coma flotante.

sqrt(2)^2==2

(1 / 49 )* 49 == 1

#Debido a que la computadora trabajar con numeros de decimal finito, ses abe que las raices junto
# con fracciones pueden albergar una cantidad infitira de decimales, lo que generaria solo una aproximación
# a la cantidad que se desea, es por ello que R necesita dsaber esto, por ello, antes de crear una
#comparacion como la anterior, utilizamos la funcion near() para que R sepa que es una aproximacion:

#Ojo checa la sintaxis
near(sqrt(2)^2, 2)

near((1 / 49 )* 49 , 1)

#-------------------------------------------------------------------------------------------------------------

#Seccion 5.2.2 **Operadores Lógicos**

#cada expresión debe ser verdadera para que una fila se incluya en el output. Para otros tipos de combinaciones
#necesitarás usar operadores Booleanos: & es “y”, | es “o”, y ! es “no”.


#El siguiente código sirve para encontrar todos los vuelos que partieron en noviembre o diciembre:

filter(vuelos, mes==1 | mes ==12)

#El orden de las operaciones no funciona como en español. No puedes escribir filter(vuelos, mes == (11 | 12)), que
#literalmente puede traducirse como “encuentra todos los vuelos que partieron en noviembre o diciembre”. En cambio,
#encontrará todos los meses que son iguales a 11 | 12, una expresión que resulta en ‘TRUE’ (verdadero). En un contexto 
#numérico (como aquí), ‘TRUE’ se convierte en uno, por lo que encuentra todos los vuelos en enero, no en noviembre o diciembre.
#¡Esto es bastante confuso!


#Una manera rápida y útil para resolver este problema es x %in% y (es decir, x en y). Esto seleccionará cada fila donde x es uno
#de los valores eny. Podríamos usarlo para reescribir el código de arriba:

nov_dic <-  filter(vuelos, mes %in% c(11,12))

#A veces puedes simplificar subconjuntos complicados al recordar la ley de De Morgan: !(x & y) es lo mismo que !x | !y, y !(x | y)
#es lo mismo que !x & !y. Por ejemplo, si deseas encontrar vuelos que no se retrasaron (en llegada o partida) en más de dos horas,
#puedes usar cualquiera de los dos filtros siguientes:

filter(vuelos, !(atraso_llegada > 120 | atraso_salida > 120))
filter(vuelos  , atraso_llegada <= 120, atraso_salida <= 120)

#------------------------------------------------------------------------------------------------------------------------------------

#Sección 5.2.3 **Valores faltantes**

#Una característica importante de R que puede hacer que la comparación sea difícil son los valores faltantes, o NAs (del inglés “no disponibles”).
#NA representa un valor desconocido, lo que hace que los valores perdidos sean “contagiosos”: casi cualquier operación que involucre un valor
#desconocido también será desconocida.

NA > 5

NA == 10

NA+10

NA/2

NA == NA

#Si para una variable que hayas definido, deseas
#verificar si falta un valor, usa is.na()

x <- NA

is.na(x)

#---------------------------------------------------------------------------------------------------------------------------------------

#Seccion 5.2.4 **Ejercicios**

#Encuentra todos los vuelos que:

#Tuvieron un retraso de llegada de dos o más horas

view(vuelos)

(filter(vuelos, atraso_llegada == 2 | atraso_llegada>2) )

#Volaron a Houston (IAH o HOU)

?vuelos

?aeropuertos

filter(vuelos, destino=="IAH" | destino=="HOU")

#Fueron operados por United, American o Delta

#Esta linea de codigo no funcon es por ello que se utiliza %in%

#checar

filter(vuelos, aerolineas== "AA" | aerolineas== "DL" | aerolineas== "UA")

filter(aerolineas %in% c("AA", "DL", "UA"))


#Partieron en invierno del hemisferio sur (julio, agosto y septiembre)

filter(vuelos, mes==7 | mes==8 | mes==9)


#Llegaron más de dos horas tarde, pero no salieron tarde


filter(vuelos, atraso_llegada==2 &  atraso_salida==0)

#Se retrasaron por lo menos una hora, pero repusieron más de 30 minutos
#en vuelo

filter(vuelos, !(atraso_salida==1) & atraso_llegada==-0.5)

#Partieron entre la medianoche y las 6 a.m. (incluyente)

?vuelos

(filter(vuelos, horario_salida==0000 & horario_salida==0600))