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

USE pizzeria;

DELETE FROM list_order;
DELETE FROM pedido;
DELETE FROM employee;
DELETE FROM client;
DELETE FROM shop;
DELETE FROM product;
DELETE FROM category;
DELETE FROM town;
DELETE FROM region;

INSERT INTO region (name) VALUES
                              ('Cataluña'),
                              ('Comunidad de Madrid'),
                              ('Andalucía'),
                              ('Comunidad Valenciana');

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

INSERT INTO category (name) VALUES
                                ('Pizzas Clásicas'),
                                ('Pizzas Especiales'),
                                ('Entrantes'),
                                ('Bebidas'),
                                ('Postres');

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

INSERT INTO shop (address, postal_code, town_id, region_id) VALUES
                                                                ('Calle Mayor 12', '08001', 1, 1),
                                                                ('Gran Vía 34', '28013', 5, 2),
                                                                ('Avenida de la Constitución 10', '41001', 8, 3),
                                                                ('Calle Colón 25', '46004', 12, 4);

INSERT INTO employee (name, surname, nif, phone, contract, shop_id) VALUES
                                                                        ('Carlos', 'Gómez Ruiz', '12345678A', '600111222', 'chef', 1),
                                                                        ('Laura', 'Martínez Pérez', '23456789B', '600222333', 'rider', 1),
                                                                        ('Sergio', 'López García', '34567890C', '600333444', 'chef', 2),
                                                                        ('Marta', 'Sánchez Torres', '45678901D', '600444555', 'rider', 3),
                                                                        ('David', 'Fernández Gil', '56789012E', '600555666', 'chef', 4),
                                                                        ('Elena', 'Romero Blanco', '67890123F', '600666777', 'rider', 4);

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
                                                                                      ('Isabel', 'Álvarez Alonso', 'Calle Sierpes 15', '41004', 8, 3, '611222333');

INSERT INTO pedido (time, shop_id, client_id, takeaway, employee_id, time_received, price_total) VALUES
                                                                                                     ('2026-03-01', 1, 1, 1, 2, '2026-03-01', 42.50),
                                                                                                     ('2026-03-02', 2, 2, 0, 1, '2026-03-02', 36.80),
                                                                                                     ('2026-03-02', 3, 3, 1, 4, '2026-03-02', 48.00),
                                                                                                     ('2026-03-03', 4, 4, 0, 5, '2026-03-03', 29.50),
                                                                                                     ('2026-03-03', 1, 5, 1, 6, '2026-03-03', 52.20),
                                                                                                     ('2026-03-04', 2, 6, 1, 2, '2026-03-04', 31.00),
                                                                                                     ('2026-03-04', 3, 7, 0, 3, '2026-03-04', 39.40),
                                                                                                     ('2026-03-05', 4, 8, 1, 4, '2026-03-05', 45.00),
                                                                                                     ('2026-03-05', 1, 9, 0, 1, '2026-03-05', 27.50),
                                                                                                     ('2026-03-06', 2, 10, 1, 5, '2026-03-06', 58.00);

INSERT INTO list_order (pedido_id, product_id, quantity, total_price) VALUES
                                                                          (1, 1, 2, 15.00),
                                                                          (1, 4, 1, 13.00),
                                                                          (1, 6, 2, 8.00),
                                                                          (1, 8, 1, 2.50),
                                                                          (1, 10, 1, 7.00),
                                                                          (2, 2, 2, 12.00),
                                                                          (2, 3, 1, 9.00),
                                                                          (2, 7, 2, 8.40),
                                                                          (2, 8, 3, 7.50),
                                                                          (3, 4, 2, 26.00),
                                                                          (3, 5, 1, 9.80),
                                                                          (3, 6, 1, 4.00),
                                                                          (3, 9, 2, 8.00),
                                                                          (3, 8, 1, 2.50),
                                                                          (4, 1, 1, 7.50),
                                                                          (4, 3, 1, 9.00),
                                                                          (4, 6, 2, 8.00),
                                                                          (4, 8, 2, 5.00),
                                                                          (5, 4, 2, 26.00),
                                                                          (5, 5, 1, 9.80),
                                                                          (5, 7, 1, 4.20),
                                                                          (5, 9, 3, 12.00),
                                                                          (5, 10, 1, 7.00),
                                                                          (6, 1, 2, 15.00),
                                                                          (6, 2, 1, 6.00),
                                                                          (6, 6, 1, 4.00),
                                                                          (6, 8, 2, 5.00),
                                                                          (6, 10, 1, 7.00),
                                                                          (7, 3, 2, 18.00),
                                                                          (7, 5, 1, 9.80),
                                                                          (7, 7, 1, 4.20),
                                                                          (7, 9, 2, 8.00),
                                                                          (7, 8, 1, 2.50),
                                                                          (8, 4, 1, 13.00),
                                                                          (8, 1, 2, 15.00),
                                                                          (8, 6, 2, 8.00),
                                                                          (8, 9, 2, 8.00),
                                                                          (8, 8, 1, 2.50),
                                                                          (9, 2, 2, 12.00),
                                                                          (9, 5, 1, 9.80),
                                                                          (9, 6, 1, 4.00),
                                                                          (9, 8, 1, 2.50),
                                                                          (10, 4, 3, 39.00),
                                                                          (10, 3, 1, 9.00),
                                                                          (10, 7, 1, 4.20),
                                                                          (10, 9, 2, 8.00),
                                                                          (10, 8, 1, 2.50);
