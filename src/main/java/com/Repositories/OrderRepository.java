package com.Repositories;

import com.models.Order;

import java.sql.*;

public class OrderRepository {

    public void saveOrder(Connection connection, Order order) {
        String sql = "INSERT INTO pedido (time,shop_id,client_id,takeaway,employee_id,time_received,price_total)" +
                "VALUES (?,?,?,?,?,?,?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setObject(1,order.getOrderDate());
            if (order.getShop()  != null && order.getShop().getId() > 0) {
                ps.setInt(2, order.getShop().getId());
            } else {
                throw new IllegalArgumentException("Shop id is null");
            }
            if (order.getClient()  != null && order.getClient().getId() > 0) {
                ps.setInt(3, order.getClient().getId());
            } else {
                throw new IllegalArgumentException("Client id is null");
            }
            ps.setBoolean(4, order.isTakeaway());
            if (order.getEmployee()  != null && order.getEmployee().getId() > 0) {
                ps.setInt(5, order.getEmployee().getId());
            } else {
                throw new IllegalArgumentException("Employee id is null");
            }
            if (order.getOrderReceived() != null) {
                ps.setObject(6, order.getOrderReceived());
            } else {
                ps.setNull(6, Types.NULL);
            }
            ps.setDouble(7,order.getTotPrice());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    order.setId(rs.getInt(1));
                }
            }

            System.out.println("Order n. " + order.getId() + " has been saved");

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
