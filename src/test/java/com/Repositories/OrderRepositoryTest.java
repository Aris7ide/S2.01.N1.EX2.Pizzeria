package com.Repositories;

import com.connection.DatabaseConnection;
import com.models.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class OrderRepositoryTest {

    Connection connection;
    OrderRepository orderRepository;
    ListOrderRepository listOrderRepository;
    ShopRepository shopRepository;
    ClientRepository clientRepository;
    EmployeeRepository employeeRepository;
    TownRepository townRepository;
    RegionRepository regionRepository;
    CategoryRepository categoryRepository;
    ProductRepository productRepository;

    Region region;
    Town town;
    Client client;
    Shop shop;
    Employee employee;
    Category category;

    @BeforeEach
    void setUp() throws SQLException {
        connection = DatabaseConnection.getConnection();
        connection.setAutoCommit(false);

        orderRepository = new OrderRepository();
        listOrderRepository = new ListOrderRepository();
        shopRepository = new ShopRepository();
        clientRepository = new ClientRepository();
        employeeRepository = new EmployeeRepository();
        townRepository = new TownRepository();
        regionRepository = new RegionRepository();
        categoryRepository = new CategoryRepository();
        productRepository = new ProductRepository();

        region = new Region("Campania");
        regionRepository.save(connection, region);

        town = new Town("Naples",region);
        townRepository.saveTown(connection,town);

        client = new Client("Mario","Rossi","Via Raimondo", "80134", town, region, "3456574635");
        clientRepository.saveClient(connection, client);

        shop = new Shop("Via Tribunali","80135",town, region);
        shopRepository.saveShop(connection,shop);

        employee = new Employee("Fabio", "Merco", "Y7645362R", "768465342", "rider", shop);
        employeeRepository.saveEmployee(connection,employee);

        category = new Category("Pizza Gourmet");
        categoryRepository.saveCategory(connection,category);
    }

    @AfterEach
    void tearDown() throws SQLException {
        connection.rollback();
        connection.close();
    }

    @Test
    void shouldSaveOrder() {
        Order order = new Order(shop,client,true,employee,null);
        orderRepository.saveOrder(connection,order);
    }

    @Test
    void shouldSaveOrderWithProducts() {

        Product margherita = new Product(category, "Margherita","The usual margherita",null,7.50);
        productRepository.saveProduct(connection,margherita);
        Product marinara = new Product(category, "Marinara","The usual marinara",null,4.50);
        productRepository.saveProduct(connection,marinara);

        Order order = new Order(shop,client,true,employee,null);

        ListOrder listOrder1 = new ListOrder(order,margherita,3);
        ListOrder listOrder2 = new ListOrder(order,marinara,2);

        order.getProducts().add(listOrder1);
        order.getProducts().add(listOrder2);
        order.calculateTotalOrder();

        orderRepository.saveOrder(connection,order);
        listOrderRepository.saveListOrder(connection,listOrder1);
        listOrderRepository.saveListOrder(connection,listOrder2);

        //todo las tablas existen

        assertThat(order.getProducts().size()).isEqualTo(2);
        assertThat(listOrder1.getTotalPrice()).isEqualTo(22.5);
        assertThat(listOrder2.getTotalPrice()).isEqualTo(9);
        assertThat(order.getTotPrice()).isEqualTo(31.5);
    }

}