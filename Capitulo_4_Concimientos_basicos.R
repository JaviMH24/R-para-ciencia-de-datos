# **Capitulo 4 concoimientos basicos de R**

# **Sección 4.1**

#R se puede utilizar como una calculadora

1/200*30

(59 + 73 + 2) / 3

sin(pi / 2)

#Para asignar valores a determindas variables
#se genera por medio de una sintaxis de flecha

x <- 3*4

#las instrucciones de asignación, tienen la
#misma estructura:

nombre_objeto <- valor

#La asignación de valores se puede
#recordar de esta manera:
#Cuando leas esa línea de código di mentalmente 
#“nombre_objeto recibe valor”.

#ATAJO DE TECLADO "Alt" + "-" para generar rapidamente
#la flecha

#-------------------------------------------------------

#Sección 4.2 **La importancia de los nombres**

#Los nombres de los objetos deben comenzar con una letra y 
#solo pueden contener letras, números, "_" y ".". Por ejemplo:


yo_uso_guion_bajo
OtraGenteUsaMayusculas
algunas.personas.usan.puntos
Y_algunasPocas.Personas_RENIEGANdelasconvenciones


#Podemos examinar un objeto, volviendo a llamar solo escribiendo
#nombre

x

este_es_un_nombre_largo <- 2.5

este_es_un_nombre_largo

# **Sección 4.3 Usanfo Funciones**

#R contiene diversas funciones intregradas
#su sintaxis es de la forma:

nombre_de_la_funcion(arg=val1, arg2=val2, ...)


#Un ejemplo de ellas, es la siguiente:
seq(1,10)

# R nos puede ayudar a autocompletar, por ejemplo
#con las comillas:

x <- "hola mundo"

#puede ocurrir que nos enredemos y terminemos con 
#una disparidad. Si esto ocurre R te mostrará el
#caracter de continuación “+”

#El + te indica que R está esperando que completes
#la instrucción; no cree que hayas terminado.
#Usualmente esto implica que olvidaste escribir " o ). 
#Puedes agregar el caracter par faltante o presionar 
#ESCAPE para abandonar la expresión y escribirla de nuevo.

z <- "hola" #quitar comilla al final para que al correr
#se muestre el signo +

#Cuando realizas una asignación no se imprime en la consola 
#el valor asignado. Es una tentación confirmar inmediatamente
#el resultado:

y <- seq(1,10,length.out=5)
y


#Esta acción común puede acortarse rodeando la instrucción con 
#paréntesis, lo que resulta en una asignación e “impresión en
#la pantalla”.

(y <- seq(1,10 ,length.out=5))

#---------------------------------------------------------------

# ** Sección 4.4 EJercicios**

#1.¿Por qué no funciona este código?

mi_variable <- 10
mi_varıable

#R. Debido a que el caracter i e ı, son distintos por lo que R
# no reconoce la variable que se creo

#---------------------------------------------------------------

#2. Modifica cada una de las instrucciones de R a continuación para
#que puedan ejecutarse correctamente:

library(tidyverse)

ggplot(dota = millas) + 
  geom_point(mapping = aes(x = cilindrada, y = autopista))

fliter(millas, cilindros = 8)
filter(diamante, quilate > 3)

#CORRECCIÓN

install.packages("datos")

library(tidyverse)
library(datos)

millas

ggplot(data = millas) + 
  geom_point(mapping = aes(x = cilindrada, y = autopista))

filter(millas, cilindros == 8)
filter(diamante, quilate > 3)


#---------------------------------------------------------------

#3.Presiona Alt + Shift + K. ¿Qué ocurrió? ¿Cómo puedes llegar al
#mismo lugar utilizando los menús?

#Con el teclado Ctrl + 10

#---------------------------------------------------------------



