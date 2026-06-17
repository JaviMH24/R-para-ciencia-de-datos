#3.2 Primeros pasos

library(datos) #De esta manera se importa una libreria

#3.2.1 Cargando una base de datos en R

millas  #llamamos a un data frame que aparece en "datos"


#3.2.2 Crear un gráfico en ggplot

#De esta manera graficamos datos con ggplot

ggplot(data=millas)+
  geom_point(mapping= aes(x=cilindrada, y=autopista))

# 3.2.3 Una plantilla de gráficos

#De forma general, la sintaxis para crear una plantilla de graficos
# Es de la siguiente manera: (no correr)

ggplot(data = <DATOS>) +
  <GEOM_FUNCIÓN>(mapping = aes(<MAPEOS>))

#3.2.4 Ejercicios

#---------------------------------------

#1. Ejecuta ggplot(data = millas). ¿Qué observas?

ggplot(data=millas)

# R: No se visualiza nada al correrlo

#---------------------------------------

# 2. ¿Cuántas filas hay en millas?
#¿Cuántas columnas?

#R: La tabla contiene 234 filas por 11 columnas

#---------------------------------------

#3. ¿Qué describe la variable traccion? 
#Lee la ayuda de ?millas para encontrar la respuesta.

?millas

#R: Describe el tipo de traccion que es
#d=delantera, t=trasera, ruedas=4 ruedas

#---------------------------------------

#4.Realiza un gráfico de dispersión 
#de autopista versus cilindros.

ggplot(data=millas)+
  geom_point(mapping = aes(x=autopista, y=cilindrada))


#---------------------------------------

#5. ¿Qué sucede cuando haces un gráfico de dispersión 
#(scatterplot) de clase versus traccion?
#¿Por qué no es útil este gráfico?

ggplot(data=millas)+
  geom_point(mapping=aes(x=clase, y=traccion))

#R. En particular, ya que las dos variables que se
#desean comparar, son de tipo character

#---------------------------------------