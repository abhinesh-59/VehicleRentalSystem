
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminDAO;
import com.vehiclerental.dao.AdminDAO.Admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate submitted credentials
        if (username == null || password == null
                || username.trim().isEmpty()
                || password.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-login.jsp?error=1");
            return;
        }

        try {
            AdminDAO adminDAO = new AdminDAO();

            Admin admin = adminDAO.authenticate(
                    username.trim(),
                    password
            );

            if (admin != null) {

                // Invalidate the previous session, if present
                HttpSession oldSession = request.getSession(false);

                if (oldSession != null) {
                    oldSession.invalidate();
                }

                // Create a new session for the authenticated admin
                HttpSession session = request.getSession(true);

                session.setAttribute(
                        "adminId",
                        admin.getAdminId()
                );

                session.setAttribute(
                        "adminUsername",
                        admin.getUsername()
                );

                session.setAttribute(
                        "adminName",
                        admin.getFullName()
                );

                // Session expires after 20 minutes of inactivity
                session.setMaxInactiveInterval(20 * 60);

                // Redirect to the admin dashboard
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-dashboard");

            } else {

                // Invalid username or password
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-login.jsp?error=1");
            }

        } catch (SQLException e) {

            getServletContext().log(
                    "Database error during admin login",
                    e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to process admin login. Please try again later."
            );
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                + "/admin-login.jsp");
    }
}
