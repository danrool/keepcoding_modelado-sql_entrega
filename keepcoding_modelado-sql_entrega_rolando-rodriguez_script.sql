-----------------------------------------------------------------------
--- KEEPCODING - BOOTCAMP BIG DATA
--- CURSO MODELADO-SQL - ENTREGA 
--- PROFESOR - FRANCISCO MOLINA
--- AUTOR - ROLANDO RODRIGUEZ

-----------------------------------------------------------------------
--- CREACION DE ESQUEMA
---

drop schema if exists vehiculos cascade;
create schema vehiculos;

-----------------------------------------------------------------------
--- CREACION DE TABLAS
---


create table vehiculos.color(
	color_id int primary key,
	color_nombre varchar(30) unique not null
);

create table vehiculos.moneda(
	moneda_id int primary key,
	moneda_nombre varchar(30) unique not null,
	abreviado varchar(3) unique not null
);

create table vehiculos.grupo(
	grupo_id int primary key,
	grupo_nombre varchar(30) unique not null
);

create table vehiculos.marca(
	marca_id int primary key,
	grupo_id int not null,
	marca_nombre varchar(50) unique not null
);

create table vehiculos.modelo(
	modelo_id int primary key,
	marca_id int,
	modelo_nombre varchar(50) unique not null
);

create table vehiculos.aseguradora(
	aseguradora_id int primary key,
	aseguradora_nombre varchar(50) unique not null,
	telefono varchar(50) not null,
	email varchar(20)
);

create table vehiculos.vehiculo(
	vehiculo_id int primary key,
	modelo_id int not null,
	color_id int not null,
	aseguradora_id int not null,
	matricula varchar(50) unique not null,
	numero_poliza varchar(25) not null,
	fecha_compra date not null,
	kilometros int not null,
	activo bit default '1'
);

create table vehiculos.revision(
	revision_id int primary key,
	vehiculo_id int not null,
	moneda_id int not null,
	fecha date not null,
	kilometros int not null,
	importe float not null

);

-----------------------------------------------------------------------
--- RELACIONES
---

alter table vehiculos.marca add constraint FK_marca_grupo foreign key (grupo_id) references vehiculos.grupo(grupo_id);
alter table vehiculos.modelo add constraint FK_modelo_marca foreign key (marca_id) references vehiculos.marca(marca_id);
alter table vehiculos.vehiculo add constraint FK_vehiculo_modelo foreign key (modelo_id) references vehiculos.modelo(modelo_id);
alter table vehiculos.vehiculo add constraint FK_vehiculo_color foreign key (color_id) references vehiculos.color(color_id);
alter table vehiculos.vehiculo add constraint FK_vehiculo_aseguradora foreign key (aseguradora_id) references vehiculos.aseguradora(aseguradora_id);
alter table vehiculos.revision add constraint FK_revision_vehiculo foreign key (vehiculo_id) references vehiculos.vehiculo(vehiculo_id);
alter table vehiculos.revision add constraint FK_revision_moneda foreign key (moneda_id) references vehiculos.moneda(moneda_id);


-----------------------------------------------------------------------
--- INSERTS
---

insert into vehiculos.color (color_id, color_nombre) values (1,'Rojo'), (2,'Azul'), (3,'Naranja'), (4,'Negro'), (5,'Gris');

insert into vehiculos.moneda (moneda_id, moneda_nombre, abreviado  ) values (1,'Dolar','USD'), (2,'Euro','EUR');

insert into vehiculos.grupo (grupo_id, grupo_nombre) values (1,'BMW GROUP'), (2,'VAN'), (3,'PSA'), (4,'FCA'), (5,'GEELY GROUP');

insert into vehiculos.marca (marca_id, marca_nombre, grupo_id) values (1,'BMW',1),  (2,'MINI',1),  (3,'ROLLS',1),  (4,'ROYCE',1),  (5,'ALPINA',1); 
insert into vehiculos.marca (marca_id, marca_nombre, grupo_id) values (6, 'VOLKSWAGEN',2),  (7, 'AUDI',2),  (8, 'BENTLEY',2),  (9, 'BUGATI',2),  (10, 'SEAT',2);
insert into vehiculos.marca (marca_id, marca_nombre, grupo_id) values (11, 'OPEL',3),  (12, 'VAUXHALL',3),  (13, 'CITROEN',3),  (14, 'DS',3),  (15, 'PEUGEOT',3);
insert into vehiculos.marca (marca_id, marca_nombre, grupo_id) values (16, 'CHRYSLER',4),  (17, 'FIAT',4);
insert into vehiculos.marca (marca_id, marca_nombre, grupo_id) values (18, 'GEELY',5),  (19, 'LOTUS',5),  (20, 'VOLVO',5),  (21, 'LYNK & CO',5),  (22, 'LONDON',5);


insert into vehiculos.modelo (modelo_id, modelo_nombre, marca_id) values (1, 'Serie 1',1), (2, 'Serie 2',1), (3, 'Serie 1128ti',1), (4, 'Serie 3',1);
insert into vehiculos.modelo (modelo_id, modelo_nombre, marca_id) values (5, 'Tiguan',6), (6, 'Virtus',6), (7, 'T Cross',6), (8, 'Taos',6);
insert into vehiculos.modelo (modelo_id, modelo_nombre, marca_id) values (9, 'A3',7), (10, 'Q2',7), (11, 'Q3',7), (12, 'Q5',7);
insert into vehiculos.modelo (modelo_id, modelo_nombre, marca_id) values (13, '208',15), (14, '2008',15), (15, '301', 15), (16, '3008', 15);


insert into vehiculos.aseguradora (aseguradora_id, aseguradora_nombre, telefono, email) values 
	(1, 'Mapfre','111-111111','info@mapfre.com'), (2, 'MMT','222-22222','info@mmt.com'), (3, 'AXA','333-33333','info@AXA.com');

insert into vehiculos.vehiculo (vehiculo_id, matricula, modelo_id, color_id, aseguradora_id, numero_poliza, fecha_compra, kilometros, activo ) values 
	(1, 'A-777777', 1, 1, 1, 'POL-11111', '20180101',10000,'1'),
	(2, 'B-222222', 2, 2, 2, 'POL-222222', '20170201',20000,'1'),
	(3, 'C-333333', 3, 3, 3, 'POL-333333', '20160301',30000,'0'),
	(4, 'D-444444', 4, 4, 1, 'POL-4444444', '20150401',40000,'0'),
	(5, 'E-555555', 5, 1, 2, 'POL-555555', '20200501',50000,'1'),
	(6, 'F-666666', 6, 2, 3, 'POL-666666', '20210601',60000,'1');

insert into vehiculos.revision (revision_id, vehiculo_id, moneda_id, fecha, kilometros, importe) values 
	(1, 1, 1, '20230201', 10000, 750.01), (7, 1, 2, '20230201', 20000, 850.02), (13, 1, 1, '20230301', 30000, 950.01), (19, 1, 2, '20230401', 40000, 1050.01),
	(2, 2, 2, '20230201', 10000, 760.01), (8, 2, 1, '20230201', 20000, 860.02), (14, 2, 2, '20230301', 30000, 960.01), (20, 2, 1, '20230401', 40000, 1060.01),
	(3, 3, 1, '20230201', 10000, 770.01), (9, 3, 2, '20230201', 20000, 870.02), (15, 3, 1, '20230301', 30000, 970.01), (21, 3, 2, '20230401', 40000, 1070.01),
	(4, 4, 2, '20230201', 10000, 780.01), (10, 4, 1, '20230201', 20000, 880.02), (16, 4, 2, '20230301', 30000, 980.01), (22, 4, 1, '20230401', 40000, 1080.01),
	(5, 5, 1, '20230201', 10000, 790.01), (11, 5, 2, '20230201', 20000, 890.02), (17, 5, 1, '20230301', 30000, 990.01), (23, 5, 2, '20230401', 40000, 1090.01),
	(6, 2, 2, '20230201', 10000, 800.01), (12, 6, 1, '20230201', 20000, 900.02), (18, 6, 2, '20230301', 30000, 1000.01), (24, 6, 1, '20230401', 40000, 2000.01);



-----------------------------------------------------------------------
--- CONSULTA DE DATOS
---

select mo.modelo_nombre , ma.marca_nombre , g.grupo_nombre , v.fecha_compra , v.matricula , c.color_nombre , v.kilometros , a.aseguradora_nombre  , v.numero_poliza 
from vehiculos.vehiculo v 
inner join vehiculos.modelo mo on mo.modelo_id = v.modelo_id 
inner join vehiculos.marca ma on ma.marca_id = mo.marca_id 
inner join vehiculos.grupo g on g.grupo_id = ma.grupo_id 
inner join vehiculos.color c on c.color_id = v.color_id 
inner join vehiculos.aseguradora a on a.aseguradora_id = v.aseguradora_id 
where v.activo = '1' ;

/*
select mo.modelo_nombre , ma.marca_nombre , g.grupo_nombre , v.fecha_compra , v.matricula , c.color_nombre , v.kilometros , a.aseguradora_nombre  , v.numero_poliza 
from vehiculos.vehiculo v 
inner join vehiculos.modelo mo on mo.modelo_id = v.modelo_id 
inner join vehiculos.marca ma on ma.marca_id = mo.marca_id 
inner join vehiculos.grupo g on g.grupo_id = ma.grupo_id 
inner join vehiculos.color c on c.color_id = v.color_id 
inner join vehiculos.aseguradora a on a.aseguradora_id = v.aseguradora_id; 
*/
