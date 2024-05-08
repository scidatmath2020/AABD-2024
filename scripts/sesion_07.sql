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



