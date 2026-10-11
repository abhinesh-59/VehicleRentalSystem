
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PaymentHistoryDAO {

    public static class PaymentRecord {
        private int paymentId;
        private int rentalId;
        private String brand;
        private String model;
        private BigDecimal amount;
        private String paymentMethod;
        private String paymentStatus;
        private String transactionId;
        private Timestamp paymentDate;

        public int getPaymentId() {
            return paymentId;
        }

        public void setPaymentId(int paymentId) {
            this.paymentId = paymentId;
        }

        public int getRentalId() {
            return rentalId;
        }

        public void setRentalId(int rentalId) {
            this.rentalId = rentalId;
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

        public BigDecimal getAmount() {
            return amount;
        }

        public void setAmount(BigDecimal amount) {
            this.amount = amount;
        }

        public String getPaymentMethod() {
            return paymentMethod;
        }

        public void setPaymentMethod(String paymentMethod) {
            this.paymentMethod = paymentMethod;
        }

        public String getPaymentStatus() {
            return paymentStatus;
        }

        public void setPaymentStatus(String paymentStatus) {
            this.paymentStatus = paymentStatus;
        }

        public String getTransactionId() {
            return transactionId;
        }

        public void setTransactionId(String transactionId) {
            this.transactionId = transactionId;
        }

        public Timestamp getPaymentDate() {
            return paymentDate;
        }

        public void setPaymentDate(Timestamp paymentDate) {
            this.paymentDate = paymentDate;
        }
    }

    public List<PaymentRecord> getCustomerPaymentHistory(
            int customerId) throws SQLException {

        List<PaymentRecord> records = new ArrayList<>();

        String sql =
            "SELECT p.payment_id, p.rental_id, v.brand, v.model, " +
            "p.amount, p.payment_method, p.payment_status, " +
            "p.transaction_id, p.payment_date " +
            "FROM payments p " +
            "INNER JOIN rentals r ON p.rental_id = r.rental_id " +
            "INNER JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
            "WHERE r.customer_id = ? " +
            "ORDER BY p.payment_date DESC, p.payment_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PaymentRecord record = new PaymentRecord();

                    record.setPaymentId(rs.getInt("payment_id"));
                    record.setRentalId(rs.getInt("rental_id"));
                    record.setBrand(rs.getString("brand"));
                    record.setModel(rs.getString("model"));
                    record.setAmount(rs.getBigDecimal("amount"));
                    record.setPaymentMethod(
                        rs.getString("payment_method")
                    );
                    record.setPaymentStatus(
                        rs.getString("payment_status")
                    );
                    record.setTransactionId(
                        rs.getString("transaction_id")
                    );
                    record.setPaymentDate(
                        rs.getTimestamp("payment_date")
                    );

                    records.add(record);
                }
            }
        }

        return records;
    }
}
