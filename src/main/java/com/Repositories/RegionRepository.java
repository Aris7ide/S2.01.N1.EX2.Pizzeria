package com.Repositories;

import com.models.Region;

import java.sql.*;

public class RegionRepository {
    public void save(Connection connection, Region region) {
        String sql = "INSERT INTO region (name) VALUES (?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, region.getRegionName());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                while (rs.next()) {
                    region.setId(rs.getInt(1));
                }
            }

            System.out.println("Region has been saved successfully with id: " + region.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
