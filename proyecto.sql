-- *Objetivo:* Diseñar y manipular una base de datos relacional para gestionar las operaciones básicas de una tienda en línea.

-- ### Parte 1: Estructura de la Base de Datos (DDL)

-- Crea una base de datos llamada e_commerce y genera las siguientes tablas respetando las claves primarias (PK) y foráneas (FK) para mantener la integridad referencial.

-- *1. Tabla: usuarios*
-- * id (INT, PK, Auto-incremental)
-- * nombre (VARCHAR, no nulo)
-- * apellido (VARCHAR, no nulo)
-- * email (VARCHAR, único)
-- * fecha_registro (TIMESTAMP)
-- * fecha_actualizacion (TIMESTAMP)

-- *2. Tabla: productos*
-- * id (INT, PK, Auto-incremental)
-- * nombre (VARCHAR)
-- * precio (DECIMAL 10,2)
-- * stock (INT)
-- * fecha_registro (TIMESTAMP)
-- * fecha_actualizacion (TIMESTAMP)

-- *3. Tabla: compras* (Cabecera del pedido)
-- * id (INT, PK, Auto-incremental)
-- * usuario_id (INT, FK referenciando a usuarios)
-- * fecha (DATE)
-- * total (DECIMAL 10,2)
-- * fecha_registro (TIMESTAMP)
-- * fecha_actualizacion (TIMESTAMP)

-- *4. Tabla: detalles_compras* (Líneas del pedido)
-- * id (INT, PK, Auto-incremental)
-- * compra_id (INT, FK referenciando a compras)
-- * producto_id (INT, FK referenciando a productos)
-- * cantidad (INT)
-- * precio_unitario (DECIMAL 10,2) - Importante: guarda el precio en el momento de la compra.
-- * fecha_registro (TIMESTAMP)
-- * fecha_actualizacion (TIMESTAMP)

-- ---

-- ### Parte 2: Ejercicios de Manipulación de Datos (DML)

-- Realiza las siguientes operaciones mediante sentencias SQL.

-- #### A. Ejercicios de Insertar Datos (INSERT)
-- 1.  *Registrar Usuarios:* Inserta 3 usuarios nuevos (ej. 'Ana López', 'Carlos Ruiz', 'Maria Gomez') con sus respectivos correos y fecha de hoy.
-- 2.  *Inventario Inicial:* Inserta 5 productos diferentes (ej. 'Laptop', 'Mouse', 'Teclado', 'Monitor', 'Auriculares') con precios y cantidades de stock variadas.
-- 3.  *Simular una Compra:*
--     * Crea una inserción en la tabla compras para el usuario 'Ana López'.
--     * Inserta 2 registros en detalles_compras vinculados a la compra anterior (ej. Ana compró 1 Laptop y 2 Mouse).

-- #### B. Ejercicios de Buscar Datos (SELECT Simple)
-- 4.  *Listar Productos:* Obtén una lista de todos los productos disponibles (nombre y precio).
-- 5.  *Filtro de Precios:* Muestra los productos que cuestan más de $100.00.
-- 6.  *Búsqueda de Usuario:* Encuentra el correo electrónico del usuario cuyo nombre es 'Carlos Ruiz'.
-- 7.  *Stock Bajo:* Muestra los productos que tienen menos de 5 unidades en stock.

-- #### C. Ejercicios de Buscar Datos Relacionales (JOINS)
-- 8.  *Historial de Compras:* Muestra una lista que incluya el nombre del usuario y la fecha de cada compra que ha realizado (Usa INNER JOIN entre usuarios y compras).
-- 9.  *Detalle de Factura:* Muestra el nombre del producto, la cantidad comprada y el precio unitario para una compra específica (filtra por un id de compra).
-- 10. *Compras por Usuario:* Obtén el nombre del usuario y el nombre de los productos que ha comprado en toda su historia (Requiere unir usuarios, compras, detalles_compras y productos).

-- #### D. Ejercicios de Actualizar Datos (UPDATE)
-- 11. *Ajuste de Precios:* Debido a la inflación, aumenta el precio de todos los productos en un 10%.
-- 12. *Actualizar Stock:* El usuario 'Ana López' acaba de comprar productos; actualiza el stock de la tabla productos restando la cantidad comprada en el ejercicio 3.
-- 13. *Corrección de Datos:* Cambia el correo electrónico del usuario 'Maria Gomez' a 'maria.nuevo@mail.com'.

-- #### E. Ejercicios de Borrar Datos (DELETE)
-- 14. *Cancelar Detalle:* Borra uno de los ítems de la tabla detalles_compras (como si el usuario hubiera devuelto un producto).
-- 15. *Eliminar Producto:* Intenta borrar un producto que no ha sido vendido nunca.
-- 16. *Limpieza de Usuarios:* Borra a los usuarios que no han realizado ninguna compra (Usa una subconsulta o LEFT JOIN para identificarlos).

-- fecha de entrega 24/11/25

-- ### Parte 1: Estructura de la Base de Datos (DDL)


-- Create Database
CREATE DATABASE e_commerce;

-- Parte 1: Use the database

-- 1. Crear tabla usuarios
CREATE TABLE usuarios(
	id BIGINT(25) AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

-- 2. Crear tabla productos
CREATE TABLE productos(
  id BIGINT(25) AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  stock BIGINT,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

-- 3. Crear tabla compras
CREATE TABLE compras(
  id BIGINT(25) AUTO_INCREMENT PRIMARY KEY,
  usuario_id BIGINT(25),
  fecha DATE DEFAULT CURRENT_DATE,
  total DECIMAL(10,2),
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
)

-- 4. Crear tabla detalles_compras
CREATE TABLE detalles_compras(
  id BIGINT(25) AUTO_INCREMENT PRIMARY KEY,
  compra_id BIGINT(25),
  producto_id BIGINT(25),
  cantidad BIGINT,
  precio_unitario DECIMAL(10,2),
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (compra_id) REFERENCES compras(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
)

-- ### Parte 2: Ejercicios de Manipulación de Datos (DML)

-- A. Ejercicios de Insertar Datos (INSERT)

-- 1. Registrar Usuarios

INSERT INTO usuarios(`nombre`, `apellido`, `email`) VALUES ('luis','rojas','luisrojas@gmail.com') , ('elianny', 'romero', 'eliannyromero@gmail.com'), ('juan', 'rodriguez', 'juanrodriguez@gmail.com')

-- 2. Inventario Inicial
INSERT INTO productos(`nombre`, `precio`, `stock`) VALUES ('teclado', '10.50', '20'), ('mesa', '15', '50'), ('tablet', '500.99', '5'), ('monitor', '150.99', '25'), ('audifonos', '20.50', '13')

-- 3. Simular una Compra

INSERT INTO compras(`usuario_id`, `total`) VALUES (1, '46')

INSERT INTO detalles_compras(`compra_id`, `producto_id`, `cantidad`, `precio_unitario`) VALUES (1, 1, 1, '10.50'), (1, 2, 1, '15'), (1, 5, 1, '20.50')

-- B. Ejercicios de Buscar Datos (SELECT Simple)

-- 4. Listar Productos

SELECT nombre, precio FROM productos;

-- 5. Filtro de Precios

SELECT * FROM productos WHERE precio > 100.00;

-- 6. Búsqueda de Usuario

SELECT email FROM usuarios WHERE nombre = 'elianny' AND apellido = 'romero';

-- 7. Stock Bajo

SELECT * FROM productos WHERE stock < 5;

-- C. Ejercicios de Buscar Datos Relacionales (JOINS)

-- 8. Historial de Compras

SELECT u.nombre, u.apellido, c.fecha FROM usuarios u INNER JOIN compras c ON u.id = c.usuario_id;

-- 9. Detalle de Factura

SELECT p.nombre, dc.cantidad, dc.precio_unitario FROM detalles_compras dc INNER JOIN productos p ON dc.producto_id = p.id WHERE dc.compra_id = 1;

-- 10. Compras por Usuario

SELECT u.nombre, u.apellido, p.nombre FROM usuarios u INNER JOIN compras c ON u.id = c.usuario_id INNER JOIN detalles_compras dc ON c.id = dc.compra_id INNER JOIN productos p ON dc.producto_id = p.id;

-- D. Ejercicios de Actualizar Datos (UPDATE)

-- 11. Ajuste de Precios

UPDATE productos SET precio = precio * 1.10;

-- 12. Actualizar Stock

UPDATE productos SET stock = stock - 1 WHERE id IN (1, 2, 5);

-- 13. Corrección de Datos

UPDATE usuarios SET email = 'eliannynuevo@gmail.com' WHERE nombre = 'elianny' AND apellido = 'romero';

-- E. Ejercicios de Borrar Datos (DELETE)

-- 14. Cancelar Detalle

DELETE FROM detalles_compras WHERE id = 2;

-- 15. Eliminar Producto

DELETE FROM productos WHERE id = 3;

-- 16. Limpieza de Usuarios

DELETE u FROM usuarios u LEFT JOIN compras c ON u.id = c.usuario_id WHERE c.id IS NULL;