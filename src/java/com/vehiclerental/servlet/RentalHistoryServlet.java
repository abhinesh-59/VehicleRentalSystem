
package com.vehiclerental.servlet;

import com.vehiclerental.dao.RentalHistoryDAO;
import com.vehiclerental.dao.RentalHistoryDAO.RentalRecord;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/rental-history")
public class RentalHistoryServlet extends HttpServlet {

    private final RentalHistoryDAO rentalHistoryDAO =
            new RentalHistoryDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether the customer is logged in
        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("customerId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            // Get the logged-in customer's ID
            int customerId = Integer.parseInt(
                session.getAttribute("customerId").toString()
            );

            // Retrieve the customer's rental history
            List<RentalRecord> rentals =
                rentalHistoryDAO.getCustomerRentalHistory(customerId);

            // Send records to the JSP page
            request.setAttribute("rentalRecords", rentals);

            // Open Rental History page
            request.getRequestDispatcher("/rental-history.jsp")
                   .forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                "Unable to retrieve rental history.", e
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
        }
    }
}
