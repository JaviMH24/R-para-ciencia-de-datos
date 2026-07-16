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



