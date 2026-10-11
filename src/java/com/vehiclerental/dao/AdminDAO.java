
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {

    public static class Admin {
        private final int adminId;
        private final String username;
        private final String fullName;

        public Admin(int adminId, String username, String fullName) {
            this.adminId = adminId;
            this.username = username;
            this.fullName = fullName;
        }

        public int getAdminId() {
            return adminId;
        }

        public String getUsername() {
            return username;
        }

        public String getFullName() {
            return fullName;
        }
    }

    public Admin authenticate(String username, String password)
            throws SQLException {

        String sql = "SELECT admin_id, username, password, full_name "
                   + "FROM admins WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");

                    // Supports BCrypt hashes and legacy plain-text passwords.
                    boolean validPassword;

                    if (storedPassword != null
                            && storedPassword.startsWith("$2")) {
                        validPassword = org.mindrot.jbcrypt.BCrypt
                                .checkpw(password, storedPassword);
                    } else {
                        validPassword = password != null
                                && password.equals(storedPassword);
                    }

                    if (validPassword) {
                        return new Admin(
                                rs.getInt("admin_id"),
                                rs.getString("username"),
                                rs.getString("full_name")
                        );
                    }
                }
            }
        }

        return null;
    }
}
