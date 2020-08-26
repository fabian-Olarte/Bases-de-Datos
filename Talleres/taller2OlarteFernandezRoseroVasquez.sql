--Fabian Olarte / Santiago Fernández / Mateo Rosero / Andrés Vásquez 
--Laboratorio SQL 2 2020-3 Bases de Datos

-- Drops

drop table DetalleFactura;
drop table Factura;
drop table Persona;
drop table Producto;

-- Creación de tablas

create table Producto(
codigoProducto number (5,0),
nombreProducto varchar2(60) not null,
valorUnitario number(10,0) not null,
primary key (codigoProducto));

create table Persona(
tipoDocumento char (2),
documento number(10,0) not null,
nombre varchar2(60),
apellido varchar2(60),
fecha_nacimiento date not null,
genero char (2),
peso number(5,0),
estatura number(5,0),
primary key (tipoDocumento, documento));

create table Factura(
codigoFactura char (10),
fechaFactura date not null,
tipoDocumento char (2),
documento number(10,0) not null,
fechaEntrega date,
foreign key (tipoDocumento, documento) references Persona,
primary key (codigoFactura));

create table DetalleFactura(
codigoFactura char (10),
lineaFactura number (5,0),
codigoProducto number (5,0),
cantidad number (5,0),
foreign key (codigoFactura) references Factura,
foreign key (codigoProducto) references Producto,
primary key (codigoFactura, lineaFactura));

-- Inserción de datos 

insert into Producto VALUES (1, 'Laptop', 2000);
insert into Producto Values (2, 'Mouse', 50);
insert into Producto Values (3, 'Tablet',60);

insert into Persona values ('CC', 1, 'Pedro', 'Perez', TO_DATE('1980-01-01','YYYY-MM-DD'), 'M', 70, 170);
insert into Persona values('CE',1,'Juan','Perez', TO_DATE('1981-01-30','YYYY-MM-DD'),'M',80,180);
insert into Persona values('CC',2,'Maria','Perez', TO_DATE('1979-02-12','YYYY-MM-DD'),'F',50,158);
insert into Persona values('CC',33,'Laura','Restrepo', TO_DATE('1960-11-30','YYYY-MM-DD'),'F',52,160);

insert into Factura values('F1', TO_DATE('2017-02-06','YYYY-MM-DD'),'CC', 1,  TO_DATE('2017-02-06','YYYY-MM-DD'));
insert into Factura values('F3', TO_DATE('2017-02-06','YYYY-MM-DD'), 'CC', 2,  TO_DATE('2017-03-06','YYYY-MM-DD'));
insert into Factura values('F4', TO_DATE('2016-02-05','YYYY-MM-DD'), 'CC', 33,  null);

insert into DetalleFactura Values ('F1',1,1,100);
insert into DetalleFactura Values ('F1',2,2,5);
insert into DetalleFactura Values ('F1',3,3,100);
insert into DetalleFactura Values ('F3',1,1,1);
insert into DetalleFactura Values ('F3',2,2,5000);
insert into DetalleFactura Values ('F3',3,2,5000);
insert into DetalleFactura Values ('F4',1,2,10000);
insert into DetalleFactura Values ('F4',2,2,10000);
insert into DetalleFactura Values ('F4',3,2,10000);

--CONSULTAS

--1. Cual es la mujer y el hombre (Nombres y Apellidos en un campo llamado Nombre Completo) con la factura de más valor (En pesos), siempre y cuando la factura haya sido despachada. Mostrar Nombre Completo y valor de la factura.

/*with valorTotalXFactura(codigoFactura, valorTotal) as
    (
    select codigoFactura, codigoProducto
    from DetalleFactura, Factura, Producto
    group by codigoFactura),*/
select (INITCAP(Persona.nombre) || " " || INITCAP(Persona.apellido)) as NombreCompleto
from Persona, Factura
where Factura.fechaEntrega = null and Persona.tipoDocumento = Factura.tipoDocumento and Persona.documento = Factura.documento; 

--2. Cual es la factura (Codigo Factura, fecha de factura, persona(nombres y apellidos) ), con la mayor cantidad de artículos vendidos.Mostrar (Codigo Factura, fecha de factura, persona(nombres y apellidos), cantidad de artículos )

select Factura.codigoFactura, Factura.fechaFactura, (Persona.nombre || ' ' || Persona.apellido) AS "Nombre Completo", DetalleFactura.cantidad
from 
    (select max (DetalleFactura.cantidad) as valorMaximo
    from DetalleFactura
    where Factura.codigoFactura = DetalleFactura.codigoFactura)
where sum(DetalleFactura.cantidad) = valorMaximo;

commit;