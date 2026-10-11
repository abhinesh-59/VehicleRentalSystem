package com.vehiclerental.servlet;

import com.vehiclerental.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-edit-vehicle")
public class AdminEditVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String vehicleNumber = request.getParameter("vehicleNumber");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String categoryText = request.getParameter("categoryId");
        String vehicleText = request.getParameter("vehicleId");

        try {
            if (isBlank(vehicleText) || isBlank(categoryText)
                    || isBlank(vehicleNumber) || isBlank(brand)
                    || isBlank(model)) {
                redirect(request, response, "invalid");
                return;
            }

            int vehicleId = Integer.parseInt(vehicleText);
            int categoryId = Integer.parseInt(categoryText);

            String yearText = request.getParameter("year");
            String seatingText = request.getParameter("seatingCapacity");

            Integer year = parseOptionalInteger(yearText);
            Integer seatingCapacity = parseOptionalInteger(seatingText);

            if (vehicleId <= 0 || categoryId <= 0
                    || (year != null && (year < 1900 || year > 2100))
                    || (seatingCapacity != null && seatingCapacity <= 0)) {
                redirect(request, response, "invalid");
                return;
            }

            String sql =
                "UPDATE vehicles SET category_id=?, vehicle_number=?, "
                + "brand=?, model=?, year=?, color=?, seating_capacity=?, "
                + "fuel_type=?, transmission=? WHERE vehicle_id=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, categoryId);
                ps.setString(2, vehicleNumber.trim());
                ps.setString(3, brand.trim());
                ps.setString(4, model.trim());

                if (year == null) {
                    ps.setNull(5, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(5, year);
                }

                ps.setString(6, blankToNull(request.getParameter("color")));

                if (seatingCapacity == null) {
                    ps.setNull(7, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(7, seatingCapacity);
                }

                ps.setString(8, blankToNull(request.getParameter("fuelType")));
                ps.setString(9, blankToNull(request.getParameter("transmission")));
                ps.setInt(10, vehicleId);

                int updated = ps.executeUpdate();

                redirect(request, response,
                    updated > 0 ? "updated" : "notfound");
            }

        } catch (NumberFormatException e) {
            redirect(request, response, "invalid");

        } catch (SQLException e) {
            if ("23000".equals(e.getSQLState())) {
                redirect(request, response, "duplicate");
            } else {
                throw new ServletException("Unable to update vehicle.", e);
            }
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private Integer parseOptionalInteger(String value) {
        if (isBlank(value)) {
            return null;
        }
        return Integer.valueOf(value.trim());
    }

    private String blankToNull(String value) {
        return isBlank(value) ? null : value.trim();
    }

    private void redirect(HttpServletRequest request,
            HttpServletResponse response, String result)
            throws IOException {
        response.sendRedirect(
            request.getContextPath() + "/admin-vehicles?result=" + result);
    }
}