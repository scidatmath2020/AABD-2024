CREATE TABLE personas (
    llave_primaria_persona VARCHAR(20) PRIMARY KEY,
    entidad VARCHAR(2),
    upm VARCHAR(2),
    vivienda VARCHAR(2),
    hogar VARCHAR(2),
    renglon VARCHAR(2)
);

INSERT INTO personas (llave_primaria_persona, entidad, upm, vivienda, hogar, renglon) VALUES
('02_02_01_02_01', '02', '02', '01', '02', '01'),
('02_01_03_01_01', '02', '01', '03', '01', '01'),
('01_18_02_01_03', '01', '18', '02', '01', '03'),
('32_12_03_05_04', '32', '12', '03', '05', '04'),
('09_15_04_01_02', '09', '15', '04', '01', '02');

select * from personas;

select * from personas where entidad = '02';

------ En R:      Personas[Personas$entidad == "02",],  Personas %>% filter(entidad == "02")
------ En Python: Personas >> filter(_.entidad == "02")

select * from personas where entidad = '02' or entidad = '01';


------ P_entidad(personas)

select entidad from personas;

------ En R:      Personas$entidad,  Personas %>% select(entidad), Personas[,"entidad"]
------ En Python: Personas >> select(_.entidad)

select entidad, upm from personas;

------ En R:      Personas %>% select(entidad,upm), Personas[,c("entidad","upm")]
------ En Python: Personas >> select(_.entidad,_.upm)


----- rho_personas(entidad|estado)

select entidad as estado from personas;

------ En R:      Personas %>% rename(entidad = estado)
------ En Python: Personas >> rename(entidad = estado)


------- Pi_(entidad,UPM)(sigma_(entidad=Baja California)(personas))

select entidad, UPM from personas where entidad = '02';

------ En R:      Personas %>% filter(entidad = '02') %>% select(entidad,UPM)
------ En Python: Personas >> filter(_.entidad = '02') >> select(_.entidad,_.UPM)

-----------
----------- Tablas de ropa
-----------


-- Crear la tabla camisas
CREATE TABLE camisas (
    Id_camisa SERIAL PRIMARY KEY,
    camisa VARCHAR(50),
    Precio DECIMAL
);

-- Insertar datos en la tabla camisas
INSERT INTO camisas (camisa, Precio) VALUES
('lino blanco', 210),
('algodon naranja', 290),
('seda negra', 260);

-----------------
-----------------
-----------------

CREATE TABLE pantalones (
    Id_pantalon SERIAL PRIMARY KEY,
    pantalon VARCHAR(50),
    Precio DECIMAL
);

-- Insertar datos en la tabla pantalones
INSERT INTO pantalones (pantalon, Precio) VALUES
('mezclilla azul', 470),
('mezclilla negra', 730);

-----------------
-----------------
-----------------

select * from camisas;
select * from pantalones;

create table camisas_pantalones as
select camisas.camisa, 
       camisas.precio as Precio_camisa, 
       pantalones.pantalon, 
       pantalones.precio as Precio_pantalon,
       camisas.precio + pantalones.precio as Precio_final
from camisas, pantalones;

select * from camisas_pantalones;

select concat('Camisa de ',camisa,' con pantalon de ',pantalon) as combinacion, 
	Precio_final
from camisas_pantalones
order by Precio_final Desc;

-----------------
-----------------
-----------------

CREATE TABLE frutas_A (
    ID_A SERIAL PRIMARY KEY,
    Fruta VARCHAR(50) NOT NULL
);

INSERT INTO frutas_A(Fruta) VALUES
('Manzana'),
('Naranja'),
('Plátano'),
('Pepino');


CREATE TABLE frutas_B (
    ID_B SERIAL PRIMARY KEY,
    Fruta VARCHAR(50) NOT NULL
);


INSERT INTO frutas_B(Fruta) VALUES
('Naranja'),
('Manzana'),
('Sandía'),
('Pera');


---- inner join

select * from frutas_A;
select * from frutas_B;

select * from frutas_A inner join frutas_B on frutas_A.Fruta = frutas_B.Fruta;
select * from frutas_B inner join frutas_A on frutas_B.Fruta = frutas_A.Fruta;


---- left join (todos)
select * from frutas_A left join frutas_B on frutas_A.Fruta = frutas_B.Fruta;

---- left join (sin coincidencia)
select * from frutas_A left join frutas_B on frutas_A.Fruta = frutas_B.Fruta where frutas_B.Fruta is null;

----- full join (todos)
select * from frutas_A full join frutas_B on frutas_A.Fruta = frutas_B.Fruta;
select * from frutas_B full join frutas_A on frutas_B.Fruta = frutas_A.Fruta;


----- full join (sin coincidencia)
select * from frutas_A full join frutas_B on frutas_A.Fruta = frutas_B.fruta
where frutas_A.Fruta is null or frutas_B.Fruta is null;

