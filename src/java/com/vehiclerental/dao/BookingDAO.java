
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // 1. Calculate the total rental amount
    public BigDecimal calculateRentalAmount(
            int vehicleId,
            LocalDate startDate,
            LocalDate endDate) throws SQLException {

        validateDates(startDate, endDate);

        String sql =
            "SELECT c.daily_rate " +
            "FROM vehicles v " +
            "INNER JOIN vehicle_categories c " +
            "ON v.category_id = c.category_id " +
            "WHERE v.vehicle_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, vehicleId);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    throw new SQLException("Vehicle not found.");
                }

                BigDecimal dailyRate = rs.getBigDecimal("daily_rate");

                long days = ChronoUnit.DAYS.between(
                    startDate, endDate
                );

                return dailyRate.multiply(BigDecimal.valueOf(days));
            }
        }
    }

    // 2. Check whether a vehicle is available for selected dates
    public boolean isVehicleAvailable(
            int vehicleId,
            LocalDate startDate,
            LocalDate endDate) throws SQLException {

        validateDates(startDate, endDate);

        String sql =
            "SELECT COUNT(*) " +
            "FROM rentals " +
            "WHERE vehicle_id = ? " +
            "AND rental_status IN ('BOOKED', 'ACTIVE') " +
            "AND start_date < ? " +
            "AND end_date > ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, vehicleId);
            ps.setDate(2, Date.valueOf(endDate));
            ps.setDate(3, Date.valueOf(startDate));

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1) == 0;
            }
        }
    }

    // 3. Create a new booking
    public int createBooking(
            int customerId,
            int vehicleId,
            LocalDate startDate,
            LocalDate endDate) throws SQLException {

        validateDates(startDate, endDate);

        if (customerId <= 0 || vehicleId <= 0) {
            throw new IllegalArgumentException(
                "Invalid customer or vehicle."
            );
        }

        if (startDate.isBefore(LocalDate.now())) {
            throw new IllegalArgumentException(
                "Pickup date cannot be in the past."
            );
        }

        try (Connection con = DBConnection.getConnection()) {

            boolean originalAutoCommit = con.getAutoCommit();

            try {
                con.setAutoCommit(false);

                // Lock the vehicle row during booking validation.
                String lockSql =
                    "SELECT status FROM vehicles " +
                    "WHERE vehicle_id = ? FOR UPDATE";

                try (PreparedStatement ps =
                         con.prepareStatement(lockSql)) {

                    ps.setInt(1, vehicleId);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (!rs.next()) {
                            throw new SQLException("Vehicle not found.");
                        }

                        String vehicleStatus = rs.getString("status");

                        /*
                         * AVAILABLE: normal booking.
                         * RENTED: future booking may be possible.
                         * Other statuses: reject.
                         */
                        if (vehicleStatus == null ||
                            (!"AVAILABLE".equalsIgnoreCase(vehicleStatus)
                             && !"RENTED".equalsIgnoreCase(vehicleStatus))) {

                            throw new IllegalStateException(
                                "This vehicle is unavailable for booking."
                            );
                        }
                    }
                }

                // Reject overlapping BOOKED or ACTIVE rentals.
                String availabilitySql =
                    "SELECT COUNT(*) FROM rentals " +
                    "WHERE vehicle_id = ? " +
                    "AND rental_status IN ('BOOKED', 'ACTIVE') " +
                    "AND start_date < ? " +
                    "AND end_date > ?";

                try (PreparedStatement ps =
                         con.prepareStatement(availabilitySql)) {

                    ps.setInt(1, vehicleId);
                    ps.setDate(2, Date.valueOf(endDate));
                    ps.setDate(3, Date.valueOf(startDate));

                    try (ResultSet rs = ps.executeQuery()) {
                        rs.next();

                        if (rs.getInt(1) > 0) {
                            throw new IllegalStateException(
                                "This vehicle is already booked " +
                                "for some of these dates."
                            );
                        }
                    }
                }

                // Retrieve the category's daily rental rate.
                BigDecimal dailyRate;

                String rateSql =
                    "SELECT c.daily_rate " +
                    "FROM vehicles v " +
                    "INNER JOIN vehicle_categories c " +
                    "ON v.category_id = c.category_id " +
                    "WHERE v.vehicle_id = ?";

                try (PreparedStatement ps =
                         con.prepareStatement(rateSql)) {

                    ps.setInt(1, vehicleId);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (!rs.next()) {
                            throw new SQLException("Vehicle not found.");
                        }

                        dailyRate = rs.getBigDecimal("daily_rate");

                        if (dailyRate == null ||
                            dailyRate.compareTo(BigDecimal.ZERO) <= 0) {

                            throw new SQLException(
                                "Invalid daily rental rate."
                            );
                        }
                    }
                }

                // Calculate rental amount.
                // End date is exclusive.
                long days = ChronoUnit.DAYS.between(
                    startDate, endDate
                );

                BigDecimal totalAmount = dailyRate.multiply(
                    BigDecimal.valueOf(days)
                );

                // Insert the new booking.
                String insertSql =
                    "INSERT INTO rentals " +
                    "(customer_id, vehicle_id, booking_date, " +
                    "start_date, end_date, total_amount, rental_status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, 'BOOKED')";

                int rentalId;

                try (PreparedStatement ps = con.prepareStatement(
                        insertSql, Statement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, customerId);
                    ps.setInt(2, vehicleId);
                    ps.setDate(3, Date.valueOf(LocalDate.now()));
                    ps.setDate(4, Date.valueOf(startDate));
                    ps.setDate(5, Date.valueOf(endDate));
                    ps.setBigDecimal(6, totalAmount);

                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {

                        if (!keys.next()) {
                            throw new SQLException(
                                "Unable to obtain the booking ID."
                            );
                        }

                        rentalId = keys.getInt(1);
                    }
                }

                con.commit();
                return rentalId;

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

    // 4. Retrieve all bookings belonging to one customer
    public List<RentalBooking> getCustomerBookings(int customerId)
            throws SQLException {

        List<RentalBooking> bookings = new ArrayList<>();

        String sql =
            "SELECT r.rental_id, r.vehicle_id, v.brand, v.model, " +
            "c.category_name, r.start_date, r.end_date, " +
            "r.total_amount, r.rental_status " +
            "FROM rentals r " +
            "INNER JOIN vehicles v " +
            "ON r.vehicle_id = v.vehicle_id " +
            "INNER JOIN vehicle_categories c " +
            "ON v.category_id = c.category_id " +
            "WHERE r.customer_id = ? " +
            "ORDER BY r.booking_date DESC, r.rental_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    RentalBooking booking = new RentalBooking();

                    booking.setRentalId(rs.getInt("rental_id"));
                    booking.setVehicleId(rs.getInt("vehicle_id"));
                    booking.setBrand(rs.getString("brand"));
                    booking.setModel(rs.getString("model"));
                    booking.setCategoryName(
                        rs.getString("category_name")
                    );
                    booking.setStartDate(
                        rs.getDate("start_date")
                    );
                    booking.setEndDate(
                        rs.getDate("end_date")
                    );
                    booking.setTotalAmount(
                        rs.getBigDecimal("total_amount")
                    );
                    booking.setRentalStatus(
                        rs.getString("rental_status")
                    );

                    bookings.add(booking);
                }
            }
        }

        return bookings;
    }

    // 5. Validate pickup and return dates
    private void validateDates(
            LocalDate startDate,
            LocalDate endDate) {

        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException(
                "Both pickup and return dates are required."
            );
        }

        if (!endDate.isAfter(startDate)) {
            throw new IllegalArgumentException(
                "Return date must be after pickup date."
            );
        }
    }
}
