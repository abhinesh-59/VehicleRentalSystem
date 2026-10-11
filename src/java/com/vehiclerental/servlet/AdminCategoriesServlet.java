
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminCategoryDAO;
import com.vehiclerental.dao.AdminCategoryDAO.CategoryRecord;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-categories")
public class AdminCategoriesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp"
            );
            return;
        }

        try {
            AdminCategoryDAO dao = new AdminCategoryDAO();
            List<CategoryRecord> categories = dao.getAllCategories();

            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/admin-categories.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load vehicle categories.", e
            );
        }
    }
}
