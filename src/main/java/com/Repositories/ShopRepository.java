package com.Repositories;

import com.models.Shop;

import java.sql.*;

public class ShopRepository {

    public void saveShop(Connection connection, Shop shop) {
        String sql = "INSERT INTO shop (address, postal_code, town_id, region_id) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1,shop.getAddress());
            ps.setString(2,shop.getPostalCodeShop());

            if (shop.getTown() != null && shop.getTown().getId() > 0) {
                ps.setInt(3, shop.getTown().getId());
            } else {
                throw new IllegalArgumentException("Town id is null");
            }

            if (shop.getRegion() != null && shop.getRegion().getId() > 0) {
                ps.setInt(4, shop.getRegion().getId());
            } else {
                throw new IllegalArgumentException("Region id is null");
            }

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    shop.setId(rs.getInt(1));
                }
            }

            System.out.println("Shop has been saved with id: " + shop.getId());

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
