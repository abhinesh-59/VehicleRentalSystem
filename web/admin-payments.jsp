<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.AdminPaymentDAO.PaymentRecord"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<PaymentRecord> payments =
            (List<PaymentRecord>) request.getAttribute("payments");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Payment History | Admin | Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>
        .admin-payment-page {
            width: min(1400px, 94%);
            margin: 0 auto;
            padding: 45px 0 70px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 40px !important;
            color: #102a43;
            margin: 0 0 10px;
            font-weight: 800;
        }

        .page-header p {
            font-size: 17px !important;
            color: #627d98;
            line-height: 1.7;
            margin: 0;
            max-width: 900px;
        }

        .payment-summary {
            background: linear-gradient(135deg, #ffffff, #f7fbff);
            border: 1px solid #d9e2ec;
            border-radius: 18px;
            padding: 28px 32px;
            margin-bottom: 28px;
            box-shadow: 0 8px 24px rgba(16, 42, 67, 0.08);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .summary-label {
            color: #627d98;
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .summary-value {
            color: #102a43;
            font-size: 34px;
            font-weight: 800;
        }

        .summary-icon {
            width: 62px;
            height: 62px;
            border-radius: 16px;
            background: #e8f5e9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
        }

        .payment-panel {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
        }

        .panel-header {
            padding: 24px 28px;
            border-bottom: 1px solid #e1e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
        }

        .panel-header h2 {
            margin: 0;
            color: #102a43;
            font-size: 23px;
        }

        .panel-header span {
            color: #627d98;
            font-size: 14px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1250px;
            border-collapse: collapse;
        }

        th {
            background: #f0f4f8;
            color: #486581;
            padding: 17px 16px;
            text-align: left;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #d9e2ec;
            white-space: nowrap;
        }

        td {
            padding: 18px 16px;
            color: #334e68;
            font-size: 14px;
            border-bottom: 1px solid #e8edf2;
            white-space: nowrap;
        }

        tbody tr {
            transition: background 0.2s ease;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .id-cell {
            font-weight: 700;
            color: #102a43;
        }

        .customer-name {
            font-weight: 700;
            color: #102a43;
        }

        .vehicle-name {
            font-weight: 600;
            color: #334e68;
        }

        .amount {
            font-size: 15px;
            font-weight: 800;
            color: #166534;
        }

        .transaction-id {
            color: #486581;
            font-family: monospace;
            font-size: 13px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 13px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 800;
            min-width: 78px;
        }

        .paid {
            background: #dcfce7;
            color: #166534;
        }

        .other {
            background: #fee2e2;
            color: #991b1b;
        }

        .empty-state {
            padding: 65px 25px;
            text-align: center;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            margin: 0 0 8px;
            color: #243b53;
            font-size: 21px;
        }

        .empty-state p {
            margin: 0;
            color: #829ab1;
            font-size: 14px;
        }

        .info-note {
            margin-top: 25px;
            padding: 18px 22px;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 12px;
            color: #1e40af;
            font-size: 14px;
            line-height: 1.7;
        }

        .info-note strong {
            color: #1e3a8a;
        }

        @media (max-width: 800px) {
            .admin-payment-page {
                width: 94%;
                padding-top: 30px;
            }

            .page-header h1 {
                font-size: 32px !important;
            }

            .page-header p {
                font-size: 15px !important;
            }

            .payment-summary {
                padding: 22px;
            }

            .summary-value {
                font-size: 28px;
            }

            .panel-header {
                padding: 20px;
            }
        }

        @media (max-width: 500px) {
            .page-header h1 {
                font-size: 28px !important;
            }

            .payment-summary {
                padding: 20px;
            }

            .summary-icon {
                width: 52px;
                height: 52px;
                font-size: 24px;
            }

            .summary-value {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

<!-- Admin Navigation -->
<nav class="navbar">
    <div class="navbar-brand">
        🚗 VehicleRental
    </div>

    <div class="navbar-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/admin-vehicles">
            Vehicles
        </a>

        <a href="<%= request.getContextPath() %>/admin-categories">
            Categories
        </a>

        <a href="<%= request.getContextPath() %>/admin-bookings">
            Bookings
        </a>

        <a href="<%= request.getContextPath() %>/admin-returns">
            Returns
        </a>

        <a href="<%= request.getContextPath() %>/admin-payments"
           class="active">
            Payments
        </a>

        <a href="<%= request.getContextPath() %>/admin-logout"
           class="logout-link">
            Logout
        </a>
    </div>
</nav>


<main class="admin-payment-page">

    <!-- Page Header -->
    <div class="page-header">
        <h1>Payment History</h1>

        <p>
            Review and monitor payment transactions associated with
            customer vehicle rentals, including payment amounts,
            methods, transaction references, and payment status.
        </p>
    </div>


    <!-- Summary -->
    <div class="payment-summary">

        <div>
            <div class="summary-label">
                Total Payment Records
            </div>

            <div class="summary-value">
                <%= payments == null ? 0 : payments.size() %>
            </div>
        </div>

        <div class="summary-icon">
            💳
        </div>

    </div>


    <!-- Payment Table -->
    <div class="payment-panel">

        <div class="panel-header">
            <h2>Payment Transactions</h2>

            <span>
                <%= payments == null ? 0 : payments.size() %> records
            </span>
        </div>


        <div class="table-wrapper">

            <table>

                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Rental ID</th>
                        <th>Customer</th>
                        <th>Vehicle</th>
                        <th>Amount</th>
                        <th>Payment Method</th>
                        <th>Payment Date</th>
                        <th>Transaction ID</th>
                        <th>Status</th>
                    </tr>
                </thead>


                <tbody>

                <%
                    if (payments != null && !payments.isEmpty()) {

                        for (PaymentRecord p : payments) {

                            String paymentStatus = p.getPaymentStatus();

                            String statusClass =
                                "PAID".equalsIgnoreCase(paymentStatus)
                                ? "paid"
                                : "other";
                %>

                    <tr>

                        <td class="id-cell">
                            #<%= p.getPaymentId() %>
                        </td>

                        <td class="id-cell">
                            #<%= p.getRentalId() %>
                        </td>

                        <td class="customer-name">
                            <%= p.getCustomerName() %>
                        </td>

                        <td class="vehicle-name">
                            <%= p.getVehicleName() %>
                        </td>

                        <td class="amount">
                            ₹<%= String.format("%.2f", p.getAmount()) %>
                        </td>

                        <td>
                            <%= p.getPaymentMethod() %>
                        </td>

                        <td>
                            <%= p.getPaymentDate() %>
                        </td>

                        <td class="transaction-id">
                            <%= p.getTransactionId() %>
                        </td>

                        <td>
                            <span class="status <%= statusClass %>">
                                <%= paymentStatus %>
                            </span>
                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>
                        <td colspan="9">

                            <div class="empty-state">

                                <div class="empty-icon">
                                    💳
                                </div>

                                <h3>No Payment Records Found</h3>

                                <p>
                                    Payment transactions will appear here
                                    after customers complete their payments.
                                </p>

                            </div>

                        </td>
                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>


    <!-- Information Note -->
    <div class="info-note">

        <strong>Demo Payment System:</strong>
        This page displays payment records stored in your database.
        The current payment implementation is a demonstration system,
        so these records do not represent actual monetary transactions.

    </div>

</main>


<footer class="footer">
    <p>
        © 2026 Vehicle Rental Management System.
        All rights reserved.
    </p>
</footer>

</body>
</html>