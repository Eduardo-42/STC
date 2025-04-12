--#Uso de la base de datos;
USE p1scdmx;
--# Se importaron los datos y se comenzo la limpieza de los mismos
select * from delitos;

select distinct alcaldia from delitos;
--# Se unificaron los nombres de las ALCALDIAS para generar relaciones
UPDATE delitos set alcaldia = REPLACE(alcaldia,".","");
UPDATE delitos set alcaldia = REPLACE(alcaldia," ","_");
UPDATE delitos set alcaldia = UPPER(alcaldia);


--#Se quitaron NULLS por NO_IDENTIFICADOS
UPDATE delitos set alcaldia = 'NO_IDENTIFICADA' WHERE alcaldia = '';

--#SE PULIO LOS DATOS
select * from alcaldiasstc;
select distinct alcaldias from alcaldiasstc;
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,".","");
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias," ","_");
select distinct alcaldias from alcaldiasstc where alcaldias like "%/%";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias," ","_");
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"/_Venustiano_Carranza","");
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"/_Iztacalco","");
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"/_Miguel_Hidalgo","");
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"/_Coyoacan","");
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"/_Cuauhtemoc","");

select distinct alcaldias from alcaldiasstc where alcaldias like "%ro_"; 
select distinct alcaldias from alcaldiasstc where alcaldias like "%a_";
select distinct alcaldias from alcaldiasstc where alcaldias like "%n_";
select distinct alcaldias from alcaldiasstc where alcaldias like "%z_";

UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"_","") where alcaldias like "%ro_"; 
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"_","") where alcaldias like "%a_";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"_","") where alcaldias like "%n_";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"_","") where alcaldias like "%z_";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"_","") where alcaldias like "%c_";


UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"GustavoAMadero","Gustavo_A_Madero") where alcaldias like "GustavoAMadero"; 
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"alvaroObregon","alvaro_Obregon") where alcaldias like "alvaroObregon";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"BenitoJuarez","Benito_Juarez") where alcaldias like "BenitoJuarez";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"VenustianoCarranza","Venustiano_Carranza") where alcaldias like "VenustianoCarranza";
UPDATE alcaldiasstc set alcaldias = REPLACE(alcaldias,"_-_","_");

UPDATE alcaldiasstc set alcaldias = UPPER(alcaldias);

--#Se elminiraon caracteres diferentes
select * from usestc;
select distinct estacion from usestc;
UPDATE usestc set estacion = REPLACE(estacion,"ÃƒÂ©","e");
UPDATE usestc set estacion = REPLACE(estacion,"ÃƒÂ¡","a");
UPDATE usestc set estacion = REPLACE(estacion,"ÃƒÂ³","o");
UPDATE usestc set estacion = REPLACE(estacion,"ÃƒÂº","u");
UPDATE usestc set estacion = REPLACE(estacion,"ÃƒÂ±","n");
UPDATE usestc set estacion = REPLACE(estacion,"ÃƒÂ­","i");

select distinct(NOMBRE) from alcaldiasstc;
select distinct estacion from usestc;

select * from alcaldiasstc;
select * from usestc;

--# Se elimino la palabra linea para unificar con alcaldias
update usestc SET linea = REPLACE(linea, "Linea ", "");

select * from delitos;

select * from usestc;

--# Se generaron INDEX
ALTER TABLE delitos 
ADD FOREIGN KEY (alcaldia) REFERENCES alcaldiasstc(ALCALDIAS);

ALTER TABLE delitos ADD INDEX delitos_alcaldias (alcaldia ASC);
ALTER TABLE delitos ADD INDEX delitos_ibfk_1 (idDelitos ASC);

ALTER TABLE alcaldiasstc ADD INDEX delitos_alcaldias (ALCALDIAS ASC);

-- Se generaron Referencias
alter table alcaldiasstc
ADD FOREIGN KEY (LINEA) REFERENCES usestc(linea);

--# Se visualizaron las tablas por que se importaron con diferente formato utf-8
SHOW CREATE TABLE alcaldiasstc;
SHOW CREATE TABLE usestc;

select * from alcaldiasstc;


--#Se unifico utf8
ALTER TABLE usestc
MODIFY linea VARCHAR(45) CHARACTER SET utf8mb3_spanish2_ci NOT NULL;


CREATE INDEX idx_linea ON usestc(linea);
--#Se crearon constraints
ALTER TABLE alcaldiasstc
ADD CONSTRAINT alcaldiasstc_ibfk_1
FOREIGN KEY (LINEA)
REFERENCES usestc(linea);


--# Se visualizaron ambas tablas para unificar utf8
SHOW CREATE TABLE alcaldiasstc;
SHOW CREATE TABLE usestc;
SHOW CREATE TABLE delitos;

alter table alcaldiasstc
ADD FOREIGN KEY (ALCALDIAS) REFERENCES delitos(alcaldia);

SELECT DISTINCT ALCALDIAS
FROM alcaldiasstc
WHERE ALCALDIAS NOT IN (SELECT alcaldia FROM delitos);

--#Se encontro un detalle que requeria mover para homogenizar las relaciones en las tables
select * from alcaldiasstc WHERE ALCALDIAS = 'ESTADO_DE_MEXICO_NAUCALPAN_DE_JUAREZ';
select * from alcaldiasstc WHERE LINEA = '2';

UPDATE alcaldiasstc SET ALCALDIAS = 'MIGUEL_HIDALGO' WHERE ALCALDIAS = 'ESTADO_DE_MEXICO_NAUCALPAN_DE_JUAREZ';


--################################################Aqui inicia la exploracion de datos para consulta##############################
--## Alcaldias y Metro
select * from alcaldiasstc;
--## Numero de estaciones por alcaldia
select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY t1.ALCALDIAS;

select NOMBRE, LINEA, ALCALDIAS from alcaldiasstc;

--###DELITOS

select * from delitos;

--#Tipos de delito

select Distinct delito from delitos; 
--#Robo a pasajero a bordo del Metro

select * from delitos WHERE delito = 'Robo a pasajero a bordo del Metro';

select SUM(current_month), delitos.year, alcaldia FROM delitos WHERE delito = 'Robo a pasajero a bordo del Metro' GROUP BY year, alcaldia ORDER BY alcaldia, year ASC;

--#Curiosamente no hay delitos en XOCHIMILCO, TLALPAN y MILPAALTA
--# No hay datos despues del 2021\

--# Corregido retiramos delitos de XOCHIMILCO, TLALPAN Y MILPAALTA y NO RECONOCIDOS

select SUM(d.current_month), d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' GROUP BY year, d.alcaldia ORDER BY d.alcaldia, d.year ASC;

--#  Obtenemos que Cuauhtemoc es la delegacion que hay mas robos pero hay mas estaciones -realicemos un analisis de densida de robos por cantidad de estaciones y 
--# Descubrimos que las delegaciones con mas robo por estacion son IZTACALCO, CUAUHTEMOC, BENITO_JUAREZ, VENUSTIANO_CARRANZA, MIGUEL_HIDALGO del año 2019


select SUM(d.current_month), d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' GROUP BY year, d.alcaldia ORDER BY Densidad DESC;

--#Se acoto la busqueda al 2021 para que haga join con el uso del metro de ese año

select SUM(d.current_month), d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' and d.year > 2020 GROUP BY year, d.alcaldia ORDER BY Densidad DESC;

-----# Exploremos el Usestc

select * from usestc stc order by year;
select * from usestc stc where year = 2021 order by year;

select stc.year, linea, estacion, SUM(afluencia) AS afluencia_total from usestc stc where stc.year = 2021 group by stc.year, linea, estacion order by year;

--  Unamos las tablas en relacion alcaldias - Estacion - delitos - afluencia

select stc.year, linea, estacion, SUM(afluencia) AS afluencia_total from usestc stc where stc.year = 2021 group by stc.year, linea, estacion order by year;

select SUM(d.current_month) as delitos_year, d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' and d.year > 2020 GROUP BY year, d.alcaldia ORDER BY Densidad DESC;


select alc.NOMBRE, alc.LINEA, alc.ALCALDIAS, delitos_year, Densidad_delitos  from alcaldiasstc alc 
INNER JOIN 
(select SUM(d.current_month) as delitos_year, d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad_delitos FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' and d.year > 2020 GROUP BY year, d.alcaldia) summDelitos 
ON summDelitos.alcaldia = alc.ALCALDIAS;

--####################################################################################################################

select alc.NOMBRE, alc.ALCALDIAS, delitos_year AS Delitos_DEL, QTY_EST_DEL, Densidad_delitos as DelitosXEstacion, SUM(stcAfluencia.afluencia_total)  from alcaldiasstc alc 
INNER JOIN 
(select SUM(d.current_month) as delitos_year, d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES AS QTY_EST_DEL, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad_delitos FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' and d.year > 2020 GROUP BY year, d.alcaldia) summDelitos 
ON summDelitos.alcaldia = alc.ALCALDIAS

INNER JOIN 

(select stc.year, linea, estacion, SUM(afluencia) AS afluencia_total from usestc stc where stc.year = 2021 group by stc.year, linea, estacion) stcAfluencia

ON stcAfluencia.estacion = alc.NOMBRE GROUP BY alc.NOMBRE, alc.ALCALDIAS, Delitos_DEL, QTY_EST_DEL, DelitosXEstacion;




select alc.NOMBRE, alc.ALCALDIAS, delitos_year AS Delitos_DEL, QTY_EST_DEL, Densidad_delitos as DelitosXEstacion, 
SUM(stcAfluencia.afluencia_total) AS Afluencia_total, Densidad_delitos / SUM(stcAfluencia.afluencia_total) AS prob_Delito_Usr, ROUND(Densidad_delitos / SUM(stcAfluencia.afluencia_total) * 1000000, 2) AS prob_Delito_MillonUsr 
from alcaldiasstc alc 
INNER JOIN 
(select SUM(d.current_month) as delitos_year, d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES AS QTY_EST_DEL, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad_delitos FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' and d.year > 2020 GROUP BY year, d.alcaldia) summDelitos 
ON summDelitos.alcaldia = alc.ALCALDIAS

INNER JOIN 

(select stc.year, linea, estacion, SUM(afluencia) AS afluencia_total from usestc stc where stc.year = 2021 group by stc.year, linea, estacion) stcAfluencia

ON stcAfluencia.estacion = alc.NOMBRE GROUP BY alc.NOMBRE, alc.ALCALDIAS, Delitos_DEL, QTY_EST_DEL, DelitosXEstacion;

-- # generamos una Vista para acotar tiempo de ejecucion.

CREATE VIEW PROB_DEL_METRO AS 
 
 select alc.NOMBRE, alc.ALCALDIAS, delitos_year AS Delitos_DEL, QTY_EST_DEL, Densidad_delitos as DelitosXEstacion, 
SUM(stcAfluencia.afluencia_total) AS Afluencia_total, Densidad_delitos / SUM(stcAfluencia.afluencia_total) AS prob_Delito_Usr, ROUND(Densidad_delitos / SUM(stcAfluencia.afluencia_total) * 1000000, 2) AS prob_Delito_MillonUsr 
from alcaldiasstc alc 
INNER JOIN 
(select SUM(d.current_month) as delitos_year, d.year, alcaldia, TAlcSCT.CANTIDAD_ESTACIONES AS QTY_EST_DEL, SUM(d.current_month)/TAlcSCT.CANTIDAD_ESTACIONES AS Densidad_delitos FROM delitos d
INNER JOIN 
(select count(t1.NOMBRE) AS CANTIDAD_ESTACIONES, t1.ALCALDIAS FROM (select distinct NOMBRE, ALCALDIAS from alcaldiasstc)t1 GROUP BY ALCALDIAS)TAlcSCT

ON  TAlcSCT.ALCALDIAS = d.alcaldia 

WHERE d.delito = 'Robo a pasajero a bordo del Metro' and d.year > 2020 GROUP BY year, d.alcaldia) summDelitos 
ON summDelitos.alcaldia = alc.ALCALDIAS

INNER JOIN 

(select stc.year, linea, estacion, SUM(afluencia) AS afluencia_total from usestc stc where stc.year = 2021 group by stc.year, linea, estacion) stcAfluencia

ON stcAfluencia.estacion = alc.NOMBRE GROUP BY alc.NOMBRE, alc.ALCALDIAS, Delitos_DEL, QTY_EST_DEL, DelitosXEstacion;




select * from PROB_DEL_METRO;
