package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminVehicleDAO {

    public static class VehicleRecord {

        private int vehicleId;
        private String vehicleName;
        private String registrationNumber;
        private String categoryName;
        private double rentalPrice;
        private String status;

        public VehicleRecord(int vehicleId, String vehicleName,
                String registrationNumber, String categoryName,
                double rentalPrice, String status) {
            this.vehicleId = vehicleId;
            this.vehicleName = vehicleName;
            this.registrationNumber = registrationNumber;
            this.categoryName = categoryName;
            this.rentalPrice = rentalPrice;
            this.status = status;
        }

        public int getVehicleId() {
            return vehicleId;
        }

        public String getVehicleName() {
            return vehicleName;
        }

        public String getRegistrationNumber() {
            return registrationNumber;
        }

        public String getCategoryName() {
            return categoryName;
        }

        public double getRentalPrice() {
            return rentalPrice;
        }

        public String getStatus() {
            return status;
        }
    }

    public List<VehicleRecord> getAllVehicles() throws SQLException {

        List<VehicleRecord> vehicles = new ArrayList<>();

        String sql =
            "SELECT v.vehicle_id, " +
            "CONCAT(v.brand, ' ', v.model) AS vehicle_name, " +
            "v.vehicle_number AS registration_number, " +
            "c.category_name, c.daily_rate AS rental_price, v.status " +
            "FROM vehicles v " +
            "LEFT JOIN vehicle_categories c " +
            "ON v.category_id = c.category_id " +
            "ORDER BY v.vehicle_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                vehicles.add(new VehicleRecord(
                    rs.getInt("vehicle_id"),
                    rs.getString("vehicle_name"),
                    rs.getString("registration_number"),
                    rs.getString("category_name"),
                    rs.getDouble("rental_price"),
                    rs.getString("status")
                ));
            }
        }

        return vehicles;
    }

    public boolean addVehicle(int categoryId, String vehicleNumber,
            String brand, String model, Integer year, String color,
            Integer seatingCapacity, String fuelType,
            String transmission) throws SQLException {

        String sql =
            "INSERT INTO vehicles " +
            "(category_id, vehicle_number, brand, model, year, color, " +
            "seating_capacity, fuel_type, transmission, status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'AVAILABLE')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ps.setString(2, vehicleNumber);
            ps.setString(3, brand);
            ps.setString(4, model);

            if (year == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, year);
            }

            ps.setString(6, color);

            if (seatingCapacity == null) {
                ps.setNull(7, java.sql.Types.INTEGER);
            } else {
                ps.setInt(7, seatingCapacity);
            }

            ps.setString(8, fuelType);
            ps.setString(9, transmission);

            return ps.executeUpdate() == 1;
        }
    }
}