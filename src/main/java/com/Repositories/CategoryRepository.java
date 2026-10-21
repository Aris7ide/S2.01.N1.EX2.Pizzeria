package com.Repositories;

import com.models.Category;

import java.sql.*;

public class CategoryRepository {

    public void saveCategory(Connection connection, Category category) {
        String sql = "INSERT INTO category (name) VALUES (?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, category.getName());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    category.setId(rs.getInt(1));
                }
            }

            System.out.println(category.getName() + " has been saved with id " +  category.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
