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
#sino de grupo en grupo.

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


# Siempre se utilizará el operador == de igualdad, si se utiliza solamente =, R lanzará una advertencia

# Hay otro problema común que se puede encontrar al usar ==: los números de coma flotante.

sqrt(2)^2==2

(1 / 49 )* 49 == 1

#Debido a que la computadora trabaja con numeros de decimal finito, se sabe que las raices junto
# con fracciones pueden albergar una cantidad infinita de decimales, lo que generaria solo una aproximación
# a la cantidad que se desea, es por ello que R necesita saber esto, por ello, antes de crear una
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
#de los valores en y. Podríamos usarlo para reescribir el código de arriba:

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

#-----------------------------------------------------------------------------

#2. Otra función de dplyr que es útil para usar filtros es between(). ¿Qué hace?
#¿Puedes usarla para simplificar el código necesario para responder a los desafíos anteriores?

?between()

#R. la función between() se utiliza para verificar si un valor (o un vector de valores) se
#encuentra dentro de un rango definido por dos límites. Es parte del paquete dplyr, y resulta
#muy práctica porque evita tener que escribir comparaciones largas con >= y <=

#sintaxis
between(x, left, right)

#x: el vector o columna que quieres evaluar.

#left: límite inferior del rango.

#right: límite superior del rango.

#La función devuelve un vector lógico (TRUE o FALSE) indicando si cada elemento de x está dentro
#del rango [left, right]


#-------------------------------------------------------------------------------------------------

#3.¿Cuántos vuelos tienen datos faltantes en horario_salida? ¿Qué otras variables tienen valores
#faltantes?

# Número de vuelos con NA en horario de salida
nrow(filter(vuelos, is.na(horario_salida)))

vuelos %>% 
  summarise(across(everything(), ~sum(is.na(.))))

#-------------------------------------------------------------------------------------------------

#4. ¿Por qué NA ^ 0 no es faltante? ¿Por qué NA | TRUE no es faltante? ¿Por qué FALSE & NA no es faltante?
#¿Puedes descubrir la regla general? (¡NA * 0 es un contraejemplo complicado!

#R. R devuelve un valor conocido cuando la operación es determinística independientemente del valor faltante.
#Si el resultado depende de saber el valor de NA, entonces se propaga y devuelve NA

#El caso particular de NA * 0 sí depende del valor que puede tomar NA: si NA fuera 0, el resultado sería 0;
#si fuera otro número, sería distinto. Como no se puede decidir sin conocer el valor, R devuelve NA



#Seccion 5.4 **Seleccionar columnas con select()**

# En la mayoria de las bases de datos el conjunto de datos que se encuentran en este es de cientos o incluso de
#miles de variables. En este caso, el primer desafío a menudo se reduce a las variables que realmente te interesan.
#select() permite seleccionar rápidamente un subconjunto útil utilizando operaciones basadas en los nombres de las variables.



library(datos)
library(tidyverse)

## Seleccionar columnas por nombre
select(vuelos, anio, mes, dia)


# Seleccionar todas las columnas entre anio y dia (incluyente)
select(vuelos, anio:dia)


# Seleccionar todas las columnas excepto aquellas entre anio y dia (incluyente)
select(vuelos, -(anio:dia))

#Operaciones complementarias dentro la función select()

#starts_with("abc"): coincide con los nombres que comienzan con “abc”.

#ends_with("xyz"): coincide con los nombres que terminan con “xyz”.

#contains("ijk"): coincide con los nombres que contienen “ijk”.

#matches("(.)\\1"): selecciona variables que coinciden con una expresión regular.
#Esta en particular coincide con cualquier variable que contenga caracteres repetidos.
#Aprenderás más sobre expresiones regulares en [Cadenas de caracteres].

#num_range("x", 1:3): coincide con x1,x2 y x3.


#Se puede utilizar rename(), que es una variante de select() que mantiene todas las variables que no se mencionan explícitamente.

rename(vuelos, cola_num=codigo_cola)


#Otra opción es usar select() junto con el auxiliar everything() (todo, en inglés). Esto es útil si se cuenta con un grupo de variables
#que te gustaría mover al comienzo del data frame.


select(vuelos, fecha_hora, tiempo_vuelo, everything())

#------------------------------------------------------------------------------------------------

# 5.4.1 **Ejercicios**

#1. Haz una lluvia de ideas sobre tantas maneras como sea posible para seleccionar
#horario_salida,atraso_salida,horario_llegada, y atraso_llegada de vuelos.

select(vuelos, salida_programada)

select(vuelos, starts_with("atr") & ends_with("ida") )

select(vuelos, atraso_salida:llegada_programada)

select(vuelos, atraso_llegada, everything())

#----------------------------------------------------------------------------------------------

#2. ¿Qué sucede si incluyes el nombre de una variable varias veces en una llamada a select()?

select(vuelos, horario_llegada, horario_llegada, horario_llegada)

#R. Solo se imprimirá una vez la variable a la que se llama, no se duplica ni triplica en la nueva
#base de datos.

#----------------------------------------------------------------------------------------------

#3. ¿Qué hace la función any_of()? ¡¿Por qué podría ser útil en conjunto con este vector?

vars <- c ("anio", "mes", "dia", "atraso_salida", "atraso_llegada")

?any_of

#R. La función any_of() en dplyr sirve para seleccionar columnas dentro de un data.frame o tibble usando un
#vector de nombres de variables. Es especialmente útil cuando ya tienes definido un conjunto de nombres 
#en un objeto (como tu vector vars) y quieres aplicarlos en operaciones de manipulación de datos sin 
#tener que escribirlos uno por uno.


vars <- c("anio", "mes", "dia", "atraso_salida", "atraso_llegada")

vuelos %>%
  select(any_of(vars))

#-----------------------------------------------------------------------------------------------

#4. ¿Te sorprende el resultado de ejecutar el siguiente código? ¿Cómo tratan por defecto las funciones auxiliares
#de select() a las palabras en mayúsculas o en minúsculas? ¿Cómo puedes cambiar ese comportamiento
#predeterminado?

select(vuelos, contains("SALIDA"))

#R. Las variables mayusculas y minusculas las toma como lo mismo, sin compararlas. 
# Para hacer que sea sensible a minusculas, se coloca el siguiente comando:

#ignore.case = TRUE (valor por defecto): ignora diferencias entre mayúsculas y minúsculas.

#ignore.case = FALSE: exige coincidencia exacta en el uso de mayúsculas/minúsculas.

#-------------------------------------------------------------------------------------------------

# Seccion 5.5 **Añadir nuevas variables con mutate()**

#Además de seleccionar conjuntos de columnas existentes, a menudo es útil crear nuevas columnas en
#función de columnas existentes. Ese es el trabajo de mutate() (del inglés mutar o transformar).


#mutate() siempre agrega nuevas columnas al final de un conjunto de datos, así que comenzaremos creando
#un conjunto de datos más pequeño para que podamos ver las nuevas variables. 

vuelos_sml <- select(vuelos, anio:dia, starts_with("atraso"),distancia, tiempo_vuelo)

vuelos_sml

#De esta forma mutamos o creamos una columna 
mutate(vuelos_sml, ganancia = atraso_salida - atraso_llegada, velocidad = distancia / tiempo_vuelo * 60)

#Hay que tomar en cuenta que podemos hacer referencia a las columnas que se acaban de crear:
mutate(vuelos_sml, ganancia = atraso_salida - atraso_llegada, horas = tiempo_vuelo / 60,
       ganacia_por_hora = ganancia / horas)

#Si solo deseas que en el data frame aparezcan las nuevas variables, se debe utilizar la función
#transmute()

transmute(vuelos,
          ganancia = atraso_salida - atraso_llegada,
          horas = tiempo_vuelo / 60,
          ganancia_por_hora = ganancia / horas
)

#Sección 5.5.1 **Funciones de Creacion**

#Hay muchas funciones para crear nuevas variables que se pueden utilizar con mutate(). La propiedad clave es 
#que la función debe ser vectorizada: debe tomar un vector de valores como input, y devolver un vector 
#con el mismo número de valores como output.

#No hay forma de enumerar todas las posibles funciones que podrías usar, pero aquí hay una selección de funciones
#que frecuentemente son útiles:


# **Operadores aritméticos**: +, -,*,/,^. Todos están vectorizados usando las llamadas “reglas de reciclaje”.
#Si un parámetro es más corto que el otro, se extenderá automáticamente para tener la misma longitud. Esto es muy útil
#cuando uno de los argumentos es un solo número.


# **Aritmética modular**: %/% (división entera) y %% (resto), donde x == y * (x %/% y) + (x %% y). La aritmética modular
#es una herramienta útil porque te permite dividir enteros en partes. Por ejemplo, en el conjunto de datos de vuelos,
#puedes calcular hora y minutos de horario_salida con:

transmute(vuelos, horario_salida, hora = horario_salida %/% 100, minuto = horario_salida %% 100)


#Logaritmos: log(), log2(), log10(). Los logaritmos son increíblemente útiles como transformación para trabajar con datos
#con múltiples órdenes de magnitud.

#Rezagos: lead() y lag() te permiten referirte a un valor adelante o un valor atrás (con rezago).

(x <- 1:10)

lag(x)

lead(x)

#Agregados acumulativos y móviles: R proporciona funciones para ejecutar sumas, productos, mínimos y máximos: cumsum(), cumprod(),
#cummin(), cummax(); dplyr, por su parte, proporciona cummean() para las medias acumuladas.

cumsum(x)

cummean(x)

#Ordenamiento: hay una serie de funciones de ordenamiento (ranking), pero deberías comenzar con min_rank(). Esta función realiza el tipo
#más común de ordenamiento (por ejemplo, primero, segundo, tercero, etc.). El valor predeterminado otorga la menor posición a los valores
#más pequeños; usa desc(x) para dar la menor posición a los valores más grandes.

y <- c (1, 2, 2, NA, 3, 4)

min_rank(y)

min_rank(desc(y))

#---------------------------------------------------------------------------------------------------

#Seccion 5.5.2 **Ejercicios**

library(datos)
library(tidyverse)

view(vuelos)
#1. Las variables horario_salida y salida_programada tienen un formato conveniente para leer, pero es 
#difícil realizar cualquier cálculo con ellas porque no son realmente números continuos. 
#Transfórmalas hacia un formato más conveniente como número de minutos desde la medianoche.

transmute(vuelos, hora_salida= horario_salida %/%100   ,minuto_salida=horario_salida %%100,
          hora_programada= salida_programada %/%100, minuto_programada=salida_programada  %%100)

#---------------------------------------------------------------------------------------------------

#Compara tiempo_vuelo con horario_llegada - horario_salida. ¿Qué esperas ver? ¿Qué ves? ¿Qué
#necesitas hacer para arreglarlo?

transmute(vuelos , tv= tiempo_vuelo, dif= horario_llegada - horario_salida)

#R. De la misma forma se presentan las hora y los minutos encapsulados en terminos de tres digitos,
#hay que separarlos

data <- transmute(vuelos , time_vuelo= tiempo_vuelo, dif= horario_llegada - horario_salida)

transmute(data, htime_vuelo= time_vuelo %/% 100 , mintime_vuelo=time_vuelo %% 100 ,
          hdif_vuelo= dif %/% 100 , mindif_vuelo=dif %% 100)

#---------------------------------------------------------------------------------------------------
  
#Compara horario_salida, salida_programada, y atraso_salida. ¿Cómo esperarías que esos tres 
#números estén relacionados?

select(vuelos, horario_salida, salida_programada, atraso_salida )

#R. Reaciona aquellos vuelos que slieron tarde o mas temprano de su hora programada, y esta informacion
#la otorga la varable atraso_salida, Si el vuelo partio antes de su hora aparecera un valor positivo
#en esta variable, si el vuelo partio con minutos tarde se coocara en numeros rojos ese atraso

#---------------------------------------------------------------------------------------------------
  
#Encuentra los 10 vuelos más retrasados utilizando una función de ordenamiento. ¿Cómo quieres 
#manejar los empates? Lee atentamente la documentación de min_rank().

#---------------------------------------------------------------------------------------------------

#¿Qué devuelve 1:3 + 1:10? ¿Por qué?
1:3 
1:10

1:3 + 1:10

#R. Dado que se desean sumar cadenas, su longitd debe ser igual, en este caso las longitudes son
#dferentes por ello arroja el error 

#---------------------------------------------------------------------------------------------------
  
#¿Qué funciones trigonométricas proporciona R?

#sin(x) → seno, cos(x) → coseno, tan(x) → tangente
#asin(x) → arco seno , acos(x) → arco coseno, atan(x) → arco tangente, atan2(y, x) → arco tangente de y/x 
#considerando el cuadrante (muy útil en coordenadas polares)

#sinh(x) → seno hiperbólico , cosh(x) → coseno hiperbólico, tanh(x) → tangente hiperbólica

#asinh(x) → arco seno hiperbólico , acosh(x) → arco coseno hiperbólico,  atanh(x)


#--------------------------------------------------------------------------------------------------