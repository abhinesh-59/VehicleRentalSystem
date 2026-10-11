
package com.vehiclerental.servlet;

import com.vehiclerental.dao.PaymentHistoryDAO;
import com.vehiclerental.dao.PaymentHistoryDAO.PaymentRecord;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/payment-history")
public class PaymentHistoryServlet extends HttpServlet {

    private final PaymentHistoryDAO paymentHistoryDAO =
            new PaymentHistoryDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("customerId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            int customerId = Integer.parseInt(
                session.getAttribute("customerId").toString()
            );

            List<PaymentRecord> records =
                paymentHistoryDAO.getCustomerPaymentHistory(customerId);

            request.setAttribute("paymentRecords", records);

            String successId = request.getParameter("success");
            if (successId != null && successId.matches("\\d+")) {
                request.setAttribute("successId", successId);
            }

            request.getRequestDispatcher("/payment-history.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load payment history.", e
            );
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
        }
    }
}
