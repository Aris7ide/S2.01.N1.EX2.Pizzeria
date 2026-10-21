package com.Repositories;

import com.connection.DatabaseConnection;
import com.models.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class RepositoryTest {

    private Connection connection;

    private RegionRepository regionRepository;
    private TownRepository townRepository;
    private CategoryRepository categoryRepository;
    private ProductRepository productRepository;
    private ShopRepository shopRepository;
    private EmployeeRepository employeeRepository;
    private ClientRepository clientRepository;

    @BeforeEach
    void setUp() throws SQLException {
        connection = DatabaseConnection.getConnection();
        connection.setAutoCommit(false);

        regionRepository = new RegionRepository();
        townRepository = new TownRepository();
        categoryRepository = new CategoryRepository();
        productRepository = new ProductRepository();
        shopRepository = new ShopRepository();
        employeeRepository = new EmployeeRepository();
        clientRepository = new ClientRepository();
    }

    @AfterEach
    void tearDown() throws SQLException {
        connection.rollback();
        connection.close();
    }

    @Test
    void shouldSaveRegion() throws SQLException {
        Region region = new Region("Campania");
        regionRepository.save(connection, region);
    }

    @Test
    void shouldSaveTown() throws SQLException {
        Region region = new Region("Campania");
        regionRepository.save(connection, region);

        Town town = new Town("Naples", region);
        townRepository.saveTown(connection, town);
    }

    @Test
    void shouldSaveCategory() throws SQLException {
        Category category = new Category("Pizza Gourmet");
        categoryRepository.saveCategory(connection, category);
    }

    @Test
    void shouldSaveProduct() throws SQLException {
        Category category = new Category("Pizza Gourmet");
        categoryRepository.saveCategory(connection, category);

        Product product = new Product(category, "Margherita", "Typical margherita", null, 6.70);
        productRepository.saveProduct(connection, product);
    }

    @Test
    void shouldSaveShop() throws SQLException {
        Region region = new Region("Campania");
        regionRepository.save(connection, region);

        Town town = new Town("Naples", region);
        townRepository.saveTown(connection, town);

        Shop shop = new Shop("Via Tribunali","80134", town, region);
        shopRepository.saveShop(connection, shop);
    }

    @Test
    void shouldSaveEmployeeAndContractHasToBeRight() throws SQLException {
        Region region = new Region("Campania");
        regionRepository.save(connection, region);

        Town town = new Town("Naples", region);
        townRepository.saveTown(connection, town);

        Shop shop = new Shop("Via Tribunali","80134", town, region);
        shopRepository.saveShop(connection, shop);

        Employee employee = new Employee("Mario", "Rossi","T6573482F","6817664532","rider",shop);
        employeeRepository.saveEmployee(connection, employee);

        Employee employeeWrong = new Employee("Mario", "Rossi","y6735625","6754837623","raider",shop);
        assertThatThrownBy(() -> employeeRepository.saveEmployee(connection, employeeWrong)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    void shouldSaveClient() throws SQLException {
        Region region = new Region("Campania");
        regionRepository.save(connection, region);

        Town town = new Town("Naples", region);
        townRepository.saveTown(connection, town);

        Client client = new Client("Rosa", "Bordi", null,null,town,region,"3452345676");
        clientRepository.saveClient(connection, client);
    }



}