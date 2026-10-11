
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminBookingDAO;
import com.vehiclerental.dao.AdminBookingDAO.BookingRecord;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-bookings")
public class AdminBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Protect the admin bookings page
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        try {
            AdminBookingDAO dao = new AdminBookingDAO();

            List<BookingRecord> bookings = dao.getAllBookings();

            request.setAttribute("bookings", bookings);

            request.getRequestDispatcher("/admin-bookings.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            getServletContext().log(
                    "Unable to load admin bookings", e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load bookings. Please try again later.");
        }
    }
}
