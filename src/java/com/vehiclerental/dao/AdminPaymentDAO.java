
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminPaymentDAO {

    // Stores one payment record for the admin page
    public static class PaymentRecord {

        private final int paymentId;
        private final int rentalId;
        private final String customerName;
        private final String vehicleName;
        private final double amount;
        private final String paymentMethod;
        private final String paymentStatus;
        private final String transactionId;
        private final String paymentDate;

        public PaymentRecord(
                int paymentId,
                int rentalId,
                String customerName,
                String vehicleName,
                double amount,
                String paymentMethod,
                String paymentStatus,
                String transactionId,
                String paymentDate) {

            this.paymentId = paymentId;
            this.rentalId = rentalId;
            this.customerName = customerName;
            this.vehicleName = vehicleName;
            this.amount = amount;
            this.paymentMethod = paymentMethod;
            this.paymentStatus = paymentStatus;
            this.transactionId = transactionId;
            this.paymentDate = paymentDate;
        }

        public int getPaymentId() {
            return paymentId;
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

        public double getAmount() {
            return amount;
        }

        public String getPaymentMethod() {
            return paymentMethod;
        }

        public String getPaymentStatus() {
            return paymentStatus;
        }

        public String getTransactionId() {
            return transactionId;
        }

        public String getPaymentDate() {
            return paymentDate;
        }
    }

    // Retrieve all payments for the administrator
    public List<PaymentRecord> getAllPayments()
            throws SQLException {

        List<PaymentRecord> payments = new ArrayList<>();

        String sql =
            "SELECT p.payment_id, p.rental_id, " +
            "c.full_name AS customer_name, " +
            "CONCAT(v.brand, ' ', v.model) AS vehicle_name, " +
            "p.amount, p.payment_method, p.payment_status, " +
            "p.transaction_id, p.payment_date " +
            "FROM payments p " +
            "JOIN rentals r ON p.rental_id = r.rental_id " +
            "JOIN customers c ON r.customer_id = c.customer_id " +
            "JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
            "ORDER BY p.payment_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                PaymentRecord payment = new PaymentRecord(
                    rs.getInt("payment_id"),
                    rs.getInt("rental_id"),
                    rs.getString("customer_name"),
                    rs.getString("vehicle_name"),
                    rs.getDouble("amount"),
                    rs.getString("payment_method"),
                    rs.getString("payment_status"),
                    rs.getString("transaction_id"),
                    rs.getString("payment_date")
                );

                payments.add(payment);
            }
        }

        return payments;
    }
}
