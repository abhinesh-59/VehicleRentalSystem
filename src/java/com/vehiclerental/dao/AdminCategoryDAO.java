package com.vehiclerental.dao;

import com.vehiclerental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminCategoryDAO {

    public static class CategoryRecord {

        private int categoryId;
        private String categoryName;
        private double dailyRate;

        public CategoryRecord(int categoryId, String categoryName,
                double dailyRate) {
            this.categoryId = categoryId;
            this.categoryName = categoryName;
            this.dailyRate = dailyRate;
        }

        public int getCategoryId() {
            return categoryId;
        }

        public String getCategoryName() {
            return categoryName;
        }

        public double getDailyRate() {
            return dailyRate;
        }
    }

    public List<CategoryRecord> getAllCategories()
            throws SQLException {

        List<CategoryRecord> categories = new ArrayList<>();

        String sql =
            "SELECT category_id, category_name, daily_rate "
            + "FROM vehicle_categories ORDER BY category_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categories.add(new CategoryRecord(
                    rs.getInt("category_id"),
                    rs.getString("category_name"),
                    rs.getDouble("daily_rate")
                ));
            }
        }

        return categories;
    }

    public boolean updateDailyRate(int categoryId, double dailyRate)
            throws SQLException {

        if (categoryId <= 0 || !Double.isFinite(dailyRate)
                || dailyRate <= 0) {
            return false;
        }

        String sql =
            "UPDATE vehicle_categories SET daily_rate=? "
            + "WHERE category_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, dailyRate);
            ps.setInt(2, categoryId);

            return ps.executeUpdate() == 1;
        }
    }
}