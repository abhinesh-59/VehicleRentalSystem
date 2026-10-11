
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminDashboardDAO;
import com.vehiclerental.dao.AdminDashboardDAO.DashboardStats;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp"
            );
            return;
        }

        try {
            // Load dashboard statistics
            AdminDashboardDAO dao = new AdminDashboardDAO();

            DashboardStats stats = dao.getDashboardStats();

            // Send statistics to the JSP
            request.setAttribute("stats", stats);

            request.getRequestDispatcher("/admin-dashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            // Print the actual error in the Tomcat/NetBeans logs
            log("Unable to load dashboard statistics.", e);

            throw new ServletException(
                "Unable to load dashboard statistics: "
                + e.getMessage(),
                e
            );
        }
    }
}
