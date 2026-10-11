package com.vehiclerental.servlet;

import com.vehiclerental.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-edit-vehicle-form")
public class AdminEditVehicleFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String idText = request.getParameter("id");

        try {
            int vehicleId = Integer.parseInt(idText);

            if (vehicleId <= 0) {
                response.sendRedirect(
                    request.getContextPath() + "/admin-vehicles");
                return;
            }

            String sql =
                "SELECT vehicle_id, category_id, vehicle_number, brand, "
                + "model, year, color, seating_capacity, fuel_type, "
                + "transmission, status FROM vehicles WHERE vehicle_id=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, vehicleId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("vehicleId",
                            rs.getInt("vehicle_id"));
                        request.setAttribute("categoryId",
                            rs.getInt("category_id"));
                        request.setAttribute("vehicleNumber",
                            rs.getString("vehicle_number"));
                        request.setAttribute("brand",
                            rs.getString("brand"));
                        request.setAttribute("model",
                            rs.getString("model"));
                        request.setAttribute("year",
                            rs.getObject("year"));
                        request.setAttribute("color",
                            rs.getString("color"));
                        request.setAttribute("seatingCapacity",
                            rs.getObject("seating_capacity"));
                        request.setAttribute("fuelType",
                            rs.getString("fuel_type"));
                        request.setAttribute("transmission",
                            rs.getString("transmission"));
                    } else {
                        response.sendRedirect(
                            request.getContextPath()
                            + "/admin-vehicles?result=notfound");
                        return;
                    }
                }
            }

            request.getRequestDispatcher("/admin-edit-vehicle.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/admin-vehicles?result=invalid");

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load vehicle details.", e);
        }
    }
}