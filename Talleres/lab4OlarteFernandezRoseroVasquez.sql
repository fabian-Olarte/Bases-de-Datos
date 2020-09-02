--Fabian Olarte / Santiago Fernández / Mateo Rosero / Andrés Vásquez 
--Laboratorio SQL 4 2020-3 Bases de Datos

create table Clientes(
codigoCliente number(3,0),
nombre varchar2(60),
apellido varchar2(60),
fecha_nacimiento date,
fecha_vinculacion date,
genero char(1),
primary key (codigoCliente));

create table Oficinas(
codigo_oficina number(3,0),
nombre varchar2(60),
primary key (codigo_oficina));

create table Cuentas(
numero_cuenta number(3,0),
tipo char(2),
codigo_oficina number(3,0),
saldo number(12,2),
valor_apertura number(12,2),
foreign key (codigo_oficina) references Oficinas,
primary key (numero_cuenta));

create table Titulares(
codigo_cliente number(3,0),
numero_cuenta number(3,0),
porcentaje_titularidad number(3,0),
foreign key (codigo_cliente) references Clientes,
foreign key (numero_cuenta) references Cuentas,
primary key (codigo_cliente, numero_cuenta));

create table Movimiento(
numero_cuenta number(3,0),
numero number(3,0),
tipo char(1),
valor number(10,2),
fecha_movimiento date,
foreign key (numero_cuenta) references Cuentas,
primary key (numero));
             
             
-- Tabla de titulares --
insert into Titulares VALUES (1,100,60);
insert into Titulares VALUES (1,200,40);
insert into Titulares VALUES (2,100,40);
insert into Titulares VALUES (2,200,60);
insert into Titulares VALUES (3,300,100);
insert into Titulares VALUES (4,400,100);
insert into Titulares VALUES (5,500,100);
insert into Titulares VALUES (6,600,100);        
             
             
             
             
