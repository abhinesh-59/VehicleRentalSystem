
package com.vehiclerental.servlet;

import com.vehiclerental.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Read registration form values
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        // Validate required fields
        if (isBlank(fullName) || isBlank(email)
                || isBlank(phone) || isBlank(password)) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Full name, email, phone, and password are required."
            );
            return;
        }

        fullName = fullName.trim();
        email = email.trim().toLowerCase(java.util.Locale.ROOT);
        phone = phone.trim();
        address = address == null ? null : address.trim();

        if (fullName.length() > 100 || email.length() > 100
                || phone.length() > 15
                || (address != null && address.length() > 255)
                || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")
                || password.length() < 8
                || password.length() > 72) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Please check your details. Use a valid email and a password of 8–72 characters."
            );
            return;
        }

        // Hash the password before storing it
        String hashedPassword = BCrypt.hashpw(
                password, BCrypt.gensalt(12)
        );

        String sql = "INSERT INTO customers "
                + "(full_name, email, phone, password, address) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setString(4, hashedPassword);

            if (address == null || address.isEmpty()) {
                statement.setNull(5, java.sql.Types.VARCHAR);
            } else {
                statement.setString(5, address);
            }

            statement.executeUpdate();

            // Redirect after successful registration
            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?success=1"
            );

        } catch (SQLException e) {

            // MySQL duplicate key error
            if ("23000".equals(e.getSQLState())
                    && e.getErrorCode() == 1062) {

                response.sendError(
                        HttpServletResponse.SC_CONFLICT,
                        "This email is already registered. Please use another email."
                );

            } else {
                throw new ServletException(
                        "Unable to register customer.", e
                );
            }
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
