package com.Repositories;

import com.connection.DatabaseConnection;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class ReportRepositoryTest {

    private ReportRepository reportRepository = new ReportRepository();
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        connection = DatabaseConnection.getConnection();
    }

    @Test
    void shouldGetTotalCategoryByTown() {
        assertThat(reportRepository.productsSoldInTown(connection, "Madrid", "Bebidas")).isEqualTo(8);
    }

    @Test
    void shouldGiveOrdersByEmployee() {
        assertThat(reportRepository.totOrdersByEmployee(connection, "Laura")).isEqualTo(2);
    }



}