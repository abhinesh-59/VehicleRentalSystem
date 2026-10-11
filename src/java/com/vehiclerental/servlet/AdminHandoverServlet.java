
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminBookingDAO;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-handover")
public class AdminHandoverServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Administrator login required.");
            return;
        }

        String idValue = request.getParameter("rentalId");

        try {
            int rentalId = Integer.parseInt(idValue);

            if (rentalId <= 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid rental ID.");
                return;
            }

            AdminBookingDAO dao = new AdminBookingDAO();
            boolean activated = dao.activateRental(rentalId);

            String result = activated ? "success" : "failed";

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-bookings?handover=" + result);

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid rental ID.");
        } catch (SQLException e) {
            getServletContext().log(
                    "Unable to activate rental", e);
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to process vehicle handover.");
        }
    }
}
