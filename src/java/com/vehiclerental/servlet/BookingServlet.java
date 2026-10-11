
package com.vehiclerental.servlet;

import com.vehiclerental.dao.BookingDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/book-vehicle")
public class BookingServlet extends HttpServlet {

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

        String vehicleId = request.getParameter("vehicleId");

        if (vehicleId == null || !vehicleId.matches("\\d+")) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid vehicle ID."
            );
            return;
        }

        request.setAttribute("vehicleId", vehicleId);
        request.getRequestDispatcher("/booking.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
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

            int vehicleId = Integer.parseInt(
                request.getParameter("vehicleId")
            );

            LocalDate startDate = LocalDate.parse(
                request.getParameter("startDate")
            );

            LocalDate endDate = LocalDate.parse(
                request.getParameter("endDate")
            );

            if (startDate.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException(
                    "Pickup date cannot be in the past."
                );
            }

            if (!bookingDAO.isVehicleAvailable(
                    vehicleId, startDate, endDate)) {
                throw new IllegalStateException(
                    "This vehicle is already booked for the selected dates."
                );
            }

            int rentalId = bookingDAO.createBooking(
                customerId, vehicleId, startDate, endDate
            );

            response.sendRedirect(
                request.getContextPath()
                + "/my-bookings?success="
                + rentalId
            );

        } catch (DateTimeParseException | NumberFormatException e) {
            request.setAttribute(
                "error", "Please provide valid vehicle and rental dates."
            );
            request.setAttribute(
                "vehicleId", request.getParameter("vehicleId")
            );
            request.getRequestDispatcher("/booking.jsp")
                   .forward(request, response);

        } catch (IllegalArgumentException | IllegalStateException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute(
                "vehicleId", request.getParameter("vehicleId")
            );
            request.getRequestDispatcher("/booking.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to create the booking.", e
            );
        }
    }
}
