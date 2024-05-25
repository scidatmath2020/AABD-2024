create table covid_muestra(SEXO int, ENTIDAD_RES int, FECHA_SINTOMAS text,
						   FECHA_DEF text, INTUBADO int, EDAD int, CLASIFICACION_FINAL int);
						   
create table catalogo_entidades(CLAVE_ENTIDAD int, entidad_federativa text, entidad_abreviatura text);

copy covid_muestra(SEXO, ENTIDAD_RES, FECHA_SINTOMAS,FECHA_DEF,INTUBADO,EDAD,CLASIFICACION_FINAL) from 
'C:/Users/Usuario/Documents/scidata/24_01_aabd/covid/covid_muestra.csv' delimiter ',' csv header;

copy catalogo_entidades from 
'C:/Users/Usuario/Documents/scidata/24_01_aabd/covid/catalogo_entidades.csv' delimiter ',' csv header;

select * from covid_muestra limit 50;
select * from catalogo_entidades;

-------------Limpieza de datos-------------

---- Quedarse únicamente con quienes estén confirmados con covid

drop table covid_confirmado;

create table covid_confirmado as 
select * from covid_muestra where clasificacion_final in (1,2,3) and entidad_res between 1 and 32;

select * from covid_confirmado;

-------------Enfermedad y decesos-------------

-- Contar el total de contagios: 16463
select count(*) from covid_confirmado;

-- Contar el total de defunciones: 1241
select count(*) as total_defuncinoes from covid_confirmado where fecha_def != '9999-99-99';

-- Calcular el porcentaje de defunciones respecto de contagios
select 1241*100/16463.0;

-- Mostrar las 10 entidades con mas contagios junto con el total de contagios

--- select count(*) from covid_confirmado group by entidad_res;

create table covid_conf_ent as 
select * from covid_confirmado 
left join catalogo_entidades on covid_confirmado.entidad_res = catalogo_entidades.clave_entidad;

select entidad_federativa, count(*) as total 
from covid_conf_ent 
group by entidad_federativa 
order by total desc
limit 10;

-- Mostrar las 32 entidades con contagios segregados por sexo

select entidad_federativa, sexo, count(*) as total from covid_conf_ent group by entidad_federativa, sexo
order by entidad_federativa asc, sexo asc; 

-- Encontrar la fecha con más contagios registrados. Es el 01/08/2021 y fueron 114

select * from covid_conf_ent;

select fecha_sintomas as fecha, count(*) as total from covid_conf_ent 
group by fecha_sintomas 
order by total desc;

-- ¿En qué entidades se dieron esos contagios? (tres entidades)
-- ¿Cuáles son las tres entidades qué mas contagios aportaron en dicha fecha?

create table covid_conf_ent_fecha_max as
select * from covid_conf_ent where fecha_sintomas = '01/08/2021'; 

select entidad_federativa, count(*) as total 
from covid_conf_ent_fecha_max 
group by entidad_federativa 
order by total desc
limit 3;

-- ¿Qué porcentaje representó cada una de esas entidades respecto del total de contagios de dicha fecha?

select 15*100/114.0, 11*100/114.0, 10*100/144.0;
select 15*100/114.0 + 11*100/114.0 + 10*100/144.0;

-- TAREA: ¿En qué fecha se dio la mayor cantidad de muertes?

-------------Condición de intubación-------------

-- Calcular de cuántos se conoce la condición

create table covid_conf_int as 
select * from covid_confirmado where intubado in (1,2);

select count(*) from covid_conf_int; --- 2483

-- Calcular total de intubados y porcentaje respecto de condición de intubación

select count(*) from covid_conf_int where intubado = 1; --- 305
select 305*100/2483.0; --- 12.28 

-- Calcular total de muertes con condición de intubación conocida

select count(*) from covid_conf_int where fecha_def != '9999-99-99'; --1141

-- Calcular qué porcentaje de las muertes anteriores requirió intubación

select count(*) from covid_conf_int where fecha_def != '9999-99-99' and intubado = 1; --254

select 254*100/1141.0; -- 22.26%

----- P(morir e intubarse / morir) = P(intubarse|falleció)
----- Teorema de Bayes: P(A|B)=P(B|A)P(A)/P(B)
----- P(morir|intubaron) = P(intubar|muerte)*P(morir)/P(intubarse) = 0.2226*0.07/0.12 = 13%

select 0.2226*0.07/0.12;

-------------Distribución porcentual de contagios-------------

-- Mostrar, del total de contagios, la tabla de Pareto respecto de las entidades

create table contagio_por_ent as
select entidad_federativa, count(*) as total 
from covid_conf_ent 
group by entidad_federativa 
order by total desc;

select * from contagio_por_ent;

select sum(total) from contagio_por_ent; --16463

SELECT entidad_federativa, 
       total, 
       0.0060*SUM(total) OVER (ORDER BY total desc) AS cumsum_total
FROM contagio_por_ent;


