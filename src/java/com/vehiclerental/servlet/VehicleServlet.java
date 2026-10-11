
package com.vehiclerental.servlet;

import com.vehiclerental.dao.Vehicle;
import com.vehiclerental.dao.VehicleDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/vehicles")
public class VehicleServlet extends HttpServlet {

    private final VehicleDAO vehicleDAO = new VehicleDAO();

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

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");

        try {
            List<Vehicle> vehicles =
                    vehicleDAO.searchVehicles(keyword, category);

            request.setAttribute("vehicles", vehicles);
            request.setAttribute("keyword", keyword);
            request.setAttribute("selectedCategory", category);

            request.getRequestDispatcher("/vehicles.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to retrieve vehicles from the database.", e
            );
        }
    }
}
