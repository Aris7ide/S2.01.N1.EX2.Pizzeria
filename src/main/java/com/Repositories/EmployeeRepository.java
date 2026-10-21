package com.Repositories;

import com.models.Employee;

import java.sql.*;

public class EmployeeRepository {

    public void saveEmployee(Connection connection, Employee employee) {
        String sql = "INSERT INTO employee (name,surname,nif,phone,contract,shop_id)" +
                "VALUES (?,?,?,?,?,?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, employee.getName());
            ps.setString(2, employee.getSurname());
            ps.setString(3, employee.getNif());
            ps.setString(4, employee.getPhone());
            if (employee.getContract().equals("chef") || employee.getContract().equals("rider")) {
                ps.setString(5, employee.getContract());
            } else {
                throw new IllegalArgumentException("Needs to be rider or chef");
            }
            if (employee.getShop() != null && employee.getShop().getId() > 0) {
                ps.setInt(6, employee.getShop().getId());
            } else {
                throw new IllegalArgumentException("Needs to be connected to a shop");
            }

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    employee.setId(rs.getInt(1));
                }
            }

            System.out.println("Employee " + employee.getName() + " has been saved with id: " + employee.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
