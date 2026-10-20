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
    descripcion VARCHAR(120) NOT NULL,
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

CREATE TABLE list_order (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(8,2) NOT NULL,

    CONSTRAINT fk_list_order_product
                        FOREIGN KEY (product_id)
                        REFERENCES product(id)
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
    list_order_id INT NOT NULL,

    CONSTRAINT fk_pedido_shop
                   FOREIGN KEY (shop_id)
                   REFERENCES shop(id),
    CONSTRAINT fk_pedido_client
                   FOREIGN KEY (client_id)
                   REFERENCES client(id),
    CONSTRAINT fk_pedido_employee
                   FOREIGN KEY (employee_id)
                   REFERENCES employee(id),
    CONSTRAINT fk_pedido_list_order
                   FOREIGN KEY (list_order_id)
                   REFERENCES list_order(id)
);
