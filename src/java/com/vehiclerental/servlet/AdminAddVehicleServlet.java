package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminVehicleDAO;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-add-vehicle")
public class AdminAddVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String vehicleNumber =
                request.getParameter("vehicleNumber");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String categoryText = request.getParameter("categoryId");
        String yearText = request.getParameter("year");
        String color = request.getParameter("color");
        String seatingText =
                request.getParameter("seatingCapacity");
        String fuelType = request.getParameter("fuelType");
        String transmission = request.getParameter("transmission");

        try {
            if (isBlank(vehicleNumber) || isBlank(brand)
                    || isBlank(model) || isBlank(categoryText)) {
                redirectWithMessage(request, response, "invalid");
                return;
            }

            int categoryId = Integer.parseInt(categoryText);
            Integer year = parseOptionalInteger(yearText);
            Integer seatingCapacity =
                    parseOptionalInteger(seatingText);

            if (categoryId <= 0
                    || (year != null
                        && (year < 1900 || year > 2100))
                    || (seatingCapacity != null
                        && seatingCapacity <= 0)) {
                redirectWithMessage(request, response, "invalid");
                return;
            }

            AdminVehicleDAO dao = new AdminVehicleDAO();

            boolean added = dao.addVehicle(
                categoryId,
                vehicleNumber.trim(),
                brand.trim(),
                model.trim(),
                year,
                blankToNull(color),
                seatingCapacity,
                blankToNull(fuelType),
                blankToNull(transmission)
            );

            redirectWithMessage(request, response,
                    added ? "success" : "failed");

        } catch (NumberFormatException e) {
            redirectWithMessage(request, response, "invalid");

        } catch (SQLException e) {
            if ("23000".equals(e.getSQLState())) {
                redirectWithMessage(request, response, "duplicate");
            } else {
                throw new ServletException(
                    "Unable to add vehicle.", e);
            }
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private Integer parseOptionalInteger(String value) {
        if (isBlank(value)) {
            return null;
        }
        return Integer.valueOf(value.trim());
    }

    private String blankToNull(String value) {
        return isBlank(value) ? null : value.trim();
    }

    private void redirectWithMessage(HttpServletRequest request,
            HttpServletResponse response, String message)
            throws IOException {
        response.sendRedirect(
            request.getContextPath()
            + "/admin-add-vehicle.jsp?result=" + message);
    }
}