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
drop table mi_primer_tabla
