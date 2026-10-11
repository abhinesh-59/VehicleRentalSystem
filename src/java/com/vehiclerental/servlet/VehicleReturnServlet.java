
package com.vehiclerental.servlet;

import com.vehiclerental.dao.VehicleReturnDAO;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import com.vehiclerental.dao.VehicleReturnDAO.ReturnableRental;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/vehicle-return")
public class VehicleReturnServlet extends HttpServlet {

    private final VehicleReturnDAO returnDAO =
            new VehicleReturnDAO();

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

            List<ReturnableRental> rentals =
                returnDAO.getReturnableRentals(customerId);

            request.setAttribute("returnableRentals", rentals);

            String success = request.getParameter("success");
            if ("1".equals(success)) {
                request.setAttribute(
                    "successMessage",
                    "Vehicle return recorded successfully."
                );
            }

            request.getRequestDispatcher("/vehicle-return.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load returnable rentals.", e
            );
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
        }
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

        String rentalIdValue = request.getParameter("rentalId");

        try {
            if (rentalIdValue == null
                    || !rentalIdValue.matches("\\d+")) {
                throw new IllegalArgumentException(
                    "Please select a valid rental."
                );
            }

            int customerId = Integer.parseInt(
                session.getAttribute("customerId").toString()
            );

            int rentalId = Integer.parseInt(rentalIdValue);

            String odometerValue =
                request.getParameter("odometerReading");

            if (odometerValue == null
                    || !odometerValue.matches("\\d+")) {
                throw new IllegalArgumentException(
                    "Enter a valid odometer reading."
                );
            }

            int odometerReading = Integer.parseInt(odometerValue);

            String damageValue = request.getParameter("damageCharges");
            String additionalValue =
                request.getParameter("additionalCharges");

            BigDecimal damageCharges = parseCharge(
                damageValue, "Damage charges"
            );

            BigDecimal additionalCharges = parseCharge(
                additionalValue, "Additional charges"
            );

            String remarks = request.getParameter("remarks");

            returnDAO.returnVehicle(
                customerId,
                rentalId,
                odometerReading,
                damageCharges,
                additionalCharges,
                remarks
            );

            response.sendRedirect(
                request.getContextPath()
                + "/vehicle-return?success=1"
            );

        } catch (IllegalArgumentException
                | IllegalStateException e) {

            request.setAttribute("error", e.getMessage());

            try {
                int customerId = Integer.parseInt(
                    session.getAttribute("customerId").toString()
                );

                List<ReturnableRental> rentals =
                    returnDAO.getReturnableRentals(customerId);

                request.setAttribute("returnableRentals", rentals);

            } catch (SQLException ex) {
                throw new ServletException(
                    "Unable to reload returnable rentals.", ex
                );
            }

            request.getRequestDispatcher("/vehicle-return.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to process vehicle return.", e
            );
        }
    }

    private BigDecimal parseCharge(
            String value, String fieldName) {

        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }

        if (!value.trim().matches("\\d+(\\.\\d{1,2})?")) {
            throw new IllegalArgumentException(
                fieldName + " must be a valid non-negative amount."
            );
        }

        return new BigDecimal(value.trim());
    }
}
