package com.Repositories;

import com.models.Product;

import java.sql.*;

public class ProductRepository {

    public void saveProduct(Connection connection, Product product) {
        String sql = "INSERT INTO product (category_id, name, description, image_url, price) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            if (product.getCategory() != null && product.getCategory().getId() > 0) {
                ps.setInt(1, product.getCategory().getId());
            } else {
                throw new IllegalArgumentException("Category id is null");
            }

            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());

            if (product.getImageUrl() != null) {
                ps.setString(4, product.getImageUrl());
            } else {
                ps.setNull(4, java.sql.Types.VARCHAR);
            }

            ps.setDouble(5, product.getPrice());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    product.setId(rs.getInt(1));
                }
            }

            System.out.println(product.getName() + " has been saved with id " + product.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
