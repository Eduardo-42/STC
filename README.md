# STC
Estadisticas del metro y probabilidad de delitos en el mismo.

<h3>Como surge</h3>

El objetivo de este proyecto pretende responder la pregunta: ¿Que tan probable es tener un delito dentro de una estación del metro?

Con datos obtenidos a partir del gobierno de la ciudad de Mexico.

<a href="https://datos.cdmx.gob.mx/"> Datos del gobierno de la CDMX </a>
![image](https://github.com/user-attachments/assets/12ac299d-a55d-4043-a88c-a1f7fa36b98d)


<h3>Como se Hizo</h3>

Se extrajeron 3 datasets.

<ul>
  <li type="circle">Datos de los delitos en la ciudad de Mexico</li>
  <li type="circle">Datos de la afluencia en el sistema metro (STC)</li>
  <li type="circle">Distribucion geografica de las estaciones ubicadas por delegacion</li>
</ul>


Los datos fueron cargados en una base de datos con tres tablas relacionadas entre si.

<ul>
  <li type="circle"><b>alcaldiasstc</b> Guarda la relacion alcaldia estacion STC</li>
  <li type="circle"><b>delitos</b> Relacion delitos y alcaldia</li>
  <li type="circle"><b>usestc</b>Afluencia por estacion del metro</li>
</ul>

Se limpiaron los datos y se encontro una relacion de los datos de delitos y afluencia del metro en el año 2021
debido a que ambos data set se encuentran sesgados

Concluyendo este acomo de datos se genero una vista para generar un data set en relacion de la Estacion, alcaldia, Delitos al año, afluencia y probabilidad de delito al año.

<h3>Algunas visualizaciones</h3>

<b>TOP 10</b> 

|index|NOMBRE|ALCALDIAS|Delitos\_DEL|QTY\_EST\_DEL|DelitosXEstacion|Afluencia\_total|prob\_Delito\_Usr|prob\_Delito\_MillonUsr|
|---|---|---|---|---|---|---|---|---|
|32|Parque de los Venados|BENITO\_JUAREZ|53|18|2\.9444|567984|5\.18e-06|5\.18|
|25|Hospital 20 de Noviembre|BENITO\_JUAREZ|53|18|2\.9444|593128|4\.96e-06|4\.96|
|23|Eje Central|BENITO\_JUAREZ|53|18|2\.9444|664899|4\.43e-06|4\.43|
|27|Lomas Estrella|IZTAPALAPA|36|15|2\.4|545971|4\.4e-06|4\.4|
|37|Tlaltenco|TLAHUAC|6|5|1\.2|301594|3\.98e-06|3\.98|
|34|San Andres Tomatlan|IZTAPALAPA|36|15|2\.4|628588|3\.82e-06|3\.82|
|9|Juanacatlan|MIGUEL\_HIDALGO|88|13|6\.7692|1859621|3\.64e-06|3\.64|
|0|Balbuena|VENUSTIANO\_CARRANZA|152|20|7\.6|2246042|3\.38e-06|3\.38|
|42|Colegio Militar|MIGUEL\_HIDALGO|88|13|6\.7692|2118471|3\.2e-06|3\.2|
|4|Cuauhtemoc|CUAUHTEMOC|324|30|10\.8|4054718|2\.66e-06|2\.66|

<b>BOXPLOT Alcaldia </b> 

![image](https://github.com/user-attachments/assets/27a7d070-c080-4761-8d81-dbd498ba9a81)


<b>Scatter PLot Total </b> 

![image](https://github.com/user-attachments/assets/cd3284bb-7054-49c9-823c-95cba989f3a1)




