
package com.vehiclerental.servlet;

import com.vehiclerental.dao.PaymentDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();

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

        String rentalId = request.getParameter("rentalId");

        if (rentalId == null || !rentalId.matches("\\d+")) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid booking ID."
            );
            return;
        }

        request.setAttribute("rentalId", rentalId);
        request.getRequestDispatcher("/payment.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
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

            int rentalId = Integer.parseInt(
                request.getParameter("rentalId")
            );

            String paymentMethod =
                request.getParameter("paymentMethod");

            int paymentId = paymentDAO.createPayment(
                customerId, rentalId, paymentMethod
            );

            response.sendRedirect(
                request.getContextPath()
                + "/payment-history?success="
                + paymentId
            );

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid booking ID."
            );

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute(
                "rentalId", request.getParameter("rentalId")
            );
            request.getRequestDispatcher("/payment.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to process the simulated payment.", e
            );
        }
    }
}
