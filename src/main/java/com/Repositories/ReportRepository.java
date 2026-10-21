package com.Repositories;

import java.sql.*;

public class ReportRepository {

    public int productsSoldInTown(Connection connection, String townName, String category) {
        String sql = "SELECT SUM(lo.quantity) AS total_category_town " +
                "FROM town t " +
                "JOIN shop s ON s.town_id = t.id " +
                "JOIN pedido p ON p.shop_id = s.id " +
                "JOIN list_order lo ON lo.pedido_id = p.id " +
                "JOIN product pr ON lo.product_id = pr.id " +
                "JOIN category c ON pr.category_id = c.id " +
                "WHERE t.name = ? AND c.name = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, townName);
            ps.setString(2, category);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int valorLeido = rs.getInt("total_category_town");
                    System.out.println("🔍 Valor exacto devuelto por la BBDD: " + valorLeido);
                    return valorLeido;
                }
            }

        } catch (SQLException e) {
            System.err.println("ERROR" + e.getMessage());
        }

        return 0;

    }

    public int totOrdersByEmployee(Connection connection, String nameEmployee) {
        String sql = "SELECT COUNT(e.id) AS total_order_employee " +
                "FROM employee e " +
                "JOIN pedido p ON p.employee_id = e.id " +
                "WHERE e.name = ? ";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, nameEmployee);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_order_employee");
                }
            }
        } catch (SQLException e) {
            System.err.println("ERROR" + e.getMessage());
        }

        return 0;
    }
}
