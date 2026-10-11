
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDashboardDAO {

    public static class DashboardStats {

        private int totalVehicles;
        private int totalCustomers;
        private int totalBookings;
        private int activeRentals;
        private int completedRentals;
        private double totalPaidAmount;

        public int getTotalVehicles() {
            return totalVehicles;
        }

        public int getTotalCustomers() {
            return totalCustomers;
        }

        public int getTotalBookings() {
            return totalBookings;
        }

        public int getActiveRentals() {
            return activeRentals;
        }

        public int getCompletedRentals() {
            return completedRentals;
        }

        public double getTotalPaidAmount() {
            return totalPaidAmount;
        }
    }

    public DashboardStats getDashboardStats() throws SQLException {

        DashboardStats stats = new DashboardStats();

        String sql =
            "SELECT " +
            "(SELECT COUNT(*) FROM vehicles) AS total_vehicles, " +

            "(SELECT COUNT(*) FROM customers) AS total_customers, " +

            "(SELECT COUNT(*) FROM rentals) AS total_bookings, " +

            "(SELECT COUNT(*) FROM rentals " +
            " WHERE rental_status = 'ACTIVE') AS active_rentals, " +

            "(SELECT COUNT(*) FROM rentals " +
            " WHERE rental_status = 'COMPLETED') AS completed_rentals, " +

            "(SELECT COALESCE(SUM(amount), 0) FROM payments " +
            " WHERE payment_status = 'PAID') AS total_paid_amount";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                stats.totalVehicles =
                    rs.getInt("total_vehicles");

                stats.totalCustomers =
                    rs.getInt("total_customers");

                stats.totalBookings =
                    rs.getInt("total_bookings");

                stats.activeRentals =
                    rs.getInt("active_rentals");

                stats.completedRentals =
                    rs.getInt("completed_rentals");

                stats.totalPaidAmount =
                    rs.getDouble("total_paid_amount");
            }
        }

        return stats;
    }
}
