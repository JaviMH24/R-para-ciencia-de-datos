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


#3.2.4 Mapeos estéticos

#El mapeo entre las propiedades estéticas de tu gráfico y las variables
#de tu dataset te permite comunicar información sobre tus datos. 
#Por ejemplo, puedes asignar los colores de los puntos de acuerdo 
#a la variable clase para indicar a qué clase pertenece cada automóvil.

ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada, y=autopista, color=clase))

#Tambien podemos cambiarla transperencia de puntos para clasficarlos o tambien
#la forma de los puntos

ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada, y=autopista, alpha=clase))


ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada, y=autopista, shape =clase))

# ggplot2 solo puede usar seis formas a la vez. De forma predeterminada,
#los grupos adicionales no se grafican cuando se emplea la estética
#de la forma (shape).


#Si solo se desea cambiar elcolordelgrafico, el comando color va afuera de la funcion aes

ggplot(data=millas)+
  geom_point(mapping = aes(x=cilindrada, y=autopista), color="blue")
 
#3.3.1 Ejercicios

#1. ¿Qué no va bien en este código? ¿Por qué hay puntos que no son azules?

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = "blue"))

#R. Debido a que la funcion codigo se encuentra dentro de la capa aes,
# la variable blue juega el papel de una categoria y no como una caracteristica.

#-------------------------------------------------------------------------------

#2. ¿Qué variables en millas son categóricas? ¿Qué variables son continuas?
#(Pista: escribe ?millas para leer la documentación de ayuda para este conjunto
#de datos). ¿Cómo puedes ver esta información cuando ejecutas millas?

?millas

#De esta forma podemos ver el tipo de datos que contiene el dataframe
#Aunque tambien los puedes visualizar desde la tabla
str(millas)

#-------------------------------------------------------------------------------

#3. Asigna una variable continua a color, size, y shape. ¿Cómo se comportan
#estas estéticas de manera diferente para variables categóricas y
#variables continuas?

#ejemplo de categorica
ggplot(data=millas)+
  geom_point(mapping=aes(x=fabricante,y=modelo, color=ciudad))

#ejemplo de continua
ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada,y=autopista, size = ciudad))

ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada,y=autopista, shape=ciudad))


#Para la ultima grafica. no se muestra algun dato

#-------------------------------------------------------------------------------

#5. ¿Qué hace la estética stroke? ¿Con qué formas trabaja?
#(Pista: consulta ?geom_point)

?geom_point

ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada,y=autopista, stroke=.1))

#R. La estetica stroke cambia el tamaño de la forma que representa a los datos

#-------------------------------------------------------------------------------


#6. ¿Qué ocurre si se asigna o mapea una estética a algo diferente
#del nombre de una variable, como aes(color = cilindrada < 5)?

ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada,y=autopista, color = cilindrada < 5))

#R. Genera una clasificación tipo booleana, donde la condicionimpuesta a la
#variable cilindrada, tendra un colo diferente para valores menores que 5, y 
#otro color, para valores mayores que 5


