CREATE TABLE sismos (
    id SERIAL PRIMARY KEY,
    Magnitud NUMERIC,
    Latitud DOUBLE PRECISION,
    Longitud DOUBLE PRECISION,
    Profundidad NUMERIC,
    Municipio VARCHAR(100),
    Zona VARCHAR(100),
    Mes INTEGER,
    Placa VARCHAR(20),
    Anio INTEGER
);

select * from sismos;

copy sismos(Magnitud, Latitud, Longitud, Profundidad, Municipio, Zona, Mes, Placa, Anio)
FROM 'C:/Users/Usuario/Documents/scidata/24_01_aabd/sismos/sismos.csv'
DELIMITER ',' CSV HEADER;

select count(*) from sismos;


----------------
----------------
----------------

-- 1. Seleccionar todos los sismos con magnitud mayor o igual a 7:
SELECT * FROM sismos WHERE magnitud >= 7; -- Alejandro
SELECT count(*) FROM sismos WHERE magnitud >= 7; -- Alejandro

-- 2. Contar la cantidad de sismos registrados en la zona Centro sur en el año 2021
SELECT COUNT(*) FROM sismos WHERE zona = 'Centro sur' AND anio = 2021;
SELECT COUNT(*) FROM sismos WHERE zona ilike 'centro sur' AND anio = 2021;

select DISTINCT(zona) from sismos;

-- 3. Obtener la magnitud promedio de los sismos registrados los meses de mayo

select DISTINCT(mes) from sismos;
select avg(magnitud) from sismos where mes = 5;

-- 4. Mostrar los municipios donde se registraron sismos con profundidad mayor a 200km
SELECT distinct(municipio) FROM sismos WHERE profundidad > 200; -- Juan José
SELECT count(distinct(municipio)) FROM sismos WHERE profundidad > 200; -- Juan José

--- Veamos las placas de los municipios anteriores
SELECT distinct(municipio), placa FROM sismos WHERE profundidad > 200; -- Juan José

-- 5. Listar los sismos ocurridos en la placa de Norteamerica durante el 2020
select * from sismos where anio = 2020 and placa ilike 'Norte%';

-- 6. Listar los sismos ocurridos en el estado de Puebla
select * from sismos where municipio ILIKE '%, PUE'; -- Juan José, Andrea, Elías
select * from sismos where right(municipio,3) ilike 'PUE';

-- 7. ¿Cuántos sismos ocurrieron en la región Sureste en diciembre de 2017
select municipio from sismos where zona = 'Sureste' and anio=2017 and mes=12; --- Juan José

-- 8. Mostrar los sismos con magnitud entre 5 y 6 durante 2019
SELECT * FROM sismos WHERE Magnitud BETWEEN 5 AND 6 AND anio=2019; --- Patricia, Daniela
SELECT * FROM sismos WHERE Magnitud >= 5 AND Magnitud <= 6 and anio=2019; --- Patricia, Daniela

-- 9. Obtener la profundidad máxima registrada en el municipio de Acapulco

select distinct(municipio) from sismos where municipio ilike 'Acapulco%';
select max(profundidad) from sismos where municipio ilike 'Acapulco%';

-- 10. Listar los sismos ocurridos durante julio de 2020 en orden descendente de magnitud
SELECT * FROM sismos WHERE mes = 7 and anio = 2020 ORDER BY MAGNITUD DESC; -- Elías y Yoshua

-- 11. Calcula la magnitud mínima, promedio y máxima por entidad
select right(municipio,4) as entidad,
	min(magnitud) AS MINIMO, 
	avg(magnitud) AS PROMEDIO, 
	max(magnitud) AS MAXIMO
from sismos group by entidad ORDER BY PROMEDIO DESC;

CREATE TABLE ESTADISTICAS_ENTIDADES AS  
select right(municipio,4) as entidad,
	min(magnitud) AS MINIMO, 
	avg(magnitud) AS PROMEDIO, 
	max(magnitud) AS MAXIMO
from sismos group by entidad ORDER BY PROMEDIO DESC;

SELECT * FROM ESTADISTICAS_ENTIDADES

----------------
---------------- Sesión 10 continuación de práctica
----------------

select * from sismos;

--- 12. Calcula la magnitud mínima, promedio y máxima por enidad durante los últimos 10 años

select right(municipio,4) as entidad,
	min(magnitud) as minimo,
	avg(magnitud) as promedio,
	max(magnitud) as maximo
from sismos
where anio >= 2012
group by entidad;
	
----- En R 
--- sismos %>% 
----	filter(anio >= 2012) %>% 
----	group_by(right(municiopio,4)) %>% 
----	summary(promedio = mean(magnitud),maximo = max(magnitud),minimo = min(magnitud))  %>%
----    ungroup()

--- 13. Guardar la consulta anterior como una tabla nueva	

CREATE TABLE resumen_2012_2022 AS
select right(municipio,4) as entidad,
min(magnitud) as minimo,
avg(magnitud) as promedio,
max(magnitud) as maximo
from sismos
where anio >= 2012
group by entidad;

select * from resumen_2012_2022 order by promedio desc;

----- Muestra el renglón de Oaxaca donde la magnitud fue 7.4

SELECT * FROM sismos WHERE municipio ilike '%OAX%' and magnitud=7.4;

---- Muestra el gran sismo que ocurrió en México en septiembre de 2017

select * from sismos where mes = 9 and anio = 2017 and magnitud > 7;

---- 14. Exporta a csv la tabla del ejercicio 13.

select * from resumen_2012_2022;

copy resumen_2012_2022 to 'C:/Users/Public/Desktop/minitabla_2.csv' with csv header;







