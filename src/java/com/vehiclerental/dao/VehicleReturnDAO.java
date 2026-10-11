
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class VehicleReturnDAO {

    public static class ReturnableRental {
        private int rentalId;
        private int vehicleId;
        private String brand;
        private String model;
        private Date startDate;
        private Date endDate;
        private String rentalStatus;

        public int getRentalId() {
            return rentalId;
        }

        public void setRentalId(int rentalId) {
            this.rentalId = rentalId;
        }

        public int getVehicleId() {
            return vehicleId;
        }

        public void setVehicleId(int vehicleId) {
            this.vehicleId = vehicleId;
        }

        public String getBrand() {
            return brand;
        }

        public void setBrand(String brand) {
            this.brand = brand;
        }

        public String getModel() {
            return model;
        }

        public void setModel(String model) {
            this.model = model;
        }

        public Date getStartDate() {
            return startDate;
        }

        public void setStartDate(Date startDate) {
            this.startDate = startDate;
        }

        public Date getEndDate() {
            return endDate;
        }

        public void setEndDate(Date endDate) {
            this.endDate = endDate;
        }

        public String getRentalStatus() {
            return rentalStatus;
        }

        public void setRentalStatus(String rentalStatus) {
            this.rentalStatus = rentalStatus;
        }
    }

    // Retrieve bookings that have not yet been returned
    public List<ReturnableRental> getReturnableRentals(
            int customerId) throws SQLException {

        List<ReturnableRental> rentals = new ArrayList<>();

        String sql =
            "SELECT r.rental_id, r.vehicle_id, v.brand, v.model, " +
            "r.start_date, r.end_date, r.rental_status " +
            "FROM rentals r " +
            "INNER JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
            "WHERE r.customer_id = ? " +
            "AND r.rental_status IN ('BOOKED', 'ACTIVE') " +
            "AND NOT EXISTS (" +
            "SELECT 1 FROM returns rt " +
            "WHERE rt.rental_id = r.rental_id) " +
            "ORDER BY r.end_date ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReturnableRental rental = new ReturnableRental();

                    rental.setRentalId(rs.getInt("rental_id"));
                    rental.setVehicleId(rs.getInt("vehicle_id"));
                    rental.setBrand(rs.getString("brand"));
                    rental.setModel(rs.getString("model"));
                    rental.setStartDate(rs.getDate("start_date"));
                    rental.setEndDate(rs.getDate("end_date"));
                    rental.setRentalStatus(
                        rs.getString("rental_status")
                    );

                    rentals.add(rental);
                }
            }
        }

        return rentals;
    }

    // Record a return and complete the rental
    public void returnVehicle(
            int customerId,
            int rentalId,
            int odometerReading,
            BigDecimal damageCharges,
            BigDecimal additionalCharges,
            String remarks) throws SQLException {

        if (odometerReading < 0) {
            throw new IllegalArgumentException(
                "Odometer reading cannot be negative."
            );
        }

        if (damageCharges == null || damageCharges.signum() < 0
                || additionalCharges == null
                || additionalCharges.signum() < 0) {
            throw new IllegalArgumentException(
                "Charges cannot be negative."
            );
        }

        if (damageCharges.scale() > 2
                || additionalCharges.scale() > 2) {
            throw new IllegalArgumentException(
                "Charges can have at most two decimal places."
            );
        }

        if (remarks != null && remarks.length() > 255) {
            throw new IllegalArgumentException(
                "Remarks cannot exceed 255 characters."
            );
        }

        try (Connection con = DBConnection.getConnection()) {
            boolean originalAutoCommit = con.getAutoCommit();

            try {
                con.setAutoCommit(false);

                String rentalSql =
                    "SELECT r.vehicle_id, r.end_date, r.rental_status " +
                    "FROM rentals r " +
                    "WHERE r.rental_id = ? AND r.customer_id = ? " +
                    "FOR UPDATE";

                int vehicleId;
                LocalDate plannedEndDate;

                try (PreparedStatement ps =
                        con.prepareStatement(rentalSql)) {

                    ps.setInt(1, rentalId);
                    ps.setInt(2, customerId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new IllegalArgumentException(
                                "Rental not found for this customer."
                            );
                        }

                        String status = rs.getString("rental_status");

                        if (!"ACTIVE".equalsIgnoreCase(status)) {
                            throw new IllegalStateException(
                                "Only active rentals can be returned. " +
                                "The rental must be marked ACTIVE first."
                            );
                        }

                        vehicleId = rs.getInt("vehicle_id");
                        plannedEndDate =
                            rs.getDate("end_date").toLocalDate();
                    }
                }

                // Prevent a duplicate return record
                String duplicateSql =
                    "SELECT return_id FROM returns " +
                    "WHERE rental_id = ?";

                try (PreparedStatement ps =
                        con.prepareStatement(duplicateSql)) {

                    ps.setInt(1, rentalId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            throw new IllegalStateException(
                                "This rental already has a return record."
                            );
                        }
                    }
                }

                LocalDate actualReturnDate = LocalDate.now();

                long lateDays = Math.max(
                    0,
                    ChronoUnit.DAYS.between(
                        plannedEndDate, actualReturnDate
                    )
                );

                // Demo policy: ₹500 per late day
                BigDecimal lateFee = BigDecimal.valueOf(
                    lateDays * 500L
                );

                BigDecimal totalReturnAmount = lateFee
                    .add(damageCharges)
                    .add(additionalCharges);

                String insertSql =
                    "INSERT INTO returns " +
                    "(rental_id, return_date, odometer_reading, " +
                    "late_days, late_fee, damage_charges, " +
                    "additional_charges, total_return_amount, remarks) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement ps =
                        con.prepareStatement(insertSql)) {

                    ps.setInt(1, rentalId);
                    ps.setDate(2, Date.valueOf(actualReturnDate));
                    ps.setInt(3, odometerReading);
                    ps.setLong(4, lateDays);
                    ps.setBigDecimal(5, lateFee);
                    ps.setBigDecimal(6, damageCharges);
                    ps.setBigDecimal(7, additionalCharges);
                    ps.setBigDecimal(8, totalReturnAmount);
                    ps.setString(9, remarks);

                    ps.executeUpdate();
                }

                String updateRentalSql =
                    "UPDATE rentals SET rental_status = 'COMPLETED' " +
                    "WHERE rental_id = ? AND customer_id = ?";

                try (PreparedStatement ps =
                        con.prepareStatement(updateRentalSql)) {

                    ps.setInt(1, rentalId);
                    ps.setInt(2, customerId);

                    if (ps.executeUpdate() != 1) {
                        throw new SQLException(
                            "Unable to complete the rental."
                        );
                    }
                }

                String updateVehicleSql =
                    "UPDATE vehicles SET status = 'AVAILABLE' " +
                    "WHERE vehicle_id = ? " +
                    "AND status = 'RENTED'";

                try (PreparedStatement ps =
                        con.prepareStatement(updateVehicleSql)) {

                    ps.setInt(1, vehicleId);
                    ps.executeUpdate();
                }

                con.commit();

            } catch (SQLException | RuntimeException e) {
                try {
                    con.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }

                throw e;

            } finally {
                con.setAutoCommit(originalAutoCommit);
            }
        }
    }
}
