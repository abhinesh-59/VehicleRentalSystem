
package com.vehiclerental.servlet;

import com.vehiclerental.dao.ReturnHistoryDAO;
import com.vehiclerental.dao.ReturnHistoryDAO.ReturnRecord;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/return-history")
public class ReturnHistoryServlet extends HttpServlet {

    private final ReturnHistoryDAO returnHistoryDAO =
            new ReturnHistoryDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Ensure the customer is logged in
        if (session == null
                || session.getAttribute("customerId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            int customerId = Integer.parseInt(
                session.getAttribute("customerId").toString()
            );

            // Fetch this customer's return history
            List<ReturnRecord> records =
                returnHistoryDAO.getCustomerReturnHistory(customerId);

            request.setAttribute("returnRecords", records);

            // Forward the records to the JSP page
            request.getRequestDispatcher("/return-history.jsp")
                   .forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                "Unable to retrieve return history.", e
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
        }
    }
}
