#3.2 **Primeros pasos**

library(datos) #De esta manera se importa una libreria
library(ggplot2)

#3.2.1 Cargando una base de datos en R

millas  #llamamos a un data frame que aparece en "datos"


#3.2.2 **Crear un gráfico en ggplot**

#De esta manera graficamos datos con ggplot

ggplot(data=millas)+
  geom_point(mapping= aes(x=cilindrada, y=autopista))

# 3.2.3 **Una plantilla de gráficos**

#De forma general, la sintaxis para crear una plantilla de graficos
# Es de la siguiente manera: (no correr)

ggplot(data = <DATOS>) +
  <GEOM_FUNCIÓN>(mapping = aes(<MAPEOS>))

#3.2.4 **Ejercicios**

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


#3.2.4 **Mapeos estéticos**

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
 
#3.3.1 **Ejercicios**

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

#3.4 **Problemas Comunes**

#Un problema común al crear gráficos con ggplot2 es colocar el + en el lugar equivocado: debe ubicarse al final de la línea, 
#no al inicio. En otras palabras, asegúrate de no haber escrito accidentalmente 
#un código como este:

ggplot(data = millas)
+ geom_point(mapping = aes(x = cilindrada, y = autopista))

#3.5 **Separar en facetas**

#Otra forma particularmente útil para las variables categóricas consiste
#en dividir el gráfico en facetas, es decir, sub-gráficos que
# muestran cada uno un subconjunto de los datos.

#Para separar en facetas un gráfico según una sola variable,
#utiliza facet_wrap() (del inglés envolver una faceta).  La variable que uses
#en facet_wrap() debe ser categórica. De la siguiente forma:


ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista)) +
  facet_wrap(~ clase, nrow=2) #Aqui clase es la variable categorica en la que se
#subdividen los graficos.


#Para separar en facetas un gráfico según las combinaciones
#de dos variables, agrega facet_grid(). Esta vez, la fórmula
#debe contener dos nombres de variables separados por un ~.

ggplot(data=millas)+
  geom_point(mapping = aes(x=cilindrada,y=autopista))+
  facet_grid(traccion ~ cilindros )

#Si prefieres no separar en facetas las filas o columnas, remplaza por un . 
#el nombre de alguna de las variables, por ejemplo + facet_grid(. ~ cilindros).

ggplot(data=millas)+
  geom_point(mapping = aes(x=cilindrada,y=autopista))+
  facet_grid(. ~ cilindros)


#3.5.1 **Ejercicios**

#1. ¿Qué ocurre si intentas separar en facetas una variable continua?


ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada,y=autopista))+
  facet_wrap(~ciudad, nrow=2)


ggplot(data=millas)+
  geom_point(mapping=aes(x=cilindrada,y=autopista))+
  facet_grid(. ~ ciudad)

#R. Si bien no existe algun error al correr la linea de codigo, la visualizacion
#de las graficas generan una clasificacion por cada valor de la variable continua
#Para este ejemplo, la visualizacion es correcta, pero si se tiene una variable con
#valores de 0 a 1000 la grafica no se distinguiria de buena forma.

#---------------------------------------------------------------------------------

#2. ¿Qué significan las celdas vacías que aparecen en el gráfico generado usando 
#facet_grid(traccion ~ cilindros)?

millas

ggplot(data=millas)+
  geom_point(mapping = aes(x=cilindrada,y=autopista))+
  facet_grid(traccion ~ cilindros)

#R.Se refiere a que no existeun auto con cilindrada de 4 y 5 cilindros 
#para recorrer de 20 a 40km con traccion t

#¿Cómo se relacionan con este gráfico?

ggplot(data = millas) +
  geom_point(mapping = aes(x = traccion, y = cilindros))

#R. Es la misma conclusion a la que se llega. ya que no hya puntos en los valores de
#t para 4,5 y 6 cilindros

#---------------------------------------------------------------------------------

#3. ¿Qué grafica el siguiente código? ¿Qué hace . ?

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista)) +
  facet_grid(traccion ~ .)

#R. Clalsifica los valores de cilindrada vs autopista en relación con su
#tracción. Las graficas aparecen en filas


ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista)) +
  facet_grid(. ~ cilindros)

#R. Clasifica los valores de cilindrada vs autopista en relación con los
#cilindros. Las graficas aparecen en columnas

#---------------------------------------------------------------------------------


#3.6 **Objetos Geométricos**

#Un geom es el objeto geométrico usado para representar datos de forma gráfica. 
#La gente a menudo llama a los gráficos por el tipo de geom que utiliza.

#Para cambiar el geom del gráfico, se modifica la función geom que acompaña a ggplot()

# izquierda
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista))

# derecha
ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista))

#Podemos cambiar el estilo de la linea, agregand un argumento sobre el plano aes

ggplot(data=millas)+
  geom_smooth(mapping = aes(x=cilindrada, y=autopista, linetype = traccion))

#Muchos geoms, como geom_smooth(), usan un único objeto geométrico para mostrar
#múltiples filas de datos. Con estos geoms, puedes asignar la estética 
#de group (grupo) a una variable categórica para graficar múltiples objetos

ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista))

ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista, group = traccion))

ggplot(data = millas) +
  geom_smooth(
    mapping = aes(x = cilindrada, y = autopista, color = traccion),
    show.legend = TRUE
  )


#Para mostrar múltiples geoms en el mismo gráfico,
#agrega varias funciones geom a ggplot()

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista))+
  geom_smooth(mapping = aes(x = cilindrada, y = autopista))

#Si se desea modificar una variable, deberas cambiarla en los dos tipos de geometria
#pero existe una opcion que reduce el trabajo de la siguiente manera;

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point() +
  geom_smooth()

#Si colocas mapeos en una función geom, ggplot2 los tratará como mapeos locales
#para la capa. Estas asignaciones serán usadas para extender o sobrescribir 
#los mapeos globales solo para esa capa. Esto permite mostrar diferentes
#estéticas en diferentes capas.


ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point(mapping = aes(color = clase)) +
  geom_smooth()


#La misma idea se puede emplear para especificar distintos conjuntos de datos 
#(data) para cada capa. En el siguiente caso, nuestra línea suave muestra
#solo un subconjunto del conjunto de datos de millas: los autos subcompactos.
#El argumento local de datos en geom_smooth() anula el argumento de datos
#globales en ggplot() solo para esa capa.

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point(mapping = aes(color = modelo)) +
  geom_smooth(data = filter(millas, clase == "subcompacto"), se = FALSE)



#3.6.1 **Ejercicios**


#1. ¿Qué geom usarías para generar un gráfico de líneas?
#¿Y para un diagrama de caja? ¿Y para un histograma? 
#¿Y para un gráfico de área?

ggplot(data=millas, mapping = aes(x=cilindrada, y=autopista))+
  geom_line()


ggplot(data=millas, mapping = aes(x=cilindrada, y=autopista))+
  geom_boxplot()


ggplot(data=millas, mapping = aes(x=fabricante, y=traccion))+
  geom_histogram()

ggplot(data=millas, mapping = aes(x=cilindrada, y=autopista))+
  geom_area()

#---------------------------------------------------------------------------

#2. Ejecuta este código en tu mente y predice cómo se verá el output.
#Luego, ejecuta el código en R y verifica tus predicciones.

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista, color = traccion)) +
  geom_point() +
  geom_smooth(se = TRUE)

#R. El grafico arrojara la geometria de puntos, una linea suave, donde se representa
#si se desea o no colocar esa region de confianza para cada linea.


#---------------------------------------------------------------------------

#3. ¿Qué muestra show.legend = FALSE? ¿Qué pasa si lo quitas? 
#¿Por qué crees que lo utilizamos antes en el capítulo?

#R.Se utiliza esa linea de codigo para eliminar la leyenda o las etiquetas
#de la variable que se desea analizar. Se utilizo en el capitulo, ya que a veces
#deseamos omitir este dato, ya que se tiene por entendido del tipo de dato que 
#estamos utilizando.

#---------------------------------------------------------------------------

#4. ¿Qué hace el argumento se en geom_smooth()?

#R. esta pregunta se respondio en  2

#---------------------------------------------------------------------------

#5. ¿Se verán distintos estos gráficos? ¿Por qué sí o por qué no?

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point() +
  geom_smooth()


ggplot() +
  geom_point(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_smooth(data = millas, mapping = aes(x = cilindrada, y = autopista))


#R. Son los mismos graficos, solo que el primer bloqu de codigo esta
#mas simplificado que el segundo.

#---------------------------------------------------------------------------

#6. Recrea el código R necesario para generar los siguientes gráficos:

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point() +
  geom_smooth()

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point() +
  geom_smooth(mapping = aes(group=traccion) , se=FALSE)

ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista, color=traccion)) +
  geom_point() +
  geom_smooth(se=FALSE)


ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point(mapping=aes(color=traccion)) +
  geom_smooth( )


ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point(mapping=aes(color=traccion)) +
  geom_smooth( mapping=aes(linetype=traccion))

ggplot(data = millas) +
  geom_point(
    mapping = aes(x = cilindrada, y = autopista, fill = traccion),
    shape = 21,        # círculo con borde y relleno
    color = "white",   # contorno blanco
    size = 3           # tamaño de los puntos
  )

#3.7 Transformaciones estadisticas


#Las transformaciones estaditicas nos ayudan a convertir datos que se pueden encontrar
#tablas de datos a graficos de forma sencilla. Primero analizemos los graficos de barras


#diamantes es un conjunto de datos que aparece en la libreria datos

ggplot(data=diamantes)+
  geom_bar(mapping=aes(x=corte))

#Aqui la variable count que aparece al visualizar el grafico, no es del propio datasheet.
#Esto lo genera de forma automatica R, ya que muchos gráficos, como los diagramas de 
#dispersión (scatterplots), grafican los valores brutos de un conjunto de datos.


#Los gráficos de barras, los histogramas y los polígonos de frecuencia almacenan los datos
#o grafican los conteos por contenedores (bins), es decir, el número de puntos que caen
#en cada contenedor.

#Los gráficos de líneas suavizadas (smoothers) ajustan un modelo a los datos y luego 
#grafican las predicciones del modelo.

#Los diagramas de caja (boxplots) calculan un resumen robusto de la distribución y
#luego muestran una caja con formato especial.

#El algoritmo utilizado para calcular nuevos valores para un gráfico se llama stat,
# abreviatura en inglés de transformación estadística (statistical transformation).

?geom_bar



#Por lo general, puedes usar geoms y estadísticas de forma intercambiable. Por ejemplo, 
#puedes volver a crear la gráfica anterior usando stat_count() en lugar de geom_bar()


ggplot(data=diamantes)+
  stat_count(mapping=aes(corte))

#Es posible que desees anular el mapeo predeterminado de las variables transformadas a 
#las estéticas. Por ejemplo, es posible que desees mostrar un gráfico de barras de 
#proporciones, en lugar de un recuento

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, y = stat(prop), group = 1))

?stat_bin






