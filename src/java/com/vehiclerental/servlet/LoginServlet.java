
package com.vehiclerental.servlet;

import com.vehiclerental.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String contextPath = request.getContextPath();

        if (email == null || password == null ||
                email.trim().isEmpty() ||
                password.isEmpty()) {

            response.sendRedirect(
                    contextPath + "/login.jsp?error=missing");
            return;
        }

        String sql =
                "SELECT customer_id, full_name, password "
                + "FROM customers WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String storedPassword =
                            rs.getString("password");

                    if (storedPassword != null &&
                            BCrypt.checkpw(
                                    password, storedPassword)) {

                        HttpSession session =
                                request.getSession(true);

                        session.setAttribute(
                                "customerId",
                                rs.getInt("customer_id"));

                        session.setAttribute(
                                "customerName",
                                rs.getString("full_name"));

                        session.setMaxInactiveInterval(30 * 60);

                        response.sendRedirect(
                                contextPath + "/dashboard.jsp");
                        return;
                    }
                }
            }

            response.sendRedirect(
                    contextPath + "/login.jsp?error=invalid");

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to log in customer.", e);
        }
    }
}
