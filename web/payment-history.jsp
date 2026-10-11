<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.PaymentHistoryDAO.PaymentRecord"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<PaymentRecord> records =
        (List<PaymentRecord>) request.getAttribute("paymentRecords");

    String successId = (String) request.getAttribute("successId");
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Payment History - Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        /* =====================================================
           PAYMENT HISTORY PAGE
           ===================================================== */

        .payment-history-page {
            width: min(1280px, 94%);
            margin: 0 auto;
            padding: 50px 0 75px;
        }


        /* =====================================================
           NAVBAR - PROFESSIONAL SPACING
           ===================================================== */

        .navbar {
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            gap: 30px !important;
            padding: 0 5% !important;
            min-height: 72px !important;
            box-sizing: border-box !important;
        }

        .navbar-brand {
            display: flex !important;
            align-items: center !important;
            flex-shrink: 0 !important;
            font-size: 20px !important;
            font-weight: 800 !important;
            white-space: nowrap !important;
            color: #ffffff !important;
        }

        .navbar-links {
            display: flex !important;
            align-items: center !important;
            justify-content: flex-end !important;
            gap: 8px !important;
            flex-wrap: wrap !important;
        }

        .navbar-links a {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            padding: 10px 13px !important;
            margin: 0 !important;
            color: #ffffff !important;
            text-decoration: none !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            border-radius: 7px !important;
            white-space: nowrap !important;
            transition: all 0.2s ease !important;
        }

        .navbar-links a:hover {
            background: rgba(255, 255, 255, 0.12) !important;
            color: #ffffff !important;
        }

        .navbar-links a.active {
            background: rgba(255, 255, 255, 0.16) !important;
            color: #ffffff !important;
            font-weight: 800 !important;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            margin: 0 0 12px;
            color: #102a43;
            font-size: 42px;
            font-weight: 800;
            line-height: 1.2;
        }

        .page-header p {
            margin: 0;
            color: #627d98;
            font-size: 18px;
            line-height: 1.7;
        }


        /* =====================================================
           SUCCESS MESSAGE
           ===================================================== */

        .success-message {
            background: #ecfdf3;
            border: 1px solid #a7f3d0;
            border-left: 5px solid #16a34a;
            color: #166534;
            padding: 20px 24px;
            border-radius: 12px;
            margin-bottom: 28px;
            font-size: 16px;
            line-height: 1.7;
            box-shadow: 0 5px 16px rgba(22, 101, 52, 0.06);
        }

        .success-message strong {
            font-weight: 800;
        }


        /* =====================================================
           SUMMARY CARD
           ===================================================== */

        .history-summary {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 16px;
            padding: 24px 28px;
            margin-bottom: 24px;
            box-shadow: 0 7px 22px rgba(16, 42, 67, 0.07);
        }

        .history-summary h2 {
            margin: 0 0 7px;
            color: #102a43;
            font-size: 25px;
            font-weight: 800;
        }

        .history-summary p {
            margin: 0;
            color: #627d98;
            font-size: 17px;
            line-height: 1.6;
        }


        /* =====================================================
           TABLE
           ===================================================== */

        .table-wrapper {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 16px;
            overflow-x: auto;
            box-shadow: 0 9px 28px rgba(16, 42, 67, 0.08);
        }

        .payment-table {
            width: 100%;
            min-width: 1150px;
            border-collapse: collapse;
        }

        .payment-table th {
            background: #102a43;
            color: #ffffff;
            padding: 20px 18px;
            text-align: left;
            font-size: 15px;
            font-weight: 700;
            white-space: nowrap;
        }

        .payment-table td {
            padding: 21px 18px;
            border-bottom: 1px solid #e8eef4;
            color: #334e68;
            font-size: 16px;
            vertical-align: middle;
            line-height: 1.5;
        }

        .payment-table tbody tr:last-child td {
            border-bottom: none;
        }

        .payment-table tbody tr:hover {
            background: #f8fbff;
        }


        /* =====================================================
           PAYMENT / BOOKING IDS
           ===================================================== */

        .payment-id,
        .booking-id {
            color: #102a43;
            font-size: 16px;
            font-weight: 800;
            white-space: nowrap;
        }


        /* =====================================================
           VEHICLE
           ===================================================== */

        .vehicle-name {
            color: #102a43;
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .vehicle-model {
            color: #829ab1;
            font-size: 15px;
        }


        /* =====================================================
           AMOUNT
           ===================================================== */

        .payment-amount {
            color: #102a43;
            font-size: 17px;
            font-weight: 800;
            white-space: nowrap;
        }


        /* =====================================================
           PAYMENT METHOD
           ===================================================== */

        .payment-method {
            color: #486581;
            font-size: 16px;
            font-weight: 600;
            white-space: nowrap;
        }


        /* =====================================================
           PAYMENT DATE
           ===================================================== */

        .payment-date {
            color: #486581;
            font-size: 16px;
            font-weight: 600;
            white-space: nowrap;
        }


        /* =====================================================
           STATUS
           ===================================================== */

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 15px;
            border-radius: 20px;
            background: #dcfce7;
            color: #166534;
            font-size: 14px;
            font-weight: 800;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }


        /* =====================================================
           TRANSACTION ID
           ===================================================== */

        .transaction-id {
            color: #486581;
            font-size: 14px;
            font-family: Consolas, "Courier New", monospace;
            white-space: nowrap;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .empty-state {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 70px 25px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
        }

        .empty-icon {
            width: 82px;
            height: 82px;
            margin: 0 auto 22px;
            border-radius: 50%;
            background: #eaf2ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
        }

        .empty-state h2 {
            margin: 0 0 12px;
            color: #102a43;
            font-size: 30px;
            font-weight: 800;
        }

        .empty-state p {
            max-width: 600px;
            margin: 0 auto 28px;
            color: #627d98;
            font-size: 17px;
            line-height: 1.8;
        }


        /* =====================================================
           BUTTON
           ===================================================== */

        .history-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 14px 23px;
            background: #2563eb;
            color: #ffffff;
            text-decoration: none;
            border-radius: 9px;
            font-size: 15px;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .history-button:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }


        /* =====================================================
           BOTTOM ACTION
           ===================================================== */

        .bottom-action {
            margin-top: 28px;
            display: flex;
            justify-content: flex-start;
        }


        /* =====================================================
           DEMO NOTE
           ===================================================== */

        .demo-note {
            margin-top: 25px;
            padding: 19px 22px;
            background: #fff8e6;
            border: 1px solid #f6d98b;
            border-left: 5px solid #f59e0b;
            border-radius: 10px;
            color: #7c4a03;
            font-size: 16px;
            line-height: 1.7;
        }

        .demo-note strong {
            color: #92400e;
            font-size: 17px;
        }


        /* =====================================================
           RESPONSIVE NAVBAR
           ===================================================== */

        @media (max-width: 1100px) {

            .navbar {
                padding: 12px 4% !important;
                align-items: flex-start !important;
                flex-direction: column !important;
                gap: 12px !important;
            }

            .navbar-links {
                width: 100% !important;
                justify-content: flex-start !important;
                gap: 5px !important;
            }
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 800px) {

            .payment-history-page {
                width: 94%;
                padding-top: 35px;
            }

            .page-header h1 {
                font-size: 36px;
            }

            .page-header p {
                font-size: 17px;
            }

            .history-summary h2 {
                font-size: 23px;
            }

            .history-summary p {
                font-size: 16px;
            }
        }


        @media (max-width: 600px) {

            .navbar {
                padding: 14px 4% !important;
            }

            .navbar-links {
                display: grid !important;
                grid-template-columns: repeat(2, 1fr) !important;
                width: 100% !important;
                gap: 6px !important;
            }

            .navbar-links a {
                width: 100% !important;
                box-sizing: border-box !important;
                font-size: 13px !important;
            }

            .payment-history-page {
                padding-top: 28px;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .page-header p {
                font-size: 16px;
            }

            .success-message {
                font-size: 15px;
            }

            .empty-state {
                padding: 55px 20px;
            }

            .empty-state h2 {
                font-size: 26px;
            }

            .empty-state p {
                font-size: 16px;
            }

            .history-button {
                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     CUSTOMER NAVIGATION
     ========================================================= -->

<nav class="navbar">

    <div class="navbar-brand">
        🚗 VehicleRental
    </div>


    <div class="navbar-links">

        <a href="<%= contextPath %>/dashboard.jsp">
            Dashboard
        </a>

        <a href="<%= contextPath %>/vehicles">
            Vehicles
        </a>

        <a href="<%= contextPath %>/my-bookings">
            My Bookings
        </a>

        <a href="<%= contextPath %>/rental-history">
            Rental History
        </a>

        <a href="<%= contextPath %>/return-history">
            Return History
        </a>

        <a href="<%= contextPath %>/payment-history"
           class="active">
            Payments
        </a>

        <a href="<%= contextPath %>/customer-profile">
            Profile
        </a>

        <a href="<%= contextPath %>/logout">
            Logout
        </a>

    </div>

</nav>


<!-- =========================================================
     MAIN CONTENT
     ========================================================= -->

<main class="payment-history-page">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <h1>
            Payment History
        </h1>

        <p>
            View your recorded payments and transaction references.
        </p>

    </div>


    <!-- =====================================================
         SUCCESS MESSAGE
         ===================================================== -->

    <% if (successId != null) { %>

        <div class="success-message">

            ✅ Payment record created successfully!

            Payment ID:
            <strong>#<%= successId %></strong>.

            This is a simulated payment; no money was charged.

        </div>

    <% } %>


    <!-- =====================================================
         CHECK PAYMENT RECORDS
         ===================================================== -->

    <% if (records == null || records.isEmpty()) { %>


        <!-- EMPTY STATE -->

        <div class="empty-state">

            <div class="empty-icon">
                💳
            </div>

            <h2>
                No Payment Records Yet
            </h2>

            <p>
                Your payments will appear here after you
                submit a payment for a vehicle booking.
            </p>

            <a class="history-button"
               href="<%= contextPath %>/my-bookings">

                📋 View My Bookings

            </a>

        </div>


    <% } else { %>


        <!-- =================================================
             SUMMARY
             ================================================= -->

        <div class="history-summary">

            <h2>
                Payment Records
            </h2>

            <p>

                You have

                <strong>
                    <%= records.size() %>
                </strong>

                payment record<%= records.size() == 1 ? "" : "s" %>.

            </p>

        </div>


        <!-- =================================================
             PAYMENT TABLE
             ================================================= -->

        <div class="table-wrapper">

            <table class="payment-table">

                <thead>

                    <tr>

                        <th>
                            Payment ID
                        </th>

                        <th>
                            Booking ID
                        </th>

                        <th>
                            Vehicle
                        </th>

                        <th>
                            Amount
                        </th>

                        <th>
                            Method
                        </th>

                        <th>
                            Payment Date
                        </th>

                        <th>
                            Status
                        </th>

                        <th>
                            Transaction ID
                        </th>

                    </tr>

                </thead>


                <tbody>


                <% for (PaymentRecord record : records) { %>

                    <tr>


                        <!-- PAYMENT ID -->

                        <td>

                            <span class="payment-id">

                                #<%= record.getPaymentId() %>

                            </span>

                        </td>


                        <!-- BOOKING ID -->

                        <td>

                            <span class="booking-id">

                                #<%= record.getRentalId() %>

                            </span>

                        </td>


                        <!-- VEHICLE -->

                        <td>

                            <div class="vehicle-name">

                                <%= record.getBrand() %>

                            </div>

                            <div class="vehicle-model">

                                <%= record.getModel() %>

                            </div>

                        </td>


                        <!-- AMOUNT -->

                        <td>

                            <span class="payment-amount">

                                ₹<%= record.getAmount().toPlainString() %>

                            </span>

                        </td>


                        <!-- PAYMENT METHOD -->

                        <td>

                            <span class="payment-method">

                                <%= record.getPaymentMethod() %>

                            </span>

                        </td>


                        <!-- PAYMENT DATE -->

                        <td>

                            <span class="payment-date">

                                <%= record.getPaymentDate() %>

                            </span>

                        </td>


                        <!-- STATUS -->

                        <td>

                            <span class="status-badge">

                                <%= record.getPaymentStatus() %>

                            </span>

                        </td>


                        <!-- TRANSACTION ID -->

                        <td>

                            <span class="transaction-id">

                                <%= record.getTransactionId() %>

                            </span>

                        </td>


                    </tr>

                <% } %>


                </tbody>

            </table>

        </div>


        <!-- DEMO NOTE -->

        <div class="demo-note">

            <strong>
                ⚠️ Demo Payment System
            </strong>

            <br>

            Payments displayed on this page are simulated
            records created for the college project.
            No real financial transaction is processed.

        </div>


    <% } %>


    <!-- =====================================================
         BOTTOM ACTION
         ===================================================== -->

    <div class="bottom-action">

        <a class="history-button"
           href="<%= contextPath %>/my-bookings">

            ← Back to My Bookings

        </a>

    </div>


</main>


<!-- =========================================================
     FOOTER
     ========================================================= -->

<footer class="footer">

    <p>
        © 2026 Vehicle Rental Management System.
        All rights reserved.
    </p>

</footer>


</body>

</html>