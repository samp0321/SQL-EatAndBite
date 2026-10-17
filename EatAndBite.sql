CREATE DATABASE EatAndBite;
GO
USE EatAndBite;
GO

CREATE TABLE Clientes (
    IdCliente     INT IDENTITY PRIMARY KEY,
    Nombre        NVARCHAR(60)  NOT NULL,
    Correo        NVARCHAR(100) NOT NULL UNIQUE,
    Telefono      VARCHAR(15)   NOT NULL,
    Direccion     NVARCHAR(40)  NOT NULL,
    FechaRegistro DATE          NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Administradores (
    IdAdmin      INT IDENTITY PRIMARY KEY,
    Nombre       NVARCHAR(60)  NOT NULL,
    Correo       NVARCHAR(100) NOT NULL UNIQUE,
    Cargo        NVARCHAR(40)  NOT NULL DEFAULT 'Admin'
);

CREATE TABLE Proveedores (
    IdProveedor  INT IDENTITY PRIMARY KEY,
    Empresa      NVARCHAR(80) NOT NULL,
    NIT          VARCHAR(15)  NOT NULL UNIQUE,
    Telefono     VARCHAR(15)  NOT NULL,
    Activo       BIT          NOT NULL DEFAULT 1
);

CREATE TABLE Productos (
    IdProducto   INT IDENTITY PRIMARY KEY,
    Nombre       NVARCHAR(80)  NOT NULL UNIQUE,
    Categoria    NVARCHAR(40)  NOT NULL,
    Precio       DECIMAL(10,2) NOT NULL CHECK (Precio > 0),
    Stock        INT           NOT NULL DEFAULT 0,
    IdProveedor  INT NOT NULL FOREIGN KEY REFERENCES Proveedores(IdProveedor),
    IdAdmin      INT NOT NULL FOREIGN KEY REFERENCES Administradores(IdAdmin)
);

CREATE TABLE Pedidos (
    IdPedido     INT IDENTITY PRIMARY KEY,
    IdCliente    INT NOT NULL FOREIGN KEY REFERENCES Clientes(IdCliente),
    IdProducto   INT NOT NULL,
    Cantidad     INT NOT NULL DEFAULT 1,
    FechaPedido  DATE NOT NULL DEFAULT GETDATE(),
    Estado       NVARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    Total        DECIMAL(12,2) NOT NULL DEFAULT 0
);
GO

-- ALTER TABLE: llave foránea faltante y nueva columna
ALTER TABLE Pedidos ADD CONSTRAINT FK_Pedidos_Productos
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto);
ALTER TABLE Pedidos ADD Calificacion TINYINT NULL CHECK (Calificacion BETWEEN 1 AND 5);
GO

-- ===================== 2. POBLACIÓN (INSERT) =====================
INSERT INTO Administradores (Nombre, Correo, Cargo) VALUES
('Laura Gómez','laura.gomez@vidaverde.co','Gerente'),
('Andrés Martínez','andres.martinez@vidaverde.co','Catálogo'),
('Camila Rodríguez','camila.rodriguez@vidaverde.co','Catálogo'),
('Santiago López','santiago.lopez@vidaverde.co','Logística'),
('Alejandro Sánchez','alejandro.sanchez@vidaverde.co','Marketing');

INSERT INTO Clientes (Nombre, Correo, Telefono, Direccion, FechaRegistro) VALUES
('Carolina Ruiz','carolina.ruiz@gmail.com','3104567812','Calle 123 #45-67','2025-11-03'),
('Juan Pardo','juan.pardo@hotmail.com','3157894512','Carrera 8 #23-45','2025-11-20'),
('Diana Castillo','diana.castillo@outlook.com','3204561237','Avenida 10 #78-90','2025-12-05'),
('Miguel Fonseca','miguel.fonseca@gmail.com','3001237894','Calle 45 #67-89','2025-12-18'),
('Samuel Ochoa','samuel.ochoa@gmail.com','3047539516','Carrera 8 #23-45','2026-09-30');

INSERT INTO Proveedores (Empresa, NIT, Telefono) VALUES
('Verde Vital S.A.S.','900123456-1','6017451230'),
('Granja La Esperanza','900234567-2','6017894561'),
('Océano Fresco Ltda.','900345678-3','6016547893'),
('Raíces Orgánicas','900456789-4','6013216548'),
('Sabor Natural del Valle','900567890-5','6024561234');

INSERT INTO Productos (Nombre, Categoria, Precio, Stock, IdProveedor, IdAdmin) VALUES
('Ensalada César con pollo','Ensaladas',22000,120,1,2),
('Ensalada de quinoa','Ensaladas',24000,100,2,3),
('Bowl de salmón y aguacate','Bowls',32000,80,3,2),
('Bowl teriyaki de tofu','Bowls',26000,90,4,3),
('Wrap integral de pavo','Wraps',18000,110,5,10);

INSERT INTO Pedidos (IdCliente, IdProducto, Cantidad, FechaPedido, Estado) VALUES
(1,1,2,'2026-01-12','Entregado'),
(6,7,4,'2026-03-19','Cancelado'),
(7,8,2,'2026-04-06','Entregado'),
(8,9,2,'2026-04-18','Entregado'),
(18,4,1,'2026-10-14','Pendiente');
GO
SELECT FROM CLIENTES;
SELECT IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro FROM CLIENTES
    WHERE IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro = 'Carolina Ruiz','carolina.ruiz@gmail.com','3104567812','Calle 123 #45-67','2025-11-03';
SELECT FROM CLIENTES;
SELECT IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro FROM CLIENTES
    WHERE IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro = 'Juan Pardo','juan.pardo@hotmail.com','3157894512','Carrera 8 #23-45','2025-11-20';
SELECT FROM CLIENTES;
SELECT IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro FROM CLIENTES
    WHERE IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro = 'Diana Castillo','diana.castillo@outlook.com','3204561237','Avenida 10 #78-90','2025-12-05';
SELECT FROM CLIENTES;
SELECT IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro FROM CLIENTES
    WHERE IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro = 'Miguel Fonseca','miguel.fonseca@gmail.com','3001237894','Calle 45 #67-89','2025-12-18';
SELECT FROM CLIENTES;
SELECT IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro FROM CLIENTES
    WHERE IdNombre,Nombre,Correo,Telefono,Direccion,FechaRegistro = 'Samuel Ochoa','samuel.ochoa@gmail.com','3047539516','Carrera 8 #23-45','2026-09-30';


SELECT FROM Administrador ;
SELECT IdAdmin,Nombre,Correo,Cargo FROM Administrador 
    WHERE IdAdmin,Nombre,Correo,Cargo = 'Laura Gómez','laura.gomez@vidaverde.co','Gerente';
SELECT FROM Administrador ;
SELECT IdAdmin,Nombre,Correo,Cargo FROM Administrador 
    WHERE IdAdmin,Nombre,Correo,Cargo = 'Andrés Martínez','andres.martinez@vidaverde.co','Catálogo';
SELECT IdAdmin,Nombre,Correo,Cargo FROM Administrador 
    WHERE IdAdmin,Nombre,Correo,Cargo = 'Camila Rodríguez','camila.rodriguez@vidaverde.co','Catálogo';
SELECT IdAdmin,Nombre,Correo,Cargo FROM Administrador 
    WHERE IdAdmin,Nombre,Correo,Cargo = 'Santiago López','santiago.lopez@vidaverde.co','Logística';
SELECT IdAdmin,Nombre,Correo,Cargo FROM Administrador 
    WHERE IdAdmin,Nombre,Correo,Cargo = 'Alejandro Sánchez','alejandro.sanchez@vidaverde.co','Marketing';
    
SELECT FROM Proveedor ;
SELECT IdProveedor,Empresa,Nit,Telefono,Activo FROM Proveedor 
    WHERE IdProveedor,Empresa,Nit,Telefono,Activo = 'Verde Vital S.A.S.','900123456-1','6017451230';
SELECT FROM Proveedor ;
SELECT IdProveedor,Empresa,Nit,Telefono,Activo FROM Proveedor 
    WHERE IdProveedor,Empresa,Nit,Telefono,Activo = 'Granja La Esperanza','900234567-2','6017894561';
SELECT FROM Proveedor ;
SELECT IdProveedor,Empresa,Nit,Telefono,Activo FROM Proveedor 
    WHERE IdProveedor,Empresa,Nit,Telefono,Activo = 'Océano Fresco Ltda.','900345678-3','6016547893';
SELECT FROM Proveedor ;
SELECT IdProveedor,Empresa,Nit,Telefono,Activo FROM Proveedor 
    WHERE IdProveedor,Empresa,Nit,Telefono,Activo = 'Raíces Orgánicas','900456789-4','6013216548';

SELECT FROM Proveedor ;
SELECT IdProveedor,Empresa,Nit,Telefono,Activo FROM Proveedor 
    WHERE IdProveedor,Empresa,Nit,Telefono,Activo ='Sabor Natural del Valle','900567890-5','6024561234';


SELECT FROM Productos;
SELECT Nombre,Categoria,Precio,Stock FROM Productos 
    WHERE nombre,Categoria,Precio,Stock = 'Ensalada Cesar','Ensaladas','22000','120';
SELECT FROM Productos;
SELECT Nombre,Categoria,Precio,Stock FROM Productos 
    WHERE nombre,Categoria,Precio,Stock = 'Ensalada de quinoa','Ensaladas','24000','100';
SELECT FROM Productos;
SELECT Nombre,Categoria,Precio,Stock FROM Productos 
    WHERE Nombre,Categoria,Precio,Stock = 'Bowl de Salmon y aguacate ','Bowls','32000','80';
SELECT FROM Productos;
SELECT Nombre,Categoria,Precio,Stock FROM Productos 
    WHERE Nombre,Categoria,Precio,Stock = 'Bowl Teriyaki de tofu','Bowls','26000','90';
SELECT FROM Productos;
SELECT Nombre,Categoria,Precio,Stock FROM Productos 
    WHERE Nombre,Categoria,Precio,Stock = 'WRAP integral de pavo ','Wraps','18000','110';

SELECT FROM Pedidos;
SELECT IdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado FROM Pedidos
    WHEREIdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado = 1,1,2,'2026-01-12','Entregado',
SELECT FROM Pedidos;
SELECT IdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado FROM Pedidos
    WHEREIdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado = 6,7,4,'2026-03-19','Cancelado';
SELECT FROM Pedidos;
SELECT IdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado FROM Pedidos
    WHEREIdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado = 7,8,2,'2026-04-06','Entregado';
SELECT FROM Pedidos;
SELECT IdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado FROM Pedidos
    WHEREIdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado = 8,9,2,'2026-04-18','Entregado';
SELECT FROM Pedidos;
SELECT IdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado FROM Pedidos
    WHEREIdPedido,IdCliente,IdProducto,Cantidad,FechaPedido,Estado = 18,4,1,'2026-10-14','Pendiente';

---- actualizar 
UPDATE Clientes
SET Correo = 'cmruiz@gg.com';
WHERE Nombre = 'Carolina Ruiz';

UPDATE Clientes
SET Telefono = '3205506070';
WHERE Nombre = 'Juan Pardo';


UPDATE Administrador 
SET Cargo = 'CEO';
WHERE Nombre = 'Laura Gomez';


UPDATE Administrador 
SET Correo = 'cfrodriguez@mm.com';
WHERE Nombre = 'Camila Rodriguez';


UPDATE Proveedor
SET  Stock = 150;
WHERE Nit = '900123456-1';
    
UPDATE Proveedor
SET  Stock = 200;
WHERE Nit = '900234567-2';


UPDATE Productos 
SET Precio = 28000;
WHERE Nombre = 'Ensalada Cesar';

UPDATE Productos 
SET Stock = 3;
WHERE Nombre = 'Ensalada Cesar';

UPDATE Productos
SET Categoria = 'Comida Oriental';
WHERE  Nombre = 'Bowl teriyaki';

UPDATE Pedidos
SET Estado = 'En curso';
WHERE IdPedido = '8'

UPDATE Pedidos
SET FechaPedido ='2026-10-31' ;
WHERE IdPedido = '18';

--- eliminar 
