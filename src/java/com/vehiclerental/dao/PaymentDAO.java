
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class PaymentDAO {

    // Create a payment record for a customer's booking.
    // This is a simulated payment workflow, not a real transaction.
    public int createPayment(
            int customerId,
            int rentalId,
            String paymentMethod) throws SQLException {

        if (paymentMethod == null ||
                !(paymentMethod.equals("CASH")
                || paymentMethod.equals("CARD")
                || paymentMethod.equals("UPI")
                || paymentMethod.equals("NET_BANKING"))) {

            throw new IllegalArgumentException(
                "Please select a valid payment method."
            );
        }

        String bookingSql =
            "SELECT r.total_amount " +
            "FROM rentals r " +
            "WHERE r.rental_id = ? " +
            "AND r.customer_id = ? " +
            "AND r.rental_status IN ('BOOKED', 'ACTIVE') " +
            "AND NOT EXISTS (" +
            "SELECT 1 FROM payments p " +
            "WHERE p.rental_id = r.rental_id " +
            "AND p.payment_status = 'PAID')";

        String insertSql =
            "INSERT INTO payments " +
            "(rental_id, amount, payment_method, " +
            "payment_status, transaction_id) " +
            "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {

            boolean originalAutoCommit = con.getAutoCommit();

            try {
                con.setAutoCommit(false);

                BigDecimal amount;

                try (PreparedStatement ps =
                        con.prepareStatement(bookingSql)) {

                    ps.setInt(1, rentalId);
                    ps.setInt(2, customerId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new IllegalArgumentException(
                                "Booking not found, already paid, " +
                                "or not eligible for payment."
                            );
                        }

                        amount = rs.getBigDecimal("total_amount");
                    }
                }

                // Generate a simulated transaction reference.
                String transactionId =
                    "VRM-" + UUID.randomUUID()
                                 .toString()
                                 .substring(0, 12)
                                 .toUpperCase();

                int paymentId;

                try (PreparedStatement ps = con.prepareStatement(
                        insertSql,
                        PreparedStatement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, rentalId);
                    ps.setBigDecimal(2, amount);
                    ps.setString(3, paymentMethod);

                    // Simulated payment: record as PAID.
                    // No money is actually charged.
                    ps.setString(4, "PAID");
                    ps.setString(5, transactionId);

                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException(
                                "Unable to obtain payment ID."
                            );
                        }

                        paymentId = keys.getInt(1);
                    }
                }

                con.commit();
                return paymentId;

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
