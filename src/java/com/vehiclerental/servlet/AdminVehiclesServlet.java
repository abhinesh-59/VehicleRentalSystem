package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminVehicleDAO;
import com.vehiclerental.dao.AdminVehicleDAO.VehicleRecord;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-vehicles")
public class AdminVehiclesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp"
            );
            return;
        }

        try {
            AdminVehicleDAO dao = new AdminVehicleDAO();
            List<VehicleRecord> vehicles = dao.getAllVehicles();

            request.setAttribute("vehicles", vehicles);

            request.getRequestDispatcher("/admin-vehicles.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load vehicle records.", e
            );
        }
    }
}