
package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RentalHistoryDAO {

    public static class RentalRecord {

        private int rentalId;
        private int vehicleId;
        private String brand;
        private String model;
        private String categoryName;
        private Date bookingDate;
        private Date startDate;
        private Date endDate;
        private BigDecimal totalAmount;
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

        public String getCategoryName() {
            return categoryName;
        }

        public void setCategoryName(String categoryName) {
            this.categoryName = categoryName;
        }

        public Date getBookingDate() {
            return bookingDate;
        }

        public void setBookingDate(Date bookingDate) {
            this.bookingDate = bookingDate;
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

        public BigDecimal getTotalAmount() {
            return totalAmount;
        }

        public void setTotalAmount(BigDecimal totalAmount) {
            this.totalAmount = totalAmount;
        }

        public String getRentalStatus() {
            return rentalStatus;
        }

        public void setRentalStatus(String rentalStatus) {
            this.rentalStatus = rentalStatus;
        }
    }

    // Retrieve rental history for the logged-in customer
    public List<RentalRecord> getCustomerRentalHistory(
            int customerId) throws SQLException {

        List<RentalRecord> rentals = new ArrayList<>();

        String sql =
            "SELECT r.rental_id, r.vehicle_id, v.brand, v.model, " +
            "c.category_name, r.booking_date, r.start_date, " +
            "r.end_date, r.total_amount, r.rental_status " +
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

                    RentalRecord rental = new RentalRecord();

                    rental.setRentalId(rs.getInt("rental_id"));
                    rental.setVehicleId(rs.getInt("vehicle_id"));
                    rental.setBrand(rs.getString("brand"));
                    rental.setModel(rs.getString("model"));
                    rental.setCategoryName(
                        rs.getString("category_name")
                    );
                    rental.setBookingDate(
                        rs.getDate("booking_date")
                    );
                    rental.setStartDate(
                        rs.getDate("start_date")
                    );
                    rental.setEndDate(
                        rs.getDate("end_date")
                    );
                    rental.setTotalAmount(
                        rs.getBigDecimal("total_amount")
                    );
                    rental.setRentalStatus(
                        rs.getString("rental_status")
                    );

                    rentals.add(rental);
                }
            }
        }

        return rentals;
    }
}
