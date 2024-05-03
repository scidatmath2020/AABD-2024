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





















