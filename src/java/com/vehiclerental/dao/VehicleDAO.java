
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    public List<Vehicle> getAllVehicles() throws SQLException {
        return searchVehicles(null, null);
    }

    public List<Vehicle> searchVehicles(String keyword, String category)
            throws SQLException {

        List<Vehicle> vehicles = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT v.vehicle_id, v.category_id, c.category_name, " +
            "v.vehicle_number, v.brand, v.model, v.year, v.color, " +
            "v.seating_capacity, v.fuel_type, v.transmission, " +
            "v.status, c.daily_rate " +
            "FROM vehicles v " +
            "INNER JOIN vehicle_categories c " +
            "ON v.category_id = c.category_id " +
            "WHERE 1=1 "
        );

        boolean hasKeyword =
                keyword != null && !keyword.trim().isEmpty();

        boolean hasCategory =
                category != null && !category.trim().isEmpty();

        if (hasKeyword) {
            sql.append(
                "AND (v.brand LIKE ? OR v.model LIKE ?) "
            );
        }

        if (hasCategory) {
            sql.append("AND c.category_name = ? ");
        }

        sql.append("ORDER BY v.vehicle_id");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql.toString())) {

            int index = 1;

            if (hasKeyword) {
                String pattern = "%" + keyword.trim() + "%";
                ps.setString(index++, pattern);
                ps.setString(index++, pattern);
            }

            if (hasCategory) {
                ps.setString(index++, category.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Vehicle vehicle = new Vehicle();

                    vehicle.setVehicleId(
                        rs.getInt("vehicle_id")
                    );

                    vehicle.setCategoryId(
                        rs.getInt("category_id")
                    );

                    vehicle.setCategoryName(
                        rs.getString("category_name")
                    );

                    vehicle.setVehicleNumber(
                        rs.getString("vehicle_number")
                    );

                    vehicle.setBrand(rs.getString("brand"));
                    vehicle.setModel(rs.getString("model"));
                    vehicle.setYear(rs.getInt("year"));
                    vehicle.setColor(rs.getString("color"));

                    vehicle.setSeatingCapacity(
                        rs.getInt("seating_capacity")
                    );

                    vehicle.setFuelType(
                        rs.getString("fuel_type")
                    );

                    vehicle.setTransmission(
                        rs.getString("transmission")
                    );

                    vehicle.setStatus(rs.getString("status"));

                    vehicle.setDailyRate(
                        rs.getDouble("daily_rate")
                    );

                    vehicles.add(vehicle);
                }
            }
        }

        return vehicles;
    }
}
