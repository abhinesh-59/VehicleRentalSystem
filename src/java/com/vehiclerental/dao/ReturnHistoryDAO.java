
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

public class ReturnHistoryDAO {

    public static class ReturnRecord {

        private int returnId;
        private int rentalId;
        private String brand;
        private String model;
        private Date returnDate;
        private Integer odometerReading;
        private int lateDays;
        private BigDecimal lateFee;
        private BigDecimal damageCharges;
        private BigDecimal additionalCharges;
        private BigDecimal totalReturnAmount;
        private String remarks;

        public int getReturnId() {
            return returnId;
        }

        public void setReturnId(int returnId) {
            this.returnId = returnId;
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

        public Date getReturnDate() {
            return returnDate;
        }

        public void setReturnDate(Date returnDate) {
            this.returnDate = returnDate;
        }

        public Integer getOdometerReading() {
            return odometerReading;
        }

        public void setOdometerReading(Integer odometerReading) {
            this.odometerReading = odometerReading;
        }

        public int getLateDays() {
            return lateDays;
        }

        public void setLateDays(int lateDays) {
            this.lateDays = lateDays;
        }

        public BigDecimal getLateFee() {
            return lateFee;
        }

        public void setLateFee(BigDecimal lateFee) {
            this.lateFee = lateFee;
        }

        public BigDecimal getDamageCharges() {
            return damageCharges;
        }

        public void setDamageCharges(BigDecimal damageCharges) {
            this.damageCharges = damageCharges;
        }

        public BigDecimal getAdditionalCharges() {
            return additionalCharges;
        }

        public void setAdditionalCharges(BigDecimal additionalCharges) {
            this.additionalCharges = additionalCharges;
        }

        public BigDecimal getTotalReturnAmount() {
            return totalReturnAmount;
        }

        public void setTotalReturnAmount(BigDecimal totalReturnAmount) {
            this.totalReturnAmount = totalReturnAmount;
        }

        public String getRemarks() {
            return remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }
    }

    public List<ReturnRecord> getCustomerReturnHistory(
            int customerId) throws SQLException {

        List<ReturnRecord> records = new ArrayList<>();

        String sql =
            "SELECT rt.return_id, rt.rental_id, v.brand, v.model, " +
            "rt.return_date, rt.odometer_reading, rt.late_days, " +
            "rt.late_fee, rt.damage_charges, rt.additional_charges, " +
            "rt.total_return_amount, rt.remarks " +
            "FROM returns rt " +
            "INNER JOIN rentals r ON rt.rental_id = r.rental_id " +
            "INNER JOIN vehicles v ON r.vehicle_id = v.vehicle_id " +
            "WHERE r.customer_id = ? " +
            "ORDER BY rt.return_date DESC, rt.return_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    ReturnRecord record = new ReturnRecord();

                    record.setReturnId(rs.getInt("return_id"));
                    record.setRentalId(rs.getInt("rental_id"));
                    record.setBrand(rs.getString("brand"));
                    record.setModel(rs.getString("model"));
                    record.setReturnDate(rs.getDate("return_date"));

                    int reading = rs.getInt("odometer_reading");
                    record.setOdometerReading(
                        rs.wasNull() ? null : reading
                    );

                    int lateDays = rs.getInt("late_days");
                    record.setLateDays(
                        rs.wasNull() ? 0 : lateDays
                    );

                    record.setLateFee(rs.getBigDecimal("late_fee"));
                    record.setDamageCharges(
                        rs.getBigDecimal("damage_charges")
                    );
                    record.setAdditionalCharges(
                        rs.getBigDecimal("additional_charges")
                    );
                    record.setTotalReturnAmount(
                        rs.getBigDecimal("total_return_amount")
                    );
                    record.setRemarks(rs.getString("remarks"));

                    records.add(record);
                }
            }
        }

        return records;
    }
}
