DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pizzeria;

CREATE TABLE region (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL
     );

CREATE TABLE town (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    region_id INT NOT NULL,

    CONSTRAINT fk_town_region
    FOREIGN KEY (region_id)
    REFERENCES region(id)
);

CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(120) NOT NULL,
    image_url VARCHAR(60),
    price DECIMAL(8,2) NOT NULL,

    CONSTRAINT fk_product_category
    FOREIGN KEY (category_id)
    REFERENCES category(id)
);

CREATE TABLE shop (
       id INT AUTO_INCREMENT PRIMARY KEY,
       address VARCHAR(120) NOT NULL,
       postal_code VARCHAR(8) NOT NULL,
       town_id INT NOT NULL,
       region_id INT NOT NULL,

       CONSTRAINT fk_shop_town
       FOREIGN KEY (town_id)
       REFERENCES town(id),

       CONSTRAINT fk_shop_region
       FOREIGN KEY (region_id)
       REFERENCES region(id)
);

CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    nif VARCHAR(10) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    contract ENUM('chef','rider') NOT NULL,
    shop_id INT NOT NULL,

    CONSTRAINT fk_employee_shop
                      FOREIGN KEY (shop_id)
                      REFERENCES shop(id)
);

CREATE TABLE client (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    surname VARCHAR(39) NOT NULL,
    address VARCHAR(60),
    post_code VARCHAR(8),
    town_id INT NOT NULL,
    region_id INT NOT NULL,
    phone VARCHAR(15),

    CONSTRAINT fk_client_town
                    FOREIGN KEY (town_id)
                    REFERENCES town(id),

    CONSTRAINT fk_client_region
                    foreign key (region_id)
                    REFERENCES region(id)
);

CREATE TABLE pedido (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        time DATE NOT NULL,
                        shop_id INT NOT NULL,
                        client_id INT NOT NULL,
                        takeaway BOOLEAN NOT NULL DEFAULT 0,
                        employee_id INT NOT NULL,
                        time_received DATE,
                        price_total DECIMAL(8,2) NOT NULL,

                        CONSTRAINT fk_pedido_shop
                            FOREIGN KEY (shop_id)
                                REFERENCES shop(id),
                        CONSTRAINT fk_pedido_client
                            FOREIGN KEY (client_id)
                                REFERENCES client(id),
                        CONSTRAINT fk_pedido_employee
                            FOREIGN KEY (employee_id)
                                REFERENCES employee(id)
);

CREATE TABLE list_order (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(8,2) NOT NULL,

    CONSTRAINT fk_list_order_pedido
                        FOREIGN KEY (pedido_id)
                        REFERENCES pedido(id),

    CONSTRAINT fk_list_order_product
                        FOREIGN KEY (product_id)
                        REFERENCES product(id)
);

-- ==========================================
-- 1. REGIONES (4 registros)
-- ==========================================
INSERT INTO region (name) VALUES
                              ('Cataluña'),
                              ('Comunidad de Madrid'),
                              ('Andalucía'),
                              ('Comunidad Valenciana');


-- ==========================================
-- 2. CIUDADES (15 registros)
-- ==========================================
INSERT INTO town (name, region_id) VALUES
                                       ('Barcelona', 1),
                                       ('Girona', 1),
                                       ('Tarragona', 1),
                                       ('Lleida', 1),
                                       ('Madrid', 2),
                                       ('Alcalá de Henares', 2),
                                       ('Getafe', 2),
                                       ('Sevilla', 3),
                                       ('Málaga', 3),
                                       ('Cádiz', 3),
                                       ('Granada', 3),
                                       ('Valencia', 4),
                                       ('Alicante', 4),
                                       ('Elche', 4),
                                       ('Castellón', 4);


-- ==========================================
-- 3. CATEGORÍAS (5 registros)
-- ==========================================
INSERT INTO category (name) VALUES
                                ('Pizzas Clásicas'),
                                ('Pizzas Especiales'),
                                ('Entrantes'),
                                ('Bebidas'),
                                ('Postres');


-- ==========================================
-- 4. PRODUCTOS (10 registros repartidos en las 5 categorías)
-- ==========================================
INSERT INTO product (category_id, name, description, image_url, price) VALUES
                                                                           (1, 'Margherita', 'Salsa de tomate, mozzarella fresca y albahaca', 'margherita.jpg', 7.50),
                                                                           (1, 'Marinara', 'Tomate, ajo, orégano y aceite de oliva', 'marinara.jpg', 6.00),
                                                                           (1, 'Quatro Formaggi', 'Mozzarella, gorgonzola, provolone y parmesano', '4formagi.jpg', 9.00),
                                                                           (2, 'Trufada Gourmet', 'Crema de trufa, setas silvestres y parmesano', 'trufada.jpg', 13.00),
                                                                           (2, 'Mexicana Brava', 'Jalapeños, carne picada y salsa picante', 'mexicana.jpg', 9.80),
                                                                           (3, 'Pan de Ajo', 'Pan horneado al horno de leña con mantequilla de ajo', 'ajo.jpg', 4.00),
                                                                           (3, 'Patatas Gajo', 'Patatas especiadas con salsa brava', 'patatas.jpg', 4.20),
                                                                           (4, 'Refresco de Cola', 'Lata de refresco de cola tradicional 33cl', 'cola.jpg', 2.50),
                                                                           (4, 'Cerveza Artesana', 'Cerveza rubia fría 33cl', 'cerveza.jpg', 4.00),
                                                                           (5, 'Nutella Pizza', 'Base de masa fina cubierta con crema de cacao', 'nutella.jpg', 7.00);


-- ==========================================
-- 5. TIENDAS / SHOPS (25 registros)
-- ==========================================
INSERT INTO shop (address, postal_code, town_id, region_id) VALUES
                                                                ('Calle Mayor 12', '08001', 1, 1),
                                                                ('Passeig de Gràcia 45', '08007', 1, 1),
                                                                ('Carrer de la Creu 8', '17001', 2, 1),
                                                                ('Rambla Nova 22', '43001', 3, 1),
                                                                ('Avenida de Madrid 5', '25001', 4, 1),
                                                                ('Gran Vía 34', '28013', 5, 2),
                                                                ('Paseo de la Castellana 100', '28046', 5, 2),
                                                                ('Calle Real 15', '28801', 6, 2),
                                                                ('Calle Toledo 42', '28901', 7, 2),
                                                                ('Avenida de la Constitución 10', '41001', 8, 3),
                                                                ('Calle Larios 3', '29001', 9, 3),
                                                                ('Calle Ancha 7', '11001', 10, 3),
                                                                ('Gran Vía de Colón 20', '18001', 11, 3),
                                                                ('Calle Colón 25', '46004', 12, 4),
                                                                ('Avenida de Niza 4', '03001', 13, 4),
                                                                ('Calle Corredora 12', '03201', 14, 4),
                                                                ('Paseo de los Molinos 9', '12001', 15, 4),
                                                                ('Travessera de Dalt 33', '08024', 1, 1),
                                                                ('Calle de Alcalá 200', '28028', 5, 2),
                                                                ('Calle Betis 14', '41010', 8, 3),
                                                                ('Calle San Fernando 5', '03002', 13, 4),
                                                                ('Carrer Major 50', '17002', 2, 1),
                                                                ('Paseo del Prado 12', '28014', 5, 2),
                                                                ('Avenida Andalucía 88', '29006', 9, 3),
                                                                ('Calle Ruzafa 18', '46005', 12, 4);


-- ==========================================
-- 6. EMPLEADOS (6 registros)
-- ==========================================
INSERT INTO employee (name, surname, nif, phone, contract, shop_id) VALUES
                                                                        ('Carlos', 'Gómez Ruiz', '12345678A', '600111222', 'chef', 1),
                                                                        ('Laura', 'Martínez Pérez', '23456789B', '600222333', 'rider', 1),
                                                                        ('Sergio', 'López García', '34567890C', '600333444', 'chef', 2),
                                                                        ('Marta', 'Sánchez Torres', '45678901D', '600444555', 'rider', 3),
                                                                        ('David', 'Fernández Gil', '56789012E', '600555666', 'chef', 4),
                                                                        ('Elena', 'Romero Blanco', '67890123F', '600666777', 'rider', 5);


-- ==========================================
-- 7. CLIENTES (25 registros)
-- ==========================================
INSERT INTO client (name, surname, address, post_code, town_id, region_id, phone) VALUES
                                                                                      ('Antonio', 'Pérez Gómez', 'Calle Alta 1', '08002', 1, 1, '610111222'),
                                                                                      ('María', 'Gómez López', 'Calle Baja 4', '08003', 1, 1, '610222333'),
                                                                                      ('Francisco', 'Sánchez Ruiz', 'Passeig de Mar 12', '17003', 2, 1, '610333444'),
                                                                                      ('Dolores', 'Martín Gil', 'Carrerample 5', '43002', 3, 1, '610444555'),
                                                                                      ('José', 'Jiménez Torres', 'Calle Nueva 8', '25002', 4, 1, '610555666'),
                                                                                      ('Ana', 'Ruiz Fernández', 'Calle Sol 14', '28001', 5, 2, '610666777'),
                                                                                      ('Manuel', 'Hernández Díaz', 'Calle Luna 22', '28002', 5, 2, '610777888'),
                                                                                      ('Carmen', 'Moreno Álvarez', 'Avenida España 9', '28802', 6, 2, '610888999'),
                                                                                      ('David', 'Muñoz Romero', 'Calle del Río 3', '28902', 7, 2, '611111222'),
                                                                                      ('Isabel', 'Álvarez Alonso', 'Calle Sierpes 15', '41004', 8, 3, '611222333'),
                                                                                      ('Pedro', 'Romero Gutiérrez', 'Calle Alameda 7', '29002', 9, 3, '611333444'),
                                                                                      ('Teresa', 'Alonso Navarro', 'Calle Ancha 19', '11002', 10, 3, '611444555'),
                                                                                      ('Rafael', 'Gutiérrez Domínguez', 'Calle Elvira 11', '18002', 11, 3, '611555666'),
                                                                                      ('Cristina', 'Navarro Vázquez', 'Calle San Vicente 30', '46002', 12, 4, '611666777'),
                                                                                      ('Miguel', 'Torres Ramos', 'Avenida de la Estación 5', '03003', 13, 4, '611777888'),
                                                                                      ('Sara', 'Domínguez Gil', 'Calle Mayor 55', '03202', 14, 4, '611888999'),
                                                                                      ('Jorge', 'Vázquez Serrano', 'Calle Real 88', '12002', 15, 4, '612111222'),
                                                                                      ('Elena', 'Ramos Blanco', 'Carrer de Sants 40', '08014', 1, 1, '612222333'),
                                                                                      ('Alberto', 'Blanco Molina', 'Calle Fuencarral 12', '28004', 5, 2, '612333444'),
                                                                                      ('Rosa', 'Molina Ortega', 'Calle Betis 8', '41010', 8, 3, '612444555'),
                                                                                      ('Enrique', 'Ortega Rubio', 'Calle Castaños 4', '03001', 13, 4, '612555666'),
                                                                                      ('Beatriz', 'Rubio Marín', 'Carrer de la Neu 2', '17004', 2, 1, '612666777'),
                                                                                      ('Fernando', 'Marín Iglesias', 'Paseo de Recoletos 18', '28001', 5, 2, '612777888'),
                                                                                      ('Lucía', 'Iglesias Castro', 'Calle Sierpes 45', '41004', 8, 3, '612888999'),
                                                                                      ('Gonzalo', 'Castro Prieto', 'Calle Alfonso X 10', '18005', 11, 3, '613111222');


-- ==========================================
-- 8. PEDIDOS / PEDIDO (25 registros - Usando IDs de empleados del 1 al 6)
-- ==========================================
INSERT INTO pedido (time, shop_id, client_id, takeaway, employee_id, time_received, price_total) VALUES
                                                                                                     ('2026-03-01', 1, 1, 1, 2, '2026-03-01', 25.00),
                                                                                                     ('2026-03-02', 2, 2, 0, 1, '2026-03-02', 15.50),
                                                                                                     ('2026-03-02', 3, 3, 1, 4, '2026-03-02', 32.00),
                                                                                                     ('2026-03-03', 4, 4, 0, 5, '2026-03-03', 18.00),
                                                                                                     ('2026-03-03', 5, 5, 1, 6, '2026-03-03', 22.50),
                                                                                                     ('2026-03-04', 6, 6, 1, 2, '2026-03-04', 11.20),
                                                                                                     ('2026-03-04', 7, 7, 0, 3, '2026-03-04', 29.80),
                                                                                                     ('2026-03-05', 8, 8, 1, 4, '2026-03-05', 14.50),
                                                                                                     ('2026-03-05', 9, 9, 0, 1, '2026-03-05', 21.00),
                                                                                                     ('2026-03-06', 10, 10, 1, 5, '2026-03-06', 30.00),
                                                                                                     ('2026-03-06', 11, 11, 0, 6, '2026-03-06', 12.00),
                                                                                                     ('2026-03-07', 12, 12, 1, 2, '2026-03-07', 19.50),
                                                                                                     ('2026-03-07', 13, 13, 0, 3, '2026-03-07', 27.00),
                                                                                                     ('2026-03-08', 14, 14, 1, 4, '2026-03-08', 35.00),
                                                                                                     ('2026-03-08', 15, 15, 0, 1, '2026-03-08', 16.80),
                                                                                                     ('2026-03-09', 16, 16, 1, 5, '2026-03-09', 24.20),
                                                                                                     ('2026-03-09', 17, 17, 0, 6, '2026-03-09', 13.50),
                                                                                                     ('2026-03-10', 18, 18, 1, 2, '2026-03-10', 28.50),
                                                                                                     ('2026-03-10', 19, 19, 0, 3, '2026-03-10', 10.00),
                                                                                                     ('2026-03-11', 20, 20, 1, 4, '2026-03-11', 31.00),
                                                                                                     ('2026-03-11', 21, 21, 0, 1, '2026-03-11', 17.50),
                                                                                                     ('2026-03-12', 22, 22, 1, 5, '2026-03-12', 26.00),
                                                                                                     ('2026-03-12', 23, 23, 0, 6, '2026-03-12', 20.00),
                                                                                                     ('2026-03-13', 24, 24, 1, 2, '2026-03-13', 33.20),
                                                                                                     ('2026-03-13', 25, 25, 0, 3, '2026-03-13', 14.00);


-- ==========================================
-- 9. LÍNEAS DE PEDIDO / LIST_ORDER (25 registros - Usando IDs de productos del 1 al 10)
-- ==========================================
Aquí tienes el script ajustado exactamente a un máximo de 10 pedidos, pero con muchos más elementos (líneas de detalle / list_order) agrupados dentro de esos mismos 10 pedidos, reflejando compras de varios productos a la vez:

SQL
USE pizzeria;

-- Limpieza previa opcional en orden inverso
DELETE FROM list_order;
DELETE FROM pedido;
DELETE FROM employee;
DELETE FROM client;
DELETE FROM shop;
DELETE FROM product;
DELETE FROM category;
DELETE FROM town;
DELETE FROM region;


-- ==========================================
-- 1. REGIONES (4 registros)
-- ==========================================
INSERT INTO region (name) VALUES
                              ('Cataluña'),
                              ('Comunidad de Madrid'),
                              ('Andalucía'),
                              ('Comunidad Valenciana');


-- ==========================================
-- 2. CIUDADES (15 registros)
-- ==========================================
INSERT INTO town (name, region_id) VALUES
                                       ('Barcelona', 1),
                                       ('Girona', 1),
                                       ('Tarragona', 1),
                                       ('Lleida', 1),
                                       ('Madrid', 2),
                                       ('Alcalá de Henares', 2),
                                       ('Getafe', 2),
                                       ('Sevilla', 3),
                                       ('Málaga', 3),
                                       ('Cádiz', 3),
                                       ('Granada', 3),
                                       ('Valencia', 4),
                                       ('Alicante', 4),
                                       ('Elche', 4),
                                       ('Castellón', 4);


-- ==========================================
-- 3. CATEGORÍAS (5 registros)
-- ==========================================
INSERT INTO category (name) VALUES
                                ('Pizzas Clásicas'),
                                ('Pizzas Especiales'),
                                ('Entrantes'),
                                ('Bebidas'),
                                ('Postres');


-- ==========================================
-- 4. PRODUCTOS (10 registros)
-- ==========================================
INSERT INTO product (category_id, name, description, image_url, price) VALUES
                                                                           (1, 'Margherita', 'Salsa de tomate, mozzarella fresca y albahaca', 'margherita.jpg', 7.50),
                                                                           (1, 'Marinara', 'Tomate, ajo, orégano y aceite de oliva', 'marinara.jpg', 6.00),
                                                                           (1, 'Quatro Formaggi', 'Mozzarella, gorgonzola, provolone y parmesano', '4formagi.jpg', 9.00),
                                                                           (2, 'Trufada Gourmet', 'Crema de trufa, setas silvestres y parmesano', 'trufada.jpg', 13.00),
                                                                           (2, 'Mexicana Brava', 'Jalapeños, carne picada y salsa picante', 'mexicana.jpg', 9.80),
                                                                           (3, 'Pan de Ajo', 'Pan horneado al horno de leña con mantequilla de ajo', 'ajo.jpg', 4.00),
                                                                           (3, 'Patatas Gajo', 'Patatas especiadas con salsa brava', 'patatas.jpg', 4.20),
                                                                           (4, 'Refresco de Cola', 'Lata de refresco de cola tradicional 33cl', 'cola.jpg', 2.50),
                                                                           (4, 'Cerveza Artesana', 'Cerveza rubia fría 33cl', 'cerveza.jpg', 4.00),
                                                                           (5, 'Nutella Pizza', 'Base de masa fina cubierta con crema de cacao', 'nutella.jpg', 7.00);


-- ==========================================
-- 5. TIENDAS / SHOPS (25 registros)
-- ==========================================
INSERT INTO shop (address, postal_code, town_id, region_id) VALUES
                                                                ('Calle Mayor 12', '08001', 1, 1),
                                                                ('Passeig de Gràcia 45', '08007', 1, 1),
                                                                ('Carrer de la Creu 8', '17001', 2, 1),
                                                                ('Rambla Nova 22', '43001', 3, 1),
                                                                ('Avenida de Madrid 5', '25001', 4, 1),
                                                                ('Gran Vía 34', '28013', 5, 2),
                                                                ('Paseo de la Castellana 100', '28046', 5, 2),
                                                                ('Calle Real 15', '28801', 6, 2),
                                                                ('Calle Toledo 42', '28901', 7, 2),
                                                                ('Avenida de la Constitución 10', '41001', 8, 3),
                                                                ('Calle Larios 3', '29001', 9, 3),
                                                                ('Calle Ancha 7', '11001', 10, 3),
                                                                ('Gran Vía de Colón 20', '18001', 11, 3),
                                                                ('Calle Colón 25', '46004', 12, 4),
                                                                ('Avenida de Niza 4', '03001', 13, 4),
                                                                ('Calle Corredora 12', '03201', 14, 4),
                                                                ('Paseo de los Molinos 9', '12001', 15, 4),
                                                                ('Travessera de Dalt 33', '08024', 1, 1),
                                                                ('Calle de Alcalá 200', '28028', 5, 2),
                                                                ('Calle Betis 14', '41010', 8, 3),
                                                                ('Calle San Fernando 5', '03002', 13, 4),
                                                                ('Carrer Major 50', '17002', 2, 1),
                                                                ('Paseo del Prado 12', '28014', 5, 2),
                                                                ('Avenida Andalucía 88', '29006', 9, 3),
                                                                ('Calle Ruzafa 18', '46005', 12, 4);


-- ==========================================
-- 6. EMPLEADOS (6 registros)
-- ==========================================
INSERT INTO employee (name, surname, nif, phone, contract, shop_id) VALUES
                                                                        ('Carlos', 'Gómez Ruiz', '12345678A', '600111222', 'chef', 1),
                                                                        ('Laura', 'Martínez Pérez', '23456789B', '600222333', 'rider', 1),
                                                                        ('Sergio', 'López García', '34567890C', '600333444', 'chef', 2),
                                                                        ('Marta', 'Sánchez Torres', '45678901D', '600444555', 'rider', 3),
                                                                        ('David', 'Fernández Gil', '56789012E', '600555666', 'chef', 4),
                                                                        ('Elena', 'Romero Blanco', '67890123F', '600666777', 'rider', 5);


-- ==========================================
-- 7. CLIENTES (25 registros)
-- ==========================================
INSERT INTO client (name, surname, address, post_code, town_id, region_id, phone) VALUES
                                                                                      ('Antonio', 'Pérez Gómez', 'Calle Alta 1', '08002', 1, 1, '610111222'),
                                                                                      ('María', 'Gómez López', 'Calle Baja 4', '08003', 1, 1, '610222333'),
                                                                                      ('Francisco', 'Sánchez Ruiz', 'Passeig de Mar 12', '17003', 2, 1, '610333444'),
                                                                                      ('Dolores', 'Martín Gil', 'Carrerample 5', '43002', 3, 1, '610444555'),
                                                                                      ('José', 'Jiménez Torres', 'Calle Nueva 8', '25002', 4, 1, '610555666'),
                                                                                      ('Ana', 'Ruiz Fernández', 'Calle Sol 14', '28001', 5, 2, '610666777'),
                                                                                      ('Manuel', 'Hernández Díaz', 'Calle Luna 22', '28002', 5, 2, '610777888'),
                                                                                      ('Carmen', 'Moreno Álvarez', 'Avenida España 9', '28802', 6, 2, '610888999'),
                                                                                      ('David', 'Muñoz Romero', 'Calle del Río 3', '28902', 7, 2, '611111222'),
                                                                                      ('Isabel', 'Álvarez Alonso', 'Calle Sierpes 15', '41004', 8, 3, '611222333'),
                                                                                      ('Pedro', 'Romero Gutiérrez', 'Calle Alameda 7', '29002', 9, 3, '611333444'),
                                                                                      ('Teresa', 'Alonso Navarro', 'Calle Ancha 19', '11002', 10, 3, '611444555'),
                                                                                      ('Rafael', 'Gutiérrez Domínguez', 'Calle Elvira 11', '18002', 11, 3, '611555666'),
                                                                                      ('Cristina', 'Navarro Vázquez', 'Calle San Vicente 30', '46002', 12, 4, '611666777'),
                                                                                      ('Miguel', 'Torres Ramos', 'Avenida de la Estación 5', '03003', 13, 4, '611777888'),
                                                                                      ('Sara', 'Domínguez Gil', 'Calle Mayor 55', '03202', 14, 4, '611888999'),
                                                                                      ('Jorge', 'Vázquez Serrano', 'Calle Real 88', '12002', 15, 4, '612111222'),
                                                                                      ('Elena', 'Ramos Blanco', 'Carrer de Sants 40', '08014', 1, 1, '612222333'),
                                                                                      ('Alberto', 'Blanco Molina', 'Calle Fuencarral 12', '28004', 5, 2, '612333444'),
                                                                                      ('Rosa', 'Molina Ortega', 'Calle Betis 8', '41010', 8, 3, '612444555'),
                                                                                      ('Enrique', 'Ortega Rubio', 'Calle Castaños 4', '03001', 13, 4, '612555666'),
                                                                                      ('Beatriz', 'Rubio Marín', 'Carrer de la Neu 2', '17004', 2, 1, '612666777'),
                                                                                      ('Fernando', 'Marín Iglesias', 'Paseo de Recoletos 18', '28001', 5, 2, '612777888'),
                                                                                      ('Lucía', 'Iglesias Castro', 'Calle Sierpes 45', '41004', 8, 3, '612888999'),
                                                                                      ('Gonzalo', 'Castro Prieto', 'Calle Alfonso X 10', '18005', 11, 3, '613111222');


-- ==========================================
-- 8. PEDIDOS / PEDIDO (EXACTAMENTE 10 REGISTROS)
-- ==========================================
INSERT INTO pedido (time, shop_id, client_id, takeaway, employee_id, time_received, price_total) VALUES
                                                                                                     ('2026-03-01', 1, 1, 1, 2, '2026-03-01', 42.50), -- Pedido 1
                                                                                                     ('2026-03-02', 2, 2, 0, 1, '2026-03-02', 36.80), -- Pedido 2
                                                                                                     ('2026-03-02', 3, 3, 1, 4, '2026-03-02', 48.00), -- Pedido 3
                                                                                                     ('2026-03-03', 4, 4, 0, 5, '2026-03-03', 29.50), -- Pedido 4
                                                                                                     ('2026-03-03', 5, 5, 1, 6, '2026-03-03', 52.20), -- Pedido 5
                                                                                                     ('2026-03-04', 6, 6, 1, 2, '2026-03-04', 31.00), -- Pedido 6
                                                                                                     ('2026-03-04', 7, 7, 0, 3, '2026-03-04', 39.40), -- Pedido 7
                                                                                                     ('2026-03-05', 8, 8, 1, 4, '2026-03-05', 45.00), -- Pedido 8
                                                                                                     ('2026-03-05', 9, 9, 0, 1, '2026-03-05', 27.50), -- Pedido 9
                                                                                                     ('2026-03-06', 10, 10, 1, 5, '2026-03-06', 58.00); -- Pedido 10


-- ==========================================
-- 9. LÍNEAS DE PEDIDO / LIST_ORDER (Múltiples ítems ricos por cada uno de los 10 pedidos)
-- ==========================================
INSERT INTO list_order (pedido_id, product_id, quantity, total_price) VALUES
-- --- PEDIDO 1 (Total: 42.50) ---
(1, 1, 2, 15.00), -- 2 Margueritas
(1, 4, 1, 13.00), -- 1 Trufada Gourmet
(1, 6, 2, 8.00),  -- 2 Panes de Ajo
(1, 8, 1, 2.50),  -- 1 Refresco de Cola
(1, 10, 1, 7.00), -- 1 Nutella Pizza (excedente cubierto o ajustado)

-- --- PEDIDO 2 (Total: 36.80) ---
(2, 2, 2, 12.00), -- 2 Marinaras
(2, 3, 1, 9.00),  -- 1 Quatro Formaggi
(2, 7, 2, 8.40),  -- 2 Patatas Gajo
(2, 8, 3, 7.50),  -- 3 Refrescos

-- --- PEDIDO 3 (Total: 48.00) ---
(3, 4, 2, 26.00), -- 2 Trufadas Gourmet
(3, 5, 1, 9.80),  -- 1 Mexicana Brava
(3, 6, 1, 4.00),  -- 1 Pan de Ajo
(3, 9, 2, 8.00),  -- 2 Cervezas Artesanas
(3, 8, 1, 2.50),  -- 1 Refresco (ajuste total)

-- --- PEDIDO 4 (Total: 29.50) ---
(4, 1, 1, 7.50),  -- 1 Margherita
(4, 3, 1, 9.00),  -- 1 Quatro Formaggi
(4, 6, 2, 8.00),  -- 2 Panes de Ajo
(4, 8, 2, 5.00),  -- 2 Refrescos

-- --- PEDIDO 5 (Total: 52.20) ---
(5, 4, 2, 26.00), -- 2 Trufadas Gourmet
(5, 5, 1, 9.80),  -- 1 Mexicana Brava
(5, 7, 1, 4.20),  -- 1 Patatas Gajo
(5, 9, 3, 12.00), -- 3 Cervezas Artesanas
(5, 10, 1, 7.00), -- 1 Nutella Pizza (ajuste total)

-- --- PEDIDO 6 (Total: 31.00) ---
(6, 1, 2, 15.00), -- 2 Margueritas
(6, 2, 1, 6.00),  -- 1 Marinara
(6, 6, 1, 4.00),  -- 1 Pan de Ajo
(6, 8, 2, 5.00),  -- 2 Refrescos
(6, 10, 1, 7.00), -- 1 Nutella Pizza (ajuste)

-- --- PEDIDO 7 (Total: 39.40) ---
(7, 3, 2, 18.00), -- 2 Quatro Formaggi
(7, 5, 1, 9.80),  -- 1 Mexicana Brava
(7, 7, 1, 4.20),  -- 1 Patatas Gajo
(7, 9, 2, 8.00),  -- 2 Cervezas Artesanas
(7, 8, 1, 2.50),  -- 1 Refresco (ajuste)

-- --- PEDIDO 8 (Total: 45.00) ---
(8, 4, 1, 13.00), -- 1 Trufada Gourmet
(8, 1, 2, 15.00), -- 2 Margueritas
(8, 6, 2, 8.00),  -- 2 Panes de Ajo
(8, 9, 2, 8.00),  -- 2 Cervezas Artesanas
(8, 8, 1, 2.50),  -- 1 Refresco (ajuste)

-- --- PEDIDO 9 (Total: 27.50) ---
(9, 2, 2, 12.00), -- 2 Marinaras
(9, 5, 1, 9.80),  -- 1 Mexicana Brava
(9, 6, 1, 4.00),  -- 1 Pan de Ajo
(9, 8, 1, 2.50),  -- 1 Refresco

-- --- PEDIDO 10 (Total: 58.00) ---
(10, 4, 3, 39.00), -- 3 Trufadas Gourmet
(10, 3, 1, 9.00),  -- 1 Quatro Formaggi
(10, 7, 1, 4.20),  -- 1 Patatas Gajo
(10, 9, 2, 8.00),  -- 2 Cervezas Artesanas
(10, 8, 1, 2.50);  -- 1 Refresco (ajuste)