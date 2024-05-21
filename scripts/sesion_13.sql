--------
-------- Sesión 13
--------

---- Una función a la cual le proporcionas dos números: precio y descuento. Lo que va a devolver
---- es el precio final con el descuento proporcionado.

---- Por ejemplo, si un precio es de 420 y hay 10% de descuento, entonces debe devolver como resultado 378


CREATE OR REPLACE FUNCTION calculate_discount(price numeric, discount_percent numeric)
RETURNS numeric AS $$
DECLARE
    discounted_price numeric;
BEGIN
    discounted_price = price - (price * discount_percent / 100);
    RETURN discounted_price;
END;
$$ LANGUAGE plpgsql;

---- Ejecutamos:

---- Si el precio es 420 y hay 10% de descuento, el final debe ser 378
select * from calculate_discount(420,10)
select * from calculate_discount(5000,15)

---- Una función a la cual le proporcionas dos números enteros X y Y y devuelva X+Y

CREATE OR REPLACE FUNCTION sumar(X int, Y int)
RETURNS int AS
$$
DECLARE
    z int;
BEGIN
    z = X + Y;
    RETURN z;
END
$$
LANGUAGE 'plpgsql';

select * from sumar(5,102);
select * from sumar(5.7,102);

----- Modificación


CREATE OR REPLACE FUNCTION sumar_modificado(X int, Y int)
RETURNS int AS
$$
BEGIN
    RETURN X+Y;
END
$$
LANGUAGE 'plpgsql';

select * from sumar_modificado(5,102)

--------
-------- Libreria
--------

drop table clientes;
drop table libros;
drop table ventas;

create table clientes(Cliente_ID int, Nombre text);
create table libros(ISBN text, Titulo text, Autor text, Editorial text, Año_de_publicacion int, Genero text, Precio_de_venta numeric);
create table ventas(Venta_ID int, ISBN text, Fecha_de_venta date, Cliente text, Precio_de_venta numeric);

INSERT INTO Clientes (Cliente_ID, Nombre) VALUES
(1, 'Juan Pérez'),
(2, 'Ana Gómez'),
(3, 'María López'),
(4, 'Pedro Martínez'),
(5, 'Luis Rodríguez');

INSERT INTO Libros (ISBN, Titulo, Autor, Editorial, Año_de_publicacion, Genero, Precio_de_venta) VALUES
('978-3-16-148410-0', 'El libro de la selva', 'Rudyard Kipling', 'Editorial A', 1894, 'Aventura', 15.99),
('978-1-40-289462-6', 'Cien años de soledad', 'Gabriel García Márquez', 'Editorial B', 1967, 'Ficción', 20.50),
('978-0-7432-7356-5', 'La sombra del viento', 'Carlos Ruiz Zafón', 'Editorial C', 2001, 'Misterio', 22.99),
('978-0-452-28423-4', '1984', 'George Orwell', 'Editorial D', 1949, 'Dystopía', 14.99),
('978-0-14-118280-3', 'El Gran Gatsby', 'F. Scott Fitzgerald', 'Editorial E', 1925, 'Clásico', 10.99);

INSERT INTO Ventas (Venta_ID, ISBN, Fecha_de_venta, Cliente, Precio_de_venta) VALUES
(1, '978-3-16-148410-0', '2023-05-01', 'Juan Pérez', 15.99),
(2, '978-1-40-289462-6', '2023-05-02', 'Ana Gómez', 20.50),
(3, '978-0-7432-7356-5', '2023-05-03', 'María López', 22.99),
(4, '978-0-452-28423-4', '2023-05-04', 'Pedro Martínez', 14.99),
(5, '978-0-14-118280-3', '2023-05-05', 'Luis Rodríguez', 10.99);

------- Ejercicio 1. Crear una función para agregar un nuevo libro

select * from libros;
--char, varchar, text

create or replace function agregar_libro(
isbn text,
titulo text,
autor text,
editorial text,
año_de_publicacion int,
genero text,
precio_de_venta numeric
)
returns int as $$
begin
insert into libros values (isbn, titulo, autor, editorial, año_de_publicacion, genero, precio_de_venta);
return 0;
end;
$$ 
language 'plpgsql';


select * from agregar_libro('978-3-16-148410-0',
							'El libro de la selva',
							'Rudyard Kipling', 
							'Editorial A',
							1894,
						   'Aventura',
						   15.99);

select * from libros;

----- Ejercicio 2 (tarea): crear una función para añadir una venta

----- Ejercicio 3 (tarea): crear una función para calcular el total de ventas de un libro por ISBN

----- Ejercicio 4 (tarea): Crear una función para obtener el número de ventas por cliente (es decir, cuántas compras hizo)

----- Ejercicio 5: Crear una función para obtener los libros vendidos en un rango de fechas

select * from libros;

create or replace function libros_vendidos_rango(fecha_inicio date, fecha_final date)
returns table(isbn text, titulo text, fecha_de_venta date, cliente text, precio_de_venta numeric) as $$
begin
return query 
select libros.isbn, libros.titulo, ventas.fecha_de_venta, ventas.cliente, ventas.precio_de_venta 
from libros 
join ventas on libros.isbn = ventas.isbn
where ventas.fecha_de_venta between fecha_inicio and fecha_final;
end;
$$
language 'plpgsql';

--select libros.isbn, libros.titulo, ventas.fecha_de_venta, ventas.cliente, ventas.precio_de_venta 
--from libros 
--join ventas on libros.isbn = ventas.isbn
--where ventas.fecha_de_venta between '2023-05-02' and '2023-05-04'; 

create table fechas_filtradas as select * from libros_vendidos_rango('2023-05-01','2023-05-02');

select * from fechas_filtradas;




