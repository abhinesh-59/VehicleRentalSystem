
package com.vehiclerental.servlet;

import com.vehiclerental.dao.BookingDAO;
import com.vehiclerental.dao.RentalBooking;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("customerId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            int customerId = Integer.parseInt(
                session.getAttribute("customerId").toString()
            );

            List<RentalBooking> bookings =
                bookingDAO.getCustomerBookings(customerId);

            request.setAttribute("bookings", bookings);

            String successId = request.getParameter("success");

            if (successId != null && successId.matches("\\d+")) {
                request.setAttribute("successId", successId);
            }

            request.getRequestDispatcher("/my-bookings.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load your bookings.", e
            );
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
        }
    }
}
