package com.Repositories;

import com.models.ListOrder;
import com.models.Order;

import java.sql.*;

public class ListOrderRepository {

    public void saveListOrder(Connection connection, ListOrder listOrder) {
        String sql = "INSERT INTO list_order (pedido_id, product_id, quantity, total_price) " +
                " VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps =  connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            if (listOrder.getOrder() != null && listOrder.getOrder().getId() > 0) {
                ps.setInt(1, listOrder.getOrder().getId());
            } else {
                throw new IllegalArgumentException("Order id is null");
            }

            if (listOrder.getProduct() != null && listOrder.getProduct().getId() > 0) {
                ps.setInt(2, listOrder.getProduct().getId());
            } else {
                throw new IllegalArgumentException("Product id is null");
            }

            ps.setInt(3, listOrder.getQuantity());
            ps.setDouble(4, listOrder.getTotalPrice());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    listOrder.setId(rs.getInt(1));
                }
            }

            System.out.println("Saved successfully");

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
