
package com.vehiclerental.servlet;

import com.vehiclerental.dao.CustomerProfileDAO;
import com.vehiclerental.dao.CustomerProfileDAO.CustomerProfile;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/customer-profile")
public class CustomerProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Require customer login
        if (session == null
                || session.getAttribute("customerId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            int customerId =
                ((Number) session.getAttribute("customerId")).intValue();

            CustomerProfileDAO dao = new CustomerProfileDAO();
            CustomerProfile profile = dao.getProfile(customerId);

            if (profile == null) {
                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Customer profile not found."
                );
                return;
            }

            request.setAttribute("profile", profile);

            request.getRequestDispatcher("/customer-profile.jsp")
                   .forward(request, response);

        } catch (SQLException | ClassCastException e) {
            log("Unable to load customer profile.", e);

            throw new ServletException(
                "Unable to load customer profile.", e
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Require customer login
        if (session == null
                || session.getAttribute("customerId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Basic server-side validation
        if (fullName == null || fullName.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || address == null) {

            response.sendRedirect(
                request.getContextPath()
                    + "/customer-profile?result=invalid"
            );
            return;
        }

        fullName = fullName.trim();
        phone = phone.trim();
        address = address.trim();

        if (fullName.length() > 100
                || phone.length() > 15
                || address.length() > 255
                || !phone.matches("[0-9+() -]{7,15}")) {

            response.sendRedirect(
                request.getContextPath()
                    + "/customer-profile?result=invalid"
            );
            return;
        }

        try {
            int customerId =
                ((Number) session.getAttribute("customerId")).intValue();

            CustomerProfileDAO dao = new CustomerProfileDAO();

            boolean updated = dao.updateProfile(
                customerId, fullName, phone, address
            );

            if (updated) {
                response.sendRedirect(
                    request.getContextPath()
                        + "/customer-profile?result=updated"
                );
            } else {
                response.sendRedirect(
                    request.getContextPath()
                        + "/customer-profile?result=error"
                );
            }

        } catch (SQLException | ClassCastException e) {
            log("Unable to update customer profile.", e);

            throw new ServletException(
                "Unable to update customer profile.", e
            );
        }
    }
}
