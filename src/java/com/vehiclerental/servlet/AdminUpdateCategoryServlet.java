
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminCategoryDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-update-category")
public class AdminUpdateCategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        // Verify admin login
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(contextPath + "/admin-login.jsp");
            return;
        }

        // Read form values
        String categoryIdText = request.getParameter("categoryId");
        String dailyRateText = request.getParameter("dailyRate");

        int categoryId;
        double dailyRate;

        try {
            categoryId = Integer.parseInt(categoryIdText);
            dailyRate = Double.parseDouble(dailyRateText);

            if (categoryId <= 0
                    || !Double.isFinite(dailyRate)
                    || dailyRate <= 0) {

                response.sendRedirect(
                    contextPath + "/admin-categories?result=invalid"
                );
                return;
            }

        } catch (NumberFormatException | NullPointerException e) {
            response.sendRedirect(
                contextPath + "/admin-categories?result=invalid"
            );
            return;
        }

        try {
            AdminCategoryDAO dao = new AdminCategoryDAO();

            boolean updated = dao.updateDailyRate(categoryId, dailyRate);

            if (updated) {
                response.sendRedirect(
                    contextPath + "/admin-categories?result=updated"
                );
            } else {
                response.sendRedirect(
                    contextPath + "/admin-categories?result=error"
                );
            }

        } catch (Exception e) {
            log("Failed to update vehicle category daily rate.", e);

            response.sendRedirect(
                contextPath + "/admin-categories?result=error"
            );
        }
    }
}
