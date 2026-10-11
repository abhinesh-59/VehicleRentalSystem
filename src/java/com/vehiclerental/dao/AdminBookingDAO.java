
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminBookingDAO {

    // Model class for displaying booking details
    public static class BookingRecord {

        private final int rentalId;
        private final String customerName;
        private final String vehicleName;
        private final String vehicleNumber;
        private final String startDate;
        private final String endDate;
        private final double totalAmount;
        private final String rentalStatus;
        private final String paymentStatus;

        public BookingRecord(
                int rentalId,
                String customerName,
                String vehicleName,
                String vehicleNumber,
                String startDate,
                String endDate,
                double totalAmount,
                String rentalStatus,
                String paymentStatus) {

            this.rentalId = rentalId;
            this.customerName = customerName;
            this.vehicleName = vehicleName;
            this.vehicleNumber = vehicleNumber;
            this.startDate = startDate;
            this.endDate = endDate;
            this.totalAmount = totalAmount;
            this.rentalStatus = rentalStatus;
            this.paymentStatus = paymentStatus;
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

        public String getStartDate() {
            return startDate;
        }

        public String getEndDate() {
            return endDate;
        }

        public double getTotalAmount() {
            return totalAmount;
        }

        public String getRentalStatus() {
            return rentalStatus;
        }

        public String getPaymentStatus() {
            return paymentStatus;
        }
    }

    // Retrieve all bookings for the administrator
    public List<BookingRecord> getAllBookings()
            throws SQLException {

        List<BookingRecord> bookings = new ArrayList<>();

        String sql =
            "SELECT r.rental_id, " +
            "c.full_name AS customer_name, " +
            "v.brand, v.model, v.vehicle_number, " +
            "r.start_date, r.end_date, r.total_amount, " +
            "r.rental_status, " +
            "COALESCE((" +
            "    SELECT p.payment_status " +
            "    FROM payments p " +
            "    WHERE p.rental_id = r.rental_id " +
            "    ORDER BY p.payment_id DESC " +
            "    LIMIT 1" +
            "), 'NOT PAID') AS payment_status " +
            "FROM rentals r " +
            "JOIN customers c ON r.customer_id = c.customer_id " +
            "JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
            "ORDER BY r.rental_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                String vehicleName =
                    rs.getString("brand") + " "
                    + rs.getString("model");

                BookingRecord booking = new BookingRecord(
                    rs.getInt("rental_id"),
                    rs.getString("customer_name"),
                    vehicleName,
                    rs.getString("vehicle_number"),
                    rs.getString("start_date"),
                    rs.getString("end_date"),
                    rs.getDouble("total_amount"),
                    rs.getString("rental_status"),
                    rs.getString("payment_status")
                );

                bookings.add(booking);
            }
        }

        return bookings;
    }

    // Confirm handover for a paid booking
    public boolean activateRental(int rentalId)
            throws SQLException {

        if (rentalId <= 0) {
            return false;
        }

        try (Connection con = DBConnection.getConnection()) {

            boolean originalAutoCommit = con.getAutoCommit();
            con.setAutoCommit(false);

            try {
                int vehicleId;

                // Lock the rental and vehicle rows while processing handover
                String lockSql =
                    "SELECT r.vehicle_id, v.status AS vehicle_status " +
                    "FROM rentals r " +
                    "JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
                    "WHERE r.rental_id = ? " +
                    "AND r.rental_status = 'BOOKED' " +
                    "FOR UPDATE";

                try (PreparedStatement ps =
                         con.prepareStatement(lockSql)) {

                    ps.setInt(1, rentalId);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (!rs.next()) {
                            con.rollback();
                            return false;
                        }

                        vehicleId = rs.getInt("vehicle_id");

                        String vehicleStatus =
                            rs.getString("vehicle_status");

                        if (vehicleStatus == null
                                || !"AVAILABLE".equalsIgnoreCase(
                                    vehicleStatus)) {

                            con.rollback();
                            return false;
                        }
                    }
                }

                // A recorded PAID payment is required
                String paymentSql =
                    "SELECT 1 FROM payments " +
                    "WHERE rental_id = ? " +
                    "AND payment_status = 'PAID' " +
                    "LIMIT 1";

                try (PreparedStatement ps =
                         con.prepareStatement(paymentSql)) {

                    ps.setInt(1, rentalId);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (!rs.next()) {
                            con.rollback();
                            return false;
                        }
                    }
                }

                // Activate the rental
                String rentalSql =
                    "UPDATE rentals " +
                    "SET rental_status = 'ACTIVE' " +
                    "WHERE rental_id = ? " +
                    "AND rental_status = 'BOOKED'";

                try (PreparedStatement ps =
                         con.prepareStatement(rentalSql)) {

                    ps.setInt(1, rentalId);

                    if (ps.executeUpdate() != 1) {
                        throw new SQLException(
                            "Unable to activate the rental."
                        );
                    }
                }

                // Mark the vehicle as rented
                String vehicleSql =
                    "UPDATE vehicles " +
                    "SET status = 'RENTED' " +
                    "WHERE vehicle_id = ? " +
                    "AND status = 'AVAILABLE'";

                try (PreparedStatement ps =
                         con.prepareStatement(vehicleSql)) {

                    ps.setInt(1, vehicleId);

                    if (ps.executeUpdate() != 1) {
                        throw new SQLException(
                            "Unable to update vehicle status."
                        );
                    }
                }

                con.commit();
                return true;

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
