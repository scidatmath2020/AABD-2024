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

