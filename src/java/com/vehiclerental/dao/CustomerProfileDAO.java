
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerProfileDAO {

    public static class CustomerProfile {

        private int customerId;
        private String fullName;
        private String email;
        private String phone;
        private String address;

        public CustomerProfile(int customerId, String fullName,
                               String email, String phone,
                               String address) {
            this.customerId = customerId;
            this.fullName = fullName;
            this.email = email;
            this.phone = phone;
            this.address = address;
        }

        public int getCustomerId() {
            return customerId;
        }

        public String getFullName() {
            return fullName;
        }

        public String getEmail() {
            return email;
        }

        public String getPhone() {
            return phone;
        }

        public String getAddress() {
            return address;
        }
    }

    public CustomerProfile getProfile(int customerId)
            throws SQLException {

        String sql =
            "SELECT customer_id, full_name, email, phone, address " +
            "FROM customers WHERE customer_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return new CustomerProfile(
                        rs.getInt("customer_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address")
                    );
                }
            }
        }

        return null;
    }

    public boolean updateProfile(int customerId, String fullName,
                                 String phone, String address)
            throws SQLException {

        String sql =
            "UPDATE customers " +
            "SET full_name = ?, phone = ?, address = ? " +
            "WHERE customer_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setInt(4, customerId);

            return ps.executeUpdate() == 1;
        }
    }
}
