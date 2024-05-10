-- Crear una tabla llamada mi_primer_tabla de dos columnas en la base de datos mi_primer_base.
-- La primer columna se llama columna1 y únicamente aceptará textos de a lo más 20 caracteres
-- La segunda columna se llama columna2 y únicamente aceptará número enteros

create table mi_primer_tabla(columna1 varchar(20),columna2 int);

-- Añadí dos filas
insert into mi_primer_tabla VALUES ('Héctor Manuel',3),('Roberto',20);

-- Aquí voy a observar la tabla
--

insert into mi_primer_tabla VALUES ('Luis');

select * from mi_primer_tabla;

--
--- drop table mi_primer_tabla

------------------- Sesión 03

create table mi_segunda_tabla(apellido varchar(50), matricula char(10), calif int);

insert into mi_segunda_tabla values ('Héctor',10,'1234567890');

insert into mi_segunda_tabla values ('Manuel');

insert into mi_segunda_tabla(matricula) values ('Juan');

insert into mi_segunda_tabla(matricula,apellido,calif) values ('6278162',Null,7);

select * from mi_segunda_tabla;

--- drop table mi_segunda_tabla

---------------------------- Pasando al ejemplo de la documentación

CREATE TABLE modulo_victimizacion(
	entidad varchar(2),
	viv varchar(5),
	hogar varchar(5),     
	upm varchar(5),     
	renglon varchar(20), 	
	tipo_delito int,     
	num_delito int,     
	nombre varchar(50), 	
	apellido varchar(50), 	
	perdida int);
	
INSERT INTO modulo_victimizacion VALUES ('01','15','03','15','10',3, 1, 'Luis', 'Miranda',2000),        
								 		('01','15','03','15','10',3, 2, 'Luis', 'Miranda',3000),        
										('02','20','13','10','03',4, 1, 'Oscar', 'Ruiz',1000),        
										('09','16','11','05','01',5, 1, 'Raul', 'Ortiz',4500),        
										('32','12','11','02','04',2, 1, 'Luisa', 'Ortiz',300),        
										('32','12','11','02','04',3, 1, 'Luisa', 'Ortiz',500);

select * from modulo_victimizacion;

drop table modulo_victimizacion;
---- Selección de algunas columnas

select tipo_delito, perdida from modulo_victimizacion;

---- Ordenamientos

select * from modulo_victimizacion order by apellido asc;  --asc es por ascendente

select * from modulo_victimizacion order by apellido desc;  --desc es por descendente

select * from modulo_victimizacion order by apellido desc, nombre asc;

select * from modulo_victimizacion order by apellido asc, perdida desc;

select nombre,apellido,perdida from modulo_victimizacion order by apellido asc, perdida desc;

select * from modulo_victimizacion order by 1 desc;

--------------
--------------  Sesión 04
--------------

---- El verbo select

select * from modulo_victimizacion;

SELECT * FROM modulo_victimizacion WHERE perdida > 1000 ORDER BY tipo_delito DESC;

SELECT * FROM modulo_victimizacion WHERE entidad  = '01';

SELECT * FROM modulo_victimizacion WHERE perdida >= 2000 AND entidad = '01';

SELECT * FROM modulo_victimizacion WHERE perdida != 2000;

SELECT entidad,apellido,perdida FROM modulo_victimizacion WHERE perdida != 2000;

----------- Operadores lógicos

select * from modulo_victimizacion;
SELECT * FROM modulo_victimizacion WHERE tipo_delito IN(3,4,10) order by apellido desc;

SELECT * FROM modulo_victimizacion WHERE tipo_delito = 3 or tipo_delito = 4 or tipo_delito = 10 
order by apellido desc;

--- tipo de delito 3 o 4 y que además la persona se llame Luis
select * from modulo_victimizacion where tipo_delito in(3,4) and nombre = 'Luis';

---
select * from modulo_victimizacion where tipo_delito in(3,4) and nombre in('Luis');

---
SELECT * FROM modulo_victimizacion WHERE tipo_delito = 4 AND entidad = '02';

--- indentando
select * from modulo_victimizacion 
	where tipo_delito in(2,3) 
		and entidad = '32' 
	order by perdida desc,
		nombre asc;

select * from modulo_victimizacion;
SELECT * FROM modulo_victimizacion WHERE NOT perdida = 4500

SELECT * FROM modulo_victimizacion WHERE perdida != 4500

---- El verbo limit

select * from modulo_victimizacion;
select * from modulo_victimizacion limit 3;

select * from modulo_victimizacion order by perdida desc limit 3;

select entidad,tipo_delito,perdida from modulo_victimizacion order by perdida desc limit 3;

---- El comando offset

SELECT * FROM modulo_victimizacion OFFSET 2;

---- El comando between

SELECT * FROM modulo_victimizacion WHERE perdida BETWEEN 1000 AND 3000;
SELECT * FROM modulo_victimizacion WHERE perdida >= 1000 AND perdida <= 3000;


----- like e ilike

SELECT * FROM modulo_victimizacion;

SELECT * FROM modulo_victimizacion WHERE nombre LIKE 'Luis%'; --- inicie con Luis

SELECT * FROM modulo_victimizacion WHERE apellido LIKE '%iz'; --- termine con iz

SELECT * FROM modulo_victimizacion WHERE nombre LIKE '%ui%'; --- contiene ui

----  Por ejemplo, si buscamos los nombres que tengan una "u" 
----  previa a una "s" y que pueden no comenzar con u o terminar con s entonces escribimos


select * from modulo_victimizacion where nombre like '%u%s%';

select * from modulo_victimizacion where nombre ilike 'luis%';

--- El comodín _

SELECT * FROM modulo_victimizacion WHERE nombre LIKE 'Lu__'

SELECT * FROM modulo_victimizacion WHERE nombre LIKE 'L_'

insert into modulo_victimizacion(nombre) values ('Luis.');

select * from modulo_victimizacion;

SELECT * FROM modulo_victimizacion WHERE nombre not LIKE 'Lu__'

--- vaciado de una tabla

delete from modulo_victimizacion where nombre ilike 'Luis%';

select * from modulo_victimizacion;

delete from modulo_victimizacion;

---- el verbo update

UPDATE modulo_victimizacion SET perdida = 100000

UPDATE modulo_victimizacion SET entidad = '32' WHERE nombre = 'Luis'

--------------
--------------  Sesión 05
--------------

select * from modulo_victimizacion; 

ALTER TABLE modulo_victimizacion ADD edad int;  -- añadir columna edad

ALTER TABLE modulo_victimizacion DROP COLUMN edad;	 -- eliminar columna edad

--- ALTER TABLE modulo_victimizacion ADD edad int AFTER entidad;  -- añadir columna edad inmediatamente después de entidad
--- Para agregar columna calculada son necesarios los paréntesis y la cláusula STORED

ALTER TABLE modulo_victimizacion ADD COLUMN ejemplo_1 int GENERATED ALWAYS AS (tipo_delito+num_delito) stored;
ALTER TABLE modulo_victimizacion ADD COLUMN ejemplo_2 int GENERATED ALWAYS AS (tipo_delito*num_delito) stored;
ALTER TABLE modulo_victimizacion ADD COLUMN ejemplo_3 int GENERATED ALWAYS AS (tipo_delito-num_delito) stored;

select * from modulo_victimizacion;

alter table modulo_victimizacion drop ejemplo_3;

-------------------
---- Ejemplo de Roberto

create table persona(
nombre varchar(20),
anio_nacimiento int
);

insert into persona values('Roberto Eder',1983);

select * from persona;

select nombre, anio_nacimiento, (2024-anio_nacimiento) as edad from persona;

---------------------
---------------------
---------------------

select * from modulo_victimizacion;
--- promedio
select avg(perdida) from modulo_victimizacion;

--- suma
select sum(perdida) from modulo_victimizacion;

--- suma y promdedio
select avg(perdida), sum(perdida) from modulo_victimizacion;

--- min y max
select min(perdida),max(perdida) from modulo_victimizacion;

--- todos a la vez
select min(perdida),max(perdida),sum(perdida),avg(perdida) from modulo_victimizacion;
	
---------- conteo

select count(*) from modulo_victimizacion;

select count(*) from modulo_victimizacion where nombre LIKE 'Luis%';

-------------
select min(perdida) as minima_perdida,
	   max(perdida) as maxima_perdida,
	   sum(perdida) as perdida_total,
	   avg(perdida) as perdida_promedio,
	   count(*) as total_victimas
from modulo_victimizacion;

---------------
select * from modulo_victimizacion;

select round(avg(perdida),2) as promedio_redondeado from modulo_victimizacion;

ALTER TABLE modulo_victimizacion ADD COLUMN decimales_6 DECIMAL GENERATED ALWAYS AS (perdida/13.0) STORED;

select *,round(decimales_5,1) as col_redondeada from modulo_victimizacion;

select round(5.123,1) 


--------------
--------------  Sesión 06
--------------

-- función piso (también lladama parte entera) y función techo
--- (piso = floor), (techo = ceil)
select decimales_5,
	floor(decimales_5) as piso,
	ceiling(decimales_5) as techo 
from modulo_victimizacion;	

select decimales_5, floor(decimales_5) as piso, ceiling(decimales_5) as techo from modulo_victimizacion;	

select floor(5);
select floor(-2024);
select ceiling(5);

----------- abs

select abs(-34);
select abs(46);


------------ valores aleatorios entre 0 y 1

select random();

---- Selecciona un número aleatorio en 1,2,3,4,5,6

select floor(6*random()+1);

select setseed(0.5);
select random();

------------- potencias

select power(5,2);

select * from modulo_victimizacion;

select tipo_delito, num_delito, power(tipo_delito,num_delito) from modulo_victimizacion;	

------------- módulos

select mod(1996,28);
select perdida, 
	tipo_delito, 
	mod(perdida,tipo_delito) as modulo, 
	perdida/tipo_delito as division 
from modulo_victimizacion;


-------------  raíz cuadrada 

select sqrt(25);

select sqrt(perdida) from modulo_victimizacion;

-------------
-------------  Funciones de texto
-------------

select * from modulo_victimizacion;

select nombre, upper(nombre) as mayusculas from modulo_victimizacion;

select nombre, upper(nombre) as mayusculas, lower(nombre) as minusculas from modulo_victimizacion;

select nombre, apellido, concat(nombre,' ',apellido) as nombre_completo_espacio, 
	concat(nombre,'_',apellido) as nombre_completo_guion	
	from modulo_victimizacion;

select nombre, apellido, concat(nombre,' ',perdida) as nombre_completo_espacio, 
	concat(nombre,'_',apellido) as nombre_completo_guion	
	from modulo_victimizacion;
	
select concat('La persona ', nombre,' ',apellido,' ha tenido una pérdida de $', perdida) as frase
	from modulo_victimizacion;	
	

---------- length

select concat('La persona ', nombre,' ',upper(apellido),' ha tenido una pérdida de $', perdida) as frase,
	length(concat('La persona ', nombre,' ',apellido,' ha tenido una pérdida de $', perdida)) as longitud_frase
	from modulo_victimizacion;


-----------
-----------   Clase 7
-----------

create table datos(cod_pais char(3), cod_ent char(2), tipo_delito char(2), nombre varchar(50));

select * from datos;

insert into datos values ('MEX','03','01','Luis'), ('USA','05','04','Ana'), ('MEX','09','02','Francisco');


----- EJERCICIo: añadir una columna llamada Identificador que sea concatenar cod_pais,cod_ent,tipo_delito


ALTER TABLE datos ADD COLUMN identificador VARCHAR(10);
UPDATE datos SET identificador = CONCAT(cod_pais, cod_ent, tipo_delito);

----- Eliminen todas excepto las columnas nombre e identificador

ALTER TABLE datos drop column cod_pais, drop column cod_ent, drop column tipo_delito;

select * from datos;

------ funcion substr (substraer)
select substr(identificador,1,3) as pais,
substr(identificador,4,2) as entidad,
substr(identificador,6,2) as tipo
from datos;

------- funcion position('texto1' in 'texto2');  esto buscara texto 1 en el texto 2

select position('a t' in 'hola a todos');

select *, position('MEX' in identificador) from datos;

------- funcion rename column para cambiar el nombre de la columna

alter table datos rename column identificador to id;

------- cambar el orden de las columnas

select id, nombre from datos;

----------- lpad y rpad

select rpad('hola',30,'SciData');
select *,rpad(nombre,40,'_') as nombre_40 from datos;

select lpad('hola',30,'*');
select rpad('hola',30,'*');
select rpad('hola',2,'*');

select * from datos;


ALTER TABLE datos ADD COLUMN id_nombre text;
UPDATE datos SET id_nombre = CONCAT(rpad(nombre,40,' '),id);

select substr(id_nombre,1,40) from datos;

select id_nombre,
	rtrim(substr(id_nombre,1,40)) as nombre,
	substr(id_nombre,41,3) as pais,
	substr(id_nombre,44,2) as entidad,
	substr(id_nombre,46,2) as tipo
from datos;

select * from datos;

	------  replace

select replace('hola a todos hola','hola','SciData');
select replace(id,'MEX','mex') from datos;

select * from datos;

---------------------
---------------------  Sesión 08
---------------------

create table info_paises(continente varchar(10),pais varchar(10),cantidad int);

select * from info_paises

insert into info_paises values 
('America','Mexico',575),
('Europa', 'España', 975),
('Europa', 'Italia', 549),
('America', 'Mexico', 933),
('Oceania', 'Australia', 653),
('Asia', 'Japon', 791),
('Asia', 'China', 712),
('America', 'Canada', 674),
('Asia', 'China', 574),
('Africa', 'Madagascar', 854);

select * from info_paises;

select continente, sum(cantidad) as suma from info_paises group by continente;

select continente, 
	sum(cantidad) as suma,
	avg(cantidad) as promedio,
	max(cantidad) as maximo,
	min(cantidad) as minimo 
from info_paises group by continente;

select continente, pais,
	sum(cantidad) as suma,
	avg(cantidad) as promedio,
	max(cantidad) as maximo,
	min(cantidad) as minimo 
from info_paises group by continente, pais;

select continente, count(*) from info_paises group by continente;

select continente, 
	sum(cantidad) as suma,
	avg(cantidad) as promedio,
	max(cantidad) as maximo,
	min(cantidad) as minimo,
	count(*) as total_paises
from info_paises 
group by continente 
order by total_paises desc, promedio asc;

--- Para mostrar únicamente los grupos, hacemos el group by pero sin función de agregación
select continente from info_paises group by continente;
select continente, pais from info_paises group by continente, pais;

select pais, continente from info_paises group by continente, pais;
select pais, continente, sum(cantidad) from info_paises group by continente, pais;

select continente, 
	sum(cantidad) as suma,
	avg(cantidad) as promedio,
	max(cantidad) as maximo,
	min(cantidad) as minimo,
	count(*) as total_paises
from info_paises 
group by continente
having avg(cantidad) > 760
order by suma ; 

select * from info_paises;

--------------

drop table modulo_victimizacion;

select * from modulo_victimizacion;

CREATE TABLE modulo_victimizacion(
	entidad varchar(2),
	viv varchar(5),
	hogar varchar(5),     
 	upm varchar(5),     
	renglon varchar(20), 	
	tipo_delito int,     
	num_delito int,     
	nombre varchar(50), 	
	apellido varchar(50), 	
	perdida int);
	
INSERT INTO modulo_victimizacion VALUES ('01','15','03','15','10',3, 1, 'Luis', 'Miranda',2000),        
								 		('01','15','03','15','10',3, 2, 'Luis', 'Miranda',3000),        
										('02','20','13','10','03',4, 1, 'Oscar', 'Ruiz',1000),        
										('09','16','11','05','01',5, 1, 'Raul', 'Ortiz',4500),        
										('32','12','11','02','04',2, 1, 'Luisa', 'Ortiz',300),        
										('32','12','11','02','04',3, 1, 'Luisa', 'Ortiz',500),
										('05','18','08','20','15',2, 1, 'María', 'González',1500),
										('12','10','17','04','06',4, 1, 'Pedro', 'Martínez',2500),
										('07','21','05','12','09',3, 1, 'Ana', 'López',3500),
										('19','07','14','08','11',5, 1, 'Juan', 'Díaz',4000),
										('03','22','09','11','07',2, 1, 'Elena', 'Sánchez',2000),
										('14','11','12','03','02',3, 1, 'Jorge', 'Pérez',3000),
										('28','09','20','07','05',4, 1, 'Laura', 'Ramírez',5000),
										('08','16','18','09','13',2, 1, 'Diego', 'Hernández',1800),
										('21','13','16','06','01',5, 1, 'Sofía', 'Gómez',4200),
										('11','17','02','15','10',3, 1, 'Carlos', 'Fernández',2700);

select * from modulo_victimizacion

----- Contar el número de víctimas por tipo de delito y mostrar solo aquellos tipos de delito con mas de 
----- una víctima

select tipo_delito, count(*) 
from modulo_victimizacion
group by tipo_delito
having count(*) > 1;

----- Calcular el promedio de pérdidas por entidad y mostrar solo aquellas entidades con un promedio de pérdida
----- superior a 2000

select entidad, avg(perdida) as promedio_perdida
from modulo_victimizacion
group by entidad
having avg(perdida) > 2000;

select * from modulo_victimizacion;

----- Listar las viviendas y hogares donde se hayan registrado exactamente dos delitos
select viv, hogar, nombre, count(*) 
from modulo_victimizacion
group by viv, hogar, nombre
having count(*) = 2;

----- Mostrar el número de delitos cometidos por cada apellido y nombre
select nombre, apellido, count(*)
from modulo_victimizacion
group by nombre, apellido;

----- Mostrar el máximo de pérdida por cada entidad y UPM

select entidad, upm, max(perdida)
from modulo_victimizacion
group by entidad, upm
order by max(perdida) desc;

















