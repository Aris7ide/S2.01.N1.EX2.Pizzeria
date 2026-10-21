package com.Repositories;

import com.models.Town;

import java.sql.*;

public class TownRepository {

    public void saveTown(Connection connection, Town town) {
        String sql = "INSERT INTO town (name, region_id) VALUES (?, ?)";

        try (PreparedStatement ps =  connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1,town.getTownName());

            if (town.getRegion() != null && town.getRegion().getId() > 0) {
                ps.setInt(2,town.getRegion().getId());
            } else {
                throw new IllegalArgumentException("Town need to be connected to a region");
            }

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    town.setId(rs.getInt(1));
                }
            }

            System.out.println(town.getTownName() + " has been saved with id " + town.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
