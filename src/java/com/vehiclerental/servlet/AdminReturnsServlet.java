
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminReturnDAO;
import com.vehiclerental.dao.AdminReturnDAO.ReturnableRental;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-returns")
public class AdminReturnsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Only an authenticated administrator can access this page.
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        try {
            AdminReturnDAO dao = new AdminReturnDAO();

            List<ReturnableRental> rentals = dao.getActiveRentals();

            request.setAttribute("returnableRentals", rentals);

            request.getRequestDispatcher("/admin-returns.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            getServletContext().log(
                    "Unable to load active rentals for return", e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load active rentals. Please try again.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Administrator login required.");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        try {
            int rentalId = Integer.parseInt(
                    request.getParameter("rentalId"));

            int odometerReading = Integer.parseInt(
                    request.getParameter("odometerReading"));

            double damageCharges = Double.parseDouble(
                    request.getParameter("damageCharges"));

            double additionalCharges = Double.parseDouble(
                    request.getParameter("additionalCharges"));

            String remarks = request.getParameter("remarks");

            if (rentalId <= 0
                    || odometerReading < 0
                    || !Double.isFinite(damageCharges)
                    || !Double.isFinite(additionalCharges)
                    || damageCharges < 0
                    || additionalCharges < 0
                    || (remarks != null && remarks.length() > 1000)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-returns?result=invalid");
                return;
            }

            AdminReturnDAO dao = new AdminReturnDAO();

            boolean success = dao.confirmReturn(
                    rentalId,
                    odometerReading,
                    damageCharges,
                    additionalCharges,
                    remarks
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-returns?result="
                    + (success ? "success" : "failed"));

        } catch (NumberFormatException e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-returns?result=invalid");

        } catch (IllegalArgumentException e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-returns?result=invalid");

        } catch (SQLException e) {
            getServletContext().log(
                    "Unable to confirm vehicle return", e);

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-returns?result=error");
        }
    }
}
