
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class AdminReturnDAO {

    public static class ReturnableRental {
        private final int rentalId;
        private final String customerName;
        private final String vehicleName;
        private final String vehicleNumber;
        private final String endDate;

        public ReturnableRental(
                int rentalId,
                String customerName,
                String vehicleName,
                String vehicleNumber,
                String endDate) {
            this.rentalId = rentalId;
            this.customerName = customerName;
            this.vehicleName = vehicleName;
            this.vehicleNumber = vehicleNumber;
            this.endDate = endDate;
        }

        public int getRentalId() {
            return rentalId;
        }

        public String getCustomerName() {
            return customerName;
        }

        public String getVehicleName() {
            return vehicleName;
        }

        public String getVehicleNumber() {
            return vehicleNumber;
        }

        public String getEndDate() {
            return endDate;
        }
    }

    public List<ReturnableRental> getActiveRentals()
            throws SQLException {

        List<ReturnableRental> rentals = new ArrayList<>();

        String sql =
            "SELECT r.rental_id, c.full_name, " +
            "v.brand, v.model, v.vehicle_number, r.end_date " +
            "FROM rentals r " +
            "JOIN customers c ON r.customer_id = c.customer_id " +
            "JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
            "WHERE r.rental_status = 'ACTIVE' " +
            "AND NOT EXISTS (" +
            "    SELECT 1 FROM returns ret " +
            "    WHERE ret.rental_id = r.rental_id" +
            ") " +
            "ORDER BY r.end_date";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                rentals.add(new ReturnableRental(
                    rs.getInt("rental_id"),
                    rs.getString("full_name"),
                    rs.getString("brand") + " " + rs.getString("model"),
                    rs.getString("vehicle_number"),
                    rs.getString("end_date")
                ));
            }
        }

        return rentals;
    }

    public boolean confirmReturn(
            int rentalId,
            int odometerReading,
            double damageCharges,
            double additionalCharges,
            String remarks) throws SQLException {

        if (rentalId <= 0 || odometerReading < 0
                || damageCharges < 0 || additionalCharges < 0) {
            throw new IllegalArgumentException(
                    "Invalid rental or return details.");
        }

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try {
                String rentalSql =
                    "SELECT r.vehicle_id, r.end_date, r.total_amount, " +
                    "v.status AS vehicle_status " +
                    "FROM rentals r " +
                    "JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
                    "WHERE r.rental_id = ? " +
                    "AND r.rental_status = 'ACTIVE' " +
                    "FOR UPDATE";

                int vehicleId;
                LocalDate endDate;
                double rentalAmount;
                String vehicleStatus;

                try (PreparedStatement ps =
                         con.prepareStatement(rentalSql)) {

                    ps.setInt(1, rentalId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            con.rollback();
                            return false;
                        }

                        vehicleId = rs.getInt("vehicle_id");
                        endDate = rs.getDate("end_date").toLocalDate();
                        rentalAmount = rs.getDouble("total_amount");
                        vehicleStatus = rs.getString("vehicle_status");
                    }
                }

                String checkSql =
                    "SELECT return_id FROM returns WHERE rental_id = ?";

                try (PreparedStatement ps =
                         con.prepareStatement(checkSql)) {

                    ps.setInt(1, rentalId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            con.rollback();
                            return false;
                        }
                    }
                }

                LocalDate today = LocalDate.now();

                long lateDays = Math.max(
                        0, ChronoUnit.DAYS.between(endDate, today));

                double lateFee = lateDays * 500.0;

                double totalReturnAmount =
                        lateFee + damageCharges + additionalCharges;

                String insertSql =
                    "INSERT INTO returns " +
                    "(rental_id, return_date, odometer_reading, " +
                    "late_days, late_fee, damage_charges, " +
                    "additional_charges, total_return_amount, remarks) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement ps =
                         con.prepareStatement(insertSql)) {

                    ps.setInt(1, rentalId);
                    ps.setDate(2, Date.valueOf(today));
                    ps.setInt(3, odometerReading);
                    ps.setLong(4, lateDays);
                    ps.setDouble(5, lateFee);
                    ps.setDouble(6, damageCharges);
                    ps.setDouble(7, additionalCharges);
                    ps.setDouble(8, totalReturnAmount);
                    ps.setString(9, remarks);

                    ps.executeUpdate();
                }

                String updateRentalSql =
                    "UPDATE rentals SET rental_status = 'COMPLETED' " +
                    "WHERE rental_id = ? AND rental_status = 'ACTIVE'";

                try (PreparedStatement ps =
                         con.prepareStatement(updateRentalSql)) {

                    ps.setInt(1, rentalId);

                    if (ps.executeUpdate() != 1) {
                        throw new SQLException(
                                "Unable to complete rental.");
                    }
                }

                String updateVehicleSql =
                    "UPDATE vehicles SET status = 'AVAILABLE' " +
                    "WHERE vehicle_id = ? AND status = 'RENTED'";

                try (PreparedStatement ps =
                         con.prepareStatement(updateVehicleSql)) {

                    ps.setInt(1, vehicleId);
                    ps.executeUpdate();
                }

                con.commit();
                return true;

            } catch (SQLException | RuntimeException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }
}
