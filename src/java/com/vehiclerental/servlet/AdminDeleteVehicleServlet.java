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

@WebServlet("/admin-delete-vehicle")
public class AdminDeleteVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String idText = request.getParameter("vehicleId");
        String result;

        try {
            if (idText == null || idText.trim().isEmpty()) {
                result = "invalid";
            } else {
                int vehicleId = Integer.parseInt(idText);

                if (vehicleId <= 0) {
                    result = "invalid";
                } else {
                    result = deleteVehicle(vehicleId);
                }
            }

        } catch (NumberFormatException e) {
            result = "invalid";

        } catch (SQLException e) {
            if ("23000".equals(e.getSQLState())) {
                result = "hasrecords";
            } else {
                throw new ServletException(
                    "Unable to delete vehicle.", e);
            }
        }

        response.sendRedirect(
            request.getContextPath() + "/admin-vehicles?result=" + result);
    }

    private String deleteVehicle(int vehicleId) throws SQLException {

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                // Lock the selected vehicle while checking its status.
                String lockSql =
                    "SELECT status FROM vehicles "
                    + "WHERE vehicle_id=? FOR UPDATE";

                try (PreparedStatement ps = con.prepareStatement(lockSql)) {
                    ps.setInt(1, vehicleId);

                    try (java.sql.ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            con.rollback();
                            return "notfound";
                        }

                        String status = rs.getString("status");

                        if (status != null
                                && !status.equalsIgnoreCase("AVAILABLE")) {
                            con.rollback();
                            return "notallowed";
                        }
                    }
                }

                // Preserve vehicles that have rental history.
                String rentalSql =
                    "SELECT 1 FROM rentals WHERE vehicle_id=? LIMIT 1";

                try (PreparedStatement ps = con.prepareStatement(rentalSql)) {
                    ps.setInt(1, vehicleId);

                    try (java.sql.ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            con.rollback();
                            return "hasrecords";
                        }
                    }
                }

                String deleteSql =
                    "DELETE FROM vehicles WHERE vehicle_id=?";

                try (PreparedStatement ps = con.prepareStatement(deleteSql)) {
                    ps.setInt(1, vehicleId);

                    int deleted = ps.executeUpdate();

                    if (deleted == 1) {
                        con.commit();
                        return "deleted";
                    } else {
                        con.rollback();
                        return "notfound";
                    }
                }

            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }
}