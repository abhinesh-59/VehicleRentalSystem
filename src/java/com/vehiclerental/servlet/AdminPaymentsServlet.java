
package com.vehiclerental.servlet;

import com.vehiclerental.dao.AdminPaymentDAO;
import com.vehiclerental.dao.AdminPaymentDAO.PaymentRecord;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-payments")
public class AdminPaymentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Only authenticated administrators can access payment records.
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        try {
            AdminPaymentDAO dao = new AdminPaymentDAO();

            List<PaymentRecord> payments = dao.getAllPayments();

            request.setAttribute("payments", payments);

            request.getRequestDispatcher("/admin-payments.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            getServletContext().log(
                    "Unable to load admin payment history", e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load payment history. Please try again later.");
        }
    }
}
