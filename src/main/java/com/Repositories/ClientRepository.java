package com.Repositories;

import com.models.Client;

import java.sql.*;

public class ClientRepository {

    public void saveClient(Connection connection, Client client) {
        String sql = "INSERT INTO client (name, surname, address, post_code, town_id, region_id,phone)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps =  connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, client.getName());
            ps.setString(2, client.getSurname());
            if (client.getAddress() != null) {
                ps.setString(3, client.getAddress());
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
            }
            if (client.getPostalCode() != null) {
                ps.setString(4, client.getPostalCode());
            } else {
                ps.setNull(4, java.sql.Types.VARCHAR);
            }
            if (client.getTown() != null && client.getTown().getId() > 0) {
                ps.setInt(5, client.getTown().getId());
            } else {
                throw new IllegalArgumentException("Needs to be connected to a town");
            }
            if (client.getRegion() != null && client.getRegion().getId() > 0) {
                ps.setInt(6, client.getRegion().getId());
            } else {
                throw new IllegalArgumentException("Needs to be connected to a region");
            }
            if (client.getPhone() != null) {
                ps.setString(7, client.getPhone());
            } else {
                ps.setNull(7, java.sql.Types.VARCHAR);
            }

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    client.setId(rs.getInt(1));
                }
            }

            System.out.println(client.getName() + " " + client.getSurname() + " has been saved with id: " + client.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
