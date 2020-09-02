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
             
insert into cuentas values (100, 'A', 10, null, 0);
insert into cuentas values (200, 'A', 10, null, 100);
insert into cuentas values (300, 'C', 10, null, 500);
insert into cuentas values (400, 'C', 10, null, 1000);
insert into cuentas values (500, 'A', 10, null, 100);
insert into cuentas values (600, 'A', 10, null, 50);
