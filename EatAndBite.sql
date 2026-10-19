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

ALTER TABLE Pedidos ADD CONSTRAINT FK_Pedidos_Productos
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto);
ALTER TABLE Pedidos ADD Calificacion INT NULL CHECK (Calificacion BETWEEN 1 AND 5);
GO

-- INSERT
INSERT INTO Administradores (Nombre, Correo, Cargo) VALUES
('Laura Gómez','laura.gomez@vidaverde.co','Gerente'),
('Andrés Martínez','andres.martinez@vidaverde.co','Catálogo'),
('Camila Rodríguez','camila.rodriguez@vidaverde.co','Catálogo'),
('Santiago López','santiago.lopez@vidaverde.co','Logística'),
('Alejandro Sánchez','alejandro.sanchez@vidaverde.co','Marketing'),
('Valentina Herrera','valentina.herrera@vidaverde.co','Ventas'),
('Nicolás Torres','nicolas.torres@vidaverde.co','Catálogo'),
('Mariana Castro','mariana.castro@vidaverde.co','Logística'),
('Sebastián Ramírez','sebastian.ramirez@vidaverde.co','Marketing'),
('Gabriela Ortiz','gabriela.ortiz@vidaverde.co','Ventas'),
('Daniela Moreno','daniela.moreno@vidaverde.co','Catálogo'),
('Mateo Vargas','mateo.vargas@vidaverde.co','Logística'),
('Isabella Rojas','isabella.rojas@vidaverde.co','Marketing'),
('Felipe Mendoza','felipe.mendoza@vidaverde.co','Ventas'),
('Lucía Jiménez','lucia.jimenez@vidaverde.co','Catálogo'),
('Tomás Romero','tomas.romero@vidaverde.co','Logística'),
('Paula Navarro','paula.navarro@vidaverde.co','Marketing'),
('Emilio Silva','emilio.silva@vidaverde.co','Ventas'),
('Sara Cárdenas','sara.cardenas@vidaverde.co','Catálogo'),
('Iván Delgado','ivan.delgado@vidaverde.co','Logística');

INSERT INTO Clientes (Nombre, Correo, Telefono, Direccion, FechaRegistro) VALUES
('Carolina Ruiz','carolina.ruiz@gmail.com','3104567812','Calle 123 #45-67','2025-11-03'),
('Juan Pardo','juan.pardo@hotmail.com','3157894512','Carrera 8 #23-45','2025-11-20'),
('Diana Castillo','diana.castillo@outlook.com','3204561237','Avenida 10 #78-90','2025-12-05'),
('Miguel Fonseca','miguel.fonseca@gmail.com','3001237894','Calle 45 #67-89','2025-12-18'),
('Samuel Ochoa','samuel.ochoa@gmail.com','3047539516','Carrera 8 #23-45','2026-09-30'),
('Ana Beltrán','ana.beltran@gmail.com','3112345678','Calle 10 #12-34','2026-01-05'),
('David Cárdenas','david.cardenas@hotmail.com','3123456789','Carrera 15 #20-18','2026-01-12'),
('Laura Méndez','laura.mendez@outlook.com','3134567890','Avenida 6 #30-45','2026-01-20'),
('Carlos Rincón','carlos.rincon@gmail.com','3145678901','Calle 72 #8-16','2026-02-02'),
('Sofía Acosta','sofia.acosta@hotmail.com','3156789012','Carrera 4 #51-29','2026-02-14'),
('Julián Peña','julian.pena@outlook.com','3167890123','Calle 34 #19-52','2026-03-01'),
('Natalia León','natalia.leon@gmail.com','3178901234','Avenida 19 #44-10','2026-03-11'),
('Óscar Fuentes','oscar.fuentes@hotmail.com','3189012345','Carrera 12 #63-21','2026-04-03'),
('Manuela Gil','manuela.gil@outlook.com','3190123456','Calle 5 #27-38','2026-04-22'),
('Esteban Cruz','esteban.cruz@gmail.com','3002345678','Avenida 3 #16-40','2026-05-09'),
('Paola Salazar','paola.salazar@hotmail.com','3013456789','Carrera 20 #11-75','2026-06-17'),
('Ricardo Vega','ricardo.vega@outlook.com','3024567890','Calle 88 #7-23','2026-07-08'),
('Elena Cabrera','elena.cabrera@gmail.com','3035678901','Carrera 9 #39-64','2026-08-26'),
('Martín Duarte','martin.duarte@hotmail.com','3056789012','Avenida 15 #22-31','2026-09-15'),
('Verónica Lozano','veronica.lozano@outlook.com','3067890123','Calle 41 #18-57','2026-10-02');

INSERT INTO Proveedores (Empresa, NIT, Telefono) VALUES
('Verde Vital S.A.S.','900123456-1','6017451230'),
('Granja La Esperanza','900234567-2','6017894561'),
('Océano Fresco Ltda.','900345678-3','6016547893'),
('Raíces Orgánicas','900456789-4','6013216548'),
('Sabor Natural del Valle','900567890-5','6024561234'),
('Huerta El Paraíso','900678901-6','6014567890'),
('Avícola San Miguel','900789012-7','6043456789'),
('Pescados del Caribe','900890123-8','6052345678'),
('Granos Selectos','900901234-9','6019876543'),
('Lácteos La Pradera','901012345-0','6027654321'),
('Panadería Integral','901123456-1','6018765432'),
('Frutas La Montaña','901234567-2','6045678901'),
('Especias de Oriente','901345678-3','6017654321'),
('Cárnicos Buen Corte','901456789-4','6026543210'),
('Bebidas Naturales','901567890-5','6056789012'),
('Semillas y Brotes','901678901-6','6013456789'),
('Café de Altura','901789012-7','6048765432'),
('Legumbres Andinas','901890123-8','6025432109'),
('Distribuciones Frescas','901901234-9','6016549873'),
('Delicias Veganas','902012345-0','6054321098');

INSERT INTO Productos (Nombre, Categoria, Precio, Stock, IdProveedor, IdAdmin) VALUES
('Ensalada César con pollo','Ensaladas',22000,120,1,2),
('Ensalada de quinoa','Ensaladas',24000,100,2,3),
('Bowl de salmón y aguacate','Bowls',32000,80,3,2),
('Bowl teriyaki de tofu','Bowls',26000,90,4,3),
('Wrap integral de pavo','Wraps',18000,110,5,5),
('Ensalada mediterránea','Ensaladas',21000,75,6,6),
('Bowl de pollo al curry','Bowls',27500,65,7,7),
('Tacos de pescado','Platos fuertes',29000,50,8,8),
('Lentejas con verduras','Platos fuertes',19000,85,9,9),
('Yogur con granola','Desayunos',14000,100,10,10),
('Sándwich de vegetales','Sándwiches',16500,70,11,11),
('Jugo de frutos rojos','Bebidas',9500,120,12,12),
('Sopa de tomate','Sopas',15500,60,13,13),
('Carne magra con arroz','Platos fuertes',31000,45,14,14),
('Limonada de hierbabuena','Bebidas',8000,130,15,15),
('Bowl de falafel','Bowls',23000,90,16,16),
('Arepa de huevo horneada','Desayunos',12500,55,17,17),
('Ensalada de garbanzos','Ensaladas',20000,80,18,18),
('Pasta al pesto','Pastas',26500,65,19,19),
('Hamburguesa de lentejas','Platos fuertes',24500,70,20,20);

INSERT INTO Pedidos (IdCliente, IdProducto, Cantidad, FechaPedido, Estado) VALUES
(1,1,2,'2026-01-12','Entregado'),
(6,7,4,'2026-03-19','Cancelado'),
(7,8,2,'2026-04-06','Entregado'),
(8,9,2,'2026-04-18','Entregado'),
(18,4,1,'2026-10-14','Pendiente'),
(2,2,1,'2026-01-15','Entregado'),
(3,3,1,'2026-01-22','Entregado'),
(4,4,2,'2026-02-03','En curso'),
(5,5,1,'2026-02-18','Entregado'),
(9,6,3,'2026-03-05','Entregado'),
(10,10,2,'2026-03-22','Pendiente'),
(11,11,1,'2026-04-11','Entregado'),
(12,12,4,'2026-05-02','Cancelado'),
(13,13,2,'2026-05-20','Entregado'),
(14,14,1,'2026-06-09','En curso'),
(15,15,3,'2026-06-25','Entregado'),
(16,16,2,'2026-07-14','Pendiente'),
(17,17,1,'2026-08-01','Entregado'),
(19,18,2,'2026-09-10','Entregado'),
(20,20,1,'2026-10-01','Pendiente');
GO

-- Calcula el total de cada pedido con el precio vigente al momento de cargar los datos.
UPDATE pe
SET Total = pe.Cantidad * pr.Precio
FROM Pedidos AS pe
INNER JOIN Productos AS pr ON pr.IdProducto = pe.IdProducto;
GO

SELECT IdCliente, 
        Nombre, 
        Correo, 
        Telefono, 
        Direccion, 
        FechaRegistro 
    FROM Clientes;

SELECT IdAdmin, 
        Nombre, 
        Correo, 
        Cargo 
    FROM Administradores;

SELECT IdProveedor, 
        Empresa, 
        NIT, 
        Telefono, 
        Activo 
    FROM Proveedores;

SELECT IdProducto, 
        Nombre, 
        Categoria, 
        Precio, 
        Stock, 
        IdProveedor, 
        IdAdmin 
    FROM Productos;

SELECT IdPedido, 
        IdCliente, 
        IdProducto, 
        Cantidad, 
        FechaPedido, 
        Estado, 
        Total, 
        Calificacion 
    FROM Pedidos;

-- Actualizaciones de ejemplo
UPDATE Clientes
SET Correo = 'cmruiz@gg.com'
WHERE Nombre = 'Carolina Ruiz';

UPDATE Clientes
SET Telefono = '3205506070'
WHERE Nombre = 'Juan Pardo';

UPDATE Administradores
SET Cargo = 'CEO'
WHERE Nombre = 'Laura Gómez';

UPDATE Administradores
SET Correo = 'cfrodriguez@mm.com'
WHERE Nombre = 'Camila Rodríguez';

UPDATE Productos
SET Precio = 28000
WHERE Nombre = 'Ensalada César con pollo';

UPDATE Productos
SET Stock = 3
WHERE Nombre = 'Ensalada César con pollo';

UPDATE Productos
SET Categoria = 'Comida Oriental'
WHERE Nombre = 'Bowl teriyaki de tofu';

UPDATE Pedidos
SET Estado = 'En curso'
WHERE IdPedido = 8;

UPDATE Pedidos
SET FechaPedido = '2026-10-31'
WHERE IdPedido = 18;

-- ¿Cuáles fueron las ventas completadas por mes?
SELECT YEAR(FechaPedido) AS Anio,
       MONTH(FechaPedido) AS Mes,
       SUM(Total) AS VentasTotales
FROM Pedidos
WHERE Estado = 'Entregado'
GROUP BY YEAR(FechaPedido), MONTH(FechaPedido)
ORDER BY Anio, Mes;

-- ¿Qué productos vendieron más unidades en pedidos entregados?
SELECT TOP (5)
       pr.Nombre AS Producto,
       SUM(pe.Cantidad) AS UnidadesVendidas
FROM Pedidos AS pe
INNER JOIN Productos AS pr ON pr.IdProducto = pe.IdProducto
WHERE pe.Estado = 'Entregado'
GROUP BY pr.IdProducto, pr.Nombre
ORDER BY UnidadesVendidas DESC, pr.Nombre;

-- ¿Qué clientes generaron más ventas con pedidos entregados?
SELECT TOP (10)
       cl.IdCliente,
       cl.Nombre AS Cliente,
       SUM(pe.Total) AS TotalComprado
FROM Pedidos AS pe
INNER JOIN Clientes AS cl ON cl.IdCliente = pe.IdCliente
WHERE pe.Estado = 'Entregado'
GROUP BY cl.IdCliente, cl.Nombre
ORDER BY TotalComprado DESC, cl.Nombre;

-- ¿Qué categorías acumularon al menos 50.000 en ventas entregadas?
SELECT pr.Categoria,
       SUM(pe.Total) AS VentasCategoria
FROM Pedidos AS pe
INNER JOIN Productos AS pr ON pr.IdProducto = pe.IdProducto
WHERE pe.Estado = 'Entregado'
GROUP BY pr.Categoria
HAVING SUM(pe.Total) >= 50000
ORDER BY VentasCategoria DESC;

-- ¿Qué productos tienen 10 unidades o menos y quien es el proovedor??
SELECT pr.Nombre AS Producto,
       pr.Stock,
       pv.Empresa AS Proveedor
FROM Productos AS pr
INNER JOIN Proveedores AS pv ON pv.IdProveedor = pr.IdProveedor
WHERE pr.Stock <= 10
ORDER BY pr.Stock, pr.Nombre;
