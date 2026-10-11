<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.vehiclerental.dao.ReturnHistoryDAO.ReturnRecord"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<ReturnRecord> records =
        (List<ReturnRecord>) request.getAttribute("returnRecords");

    String contextPath = request.getContextPath();

    int totalReturns = records == null ? 0 : records.size();
    int totalLateDays = 0;
    BigDecimal totalCharges = BigDecimal.ZERO;

    if (records != null) {
        for (ReturnRecord record : records) {

            totalLateDays += record.getLateDays();

            if (record.getTotalReturnAmount() != null) {
                totalCharges = totalCharges.add(
                    record.getTotalReturnAmount()
                );
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Return History - Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        /* =====================================================
           RETURN HISTORY PAGE
           ===================================================== */

        .return-history-page {
            width: min(1280px, 94%);
            margin: 0 auto;
            padding: 45px 0 70px;
        }


        /* =====================================================
           CUSTOMER NAVBAR
           ===================================================== */

        .navbar .navbar-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 30px;
        }

        .navbar .logo {
            flex-shrink: 0;
        }

        .navbar .nav-links {
            display: flex !important;
            align-items: center;
            justify-content: flex-end;
            gap: 8px !important;
            flex-wrap: nowrap;
        }

        .navbar .nav-links a {
            display: inline-flex !important;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
            padding: 10px 13px !important;
            margin: 0 !important;
            text-decoration: none;
        }

        .navbar .nav-links .btn-danger {
            margin-left: 5px !important;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .return-page-header {
            margin-bottom: 30px;
        }

        .return-page-header h1 {
            margin: 0 0 10px;
            font-size: 42px;
            color: #102a43;
            font-weight: 800;
        }

        .return-page-header p {
            margin: 0;
            font-size: 17px;
            color: #627d98;
            line-height: 1.6;
        }


        /* =====================================================
           SUMMARY
           ===================================================== */

        .return-summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
            margin-bottom: 30px;
        }

        .return-summary-card {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 28px 30px;
            box-shadow: 0 8px 24px rgba(16, 42, 67, 0.08);
            transition: all 0.25s ease;
        }

        .return-summary-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 30px rgba(16, 42, 67, 0.12);
        }

        .return-summary-icon {
            font-size: 30px;
            margin-bottom: 15px;
        }

        .return-summary-card p {
            margin: 0 0 8px;
            color: #627d98;
            font-size: 15px;
            font-weight: 600;
        }

        .return-summary-card h2 {
            margin: 0;
            color: #102a43;
            font-size: 30px;
            font-weight: 800;
        }


        /* =====================================================
           TABLE PANEL
           ===================================================== */

        .return-table-panel {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
            overflow: hidden;
        }

        .return-table-header {
            padding: 25px 30px;
            border-bottom: 1px solid #e1e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .return-table-header h2 {
            margin: 0;
            color: #102a43;
            font-size: 24px;
        }

        .return-count {
            display: inline-flex;
            align-items: center;
            padding: 8px 15px;
            border-radius: 20px;
            background: #eaf2ff;
            color: #2563eb;
            font-size: 14px;
            font-weight: 700;
        }

        .return-table-wrapper {
            overflow-x: auto;
        }

        .return-table {
            width: 100%;
            min-width: 1350px;
            border-collapse: collapse;
        }

        .return-table th {
            background: #f4f7fb;
            color: #334e68;
            font-size: 14px;
            font-weight: 800;
            padding: 17px 15px;
            text-align: left;
            white-space: nowrap;
            border-bottom: 2px solid #e1e8f0;
        }

        .return-table td {
            padding: 18px 15px;
            font-size: 15px;
            color: #334e68;
            border-bottom: 1px solid #edf2f7;
            vertical-align: top;
        }

        .return-table tbody tr {
            transition: background 0.2s ease;
        }

        .return-table tbody tr:hover {
            background: #f8fafc;
        }


        /* =====================================================
           TABLE DATA
           ===================================================== */

        .return-id {
            font-weight: 800;
            color: #102a43;
            white-space: nowrap;
        }

        .booking-id {
            font-weight: 700;
            color: #2563eb;
            white-space: nowrap;
        }

        .vehicle-name {
            font-size: 16px;
            font-weight: 800;
            color: #102a43;
            margin-bottom: 4px;
        }

        .vehicle-model {
            color: #627d98;
            font-size: 14px;
        }

        .date-value {
            white-space: nowrap;
            font-weight: 600;
            color: #334e68;
        }

        .odometer-value {
            font-weight: 700;
            white-space: nowrap;
        }

        .late-days {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 42px;
            padding: 7px 10px;
            border-radius: 20px;
            background: #f0f4f8;
            color: #334e68;
            font-weight: 800;
        }

        .charge {
            font-size: 15px;
            font-weight: 800;
            color: #102a43;
            white-space: nowrap;
        }

        .total-charge {
            color: #047857;
            font-size: 16px;
        }

        .remarks {
            min-width: 190px;
            max-width: 260px;
            color: #627d98;
            line-height: 1.55;
            overflow-wrap: anywhere;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .return-empty {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 70px 30px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
        }

        .return-empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .return-empty h2 {
            margin: 0 0 10px;
            color: #102a43;
            font-size: 30px;
        }

        .return-empty p {
            margin: 0 auto;
            max-width: 600px;
            color: #627d98;
            font-size: 17px;
            line-height: 1.6;
        }

        .return-empty .btn {
            margin-top: 25px;
        }


        /* =====================================================
           BOTTOM ACTIONS
           ===================================================== */

        .return-actions {
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            margin-top: 28px;
            flex-wrap: wrap;
        }

        .return-info {
            margin-top: 28px;
            padding: 20px 24px;
            background: #f0f7ff;
            border: 1px solid #cfe2ff;
            border-radius: 14px;
            color: #334e68;
            font-size: 14px;
            line-height: 1.7;
        }

        .return-info strong {
            color: #102a43;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 1100px) {

            .navbar .navbar-inner {
                gap: 15px;
            }

            .navbar .nav-links {
                gap: 5px !important;
            }

            .navbar .nav-links a {
                padding: 9px 10px !important;
                font-size: 13px;
            }

        }


        @media (max-width: 900px) {

            .return-summary {
                grid-template-columns: 1fr;
            }

            .return-page-header h1 {
                font-size: 36px;
            }

            .navbar .navbar-inner {
                flex-direction: column;
                align-items: stretch;
            }

            .navbar .logo {
                text-align: center;
            }

            .navbar .nav-links {
                justify-content: center;
                flex-wrap: wrap;
                gap: 6px !important;
            }

        }


        @media (max-width: 600px) {

            .return-history-page {
                width: 92%;
                padding-top: 30px;
            }

            .return-page-header h1 {
                font-size: 30px;
            }

            .return-page-header p {
                font-size: 15px;
            }

            .return-summary-card {
                padding: 23px;
            }

            .return-table-header {
                padding: 20px;
            }

            .return-table-header h2 {
                font-size: 20px;
            }

            .return-empty {
                padding: 50px 20px;
            }

            .return-empty h2 {
                font-size: 25px;
            }

            .navbar .nav-links {
                flex-direction: column;
                width: 100%;
            }

            .navbar .nav-links a {
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

        <div class="navbar-inner">

            <div class="logo">
                🚘 Vehicle<span>Rental</span>
            </div>


            <div class="nav-links">

                <!-- Dashboard -->

                <a href="<%= contextPath %>/dashboard.jsp">

                    Dashboard

                </a>


                <!-- Vehicles -->

                <a href="<%= contextPath %>/vehicles">

                    Vehicles

                </a>


                <!-- My Bookings -->

                <a href="<%= contextPath %>/my-bookings">

                    My Bookings

                </a>


                <!-- Rental History -->

                <a href="<%= contextPath %>/rental-history">

                    Rental History

                </a>


                <!-- Return History -->

                <a href="<%= contextPath %>/return-history"
                   class="active">

                    Return History

                </a>


                <!-- Payments -->

                <a href="<%= contextPath %>/payment-history">

                    Payments

                </a>


                <!-- Profile -->

                <a href="<%= contextPath %>/customer-profile">

                    Profile

                </a>


                <!-- Logout -->

                <a href="<%= contextPath %>/logout"
                   class="btn btn-danger">

                    Logout

                </a>

            </div>

        </div>

    </nav>


    <!-- =========================================================
         MAIN CONTENT
         ========================================================= -->

    <main class="return-history-page">


        <!-- =====================================================
             PAGE HEADER
             ===================================================== -->

        <div class="return-page-header">

            <h1>
                Return History
            </h1>

            <p>
                View your completed vehicle returns, return condition,
                late days and recorded charges.
            </p>

        </div>


        <!-- =====================================================
             SUMMARY
             ===================================================== -->

        <div class="return-summary">


            <!-- Total Returns -->

            <div class="return-summary-card">

                <div class="return-summary-icon">
                    🔄
                </div>

                <p>
                    Total Returns
                </p>

                <h2>
                    <%= totalReturns %>
                </h2>

            </div>


            <!-- Total Late Days -->

            <div class="return-summary-card">

                <div class="return-summary-icon">
                    📅
                </div>

                <p>
                    Total Late Days
                </p>

                <h2>
                    <%= totalLateDays %>
                </h2>

            </div>


            <!-- Total Charges -->

            <div class="return-summary-card">

                <div class="return-summary-icon">
                    💰
                </div>

                <p>
                    Total Recorded Return Charges
                </p>

                <h2>
                    ₹<%= totalCharges.toPlainString() %>
                </h2>

            </div>


        </div>


        <!-- =====================================================
             RETURN RECORDS
             ===================================================== -->

        <% if (records == null || records.isEmpty()) { %>


            <!-- =================================================
                 EMPTY STATE
                 ================================================= -->

            <div class="return-empty">

                <div class="return-empty-icon">
                    🚗
                </div>

                <h2>
                    No Return Records Found
                </h2>

                <p>
                    Your vehicle return details will appear here
                    after a completed vehicle return.
                </p>

                <a class="btn btn-primary"
                   href="<%= contextPath %>/my-bookings">

                    View My Bookings

                </a>

            </div>


        <% } else { %>


            <!-- =================================================
                 RETURN HISTORY TABLE
                 ================================================= -->

            <div class="return-table-panel">

                <div class="return-table-header">

                    <h2>
                        Completed Vehicle Returns
                    </h2>

                    <span class="return-count">

                        <%= totalReturns %>
                        Return<%= totalReturns == 1 ? "" : "s" %>

                    </span>

                </div>


                <div class="return-table-wrapper">

                    <table class="return-table">

                        <thead>

                            <tr>

                                <th>
                                    Return ID
                                </th>

                                <th>
                                    Booking ID
                                </th>

                                <th>
                                    Vehicle
                                </th>

                                <th>
                                    Return Date
                                </th>

                                <th>
                                    Odometer
                                </th>

                                <th>
                                    Late Days
                                </th>

                                <th>
                                    Late Fee
                                </th>

                                <th>
                                    Damage Charges
                                </th>

                                <th>
                                    Additional Charges
                                </th>

                                <th>
                                    Total Charges
                                </th>

                                <th>
                                    Remarks
                                </th>

                            </tr>

                        </thead>


                        <tbody>


                        <% for (ReturnRecord record : records) { %>

                            <tr>


                                <!-- RETURN ID -->

                                <td>

                                    <span class="return-id">

                                        #<%= record.getReturnId() %>

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


                                <!-- RETURN DATE -->

                                <td>

                                    <span class="date-value">

                                        <%= record.getReturnDate() %>

                                    </span>

                                </td>


                                <!-- ODOMETER -->

                                <td>

                                    <span class="odometer-value">

                                        <%= record.getOdometerReading() == null
                                            ? "—"
                                            : record.getOdometerReading() %>

                                    </span>

                                </td>


                                <!-- LATE DAYS -->

                                <td>

                                    <span class="late-days">

                                        <%= record.getLateDays() %>

                                    </span>

                                </td>


                                <!-- LATE FEE -->

                                <td>

                                    <span class="charge">

                                        ₹<%= record.getLateFee() == null
                                            ? "0.00"
                                            : record.getLateFee().toPlainString() %>

                                    </span>

                                </td>


                                <!-- DAMAGE CHARGES -->

                                <td>

                                    <span class="charge">

                                        ₹<%= record.getDamageCharges() == null
                                            ? "0.00"
                                            : record.getDamageCharges().toPlainString() %>

                                    </span>

                                </td>


                                <!-- ADDITIONAL CHARGES -->

                                <td>

                                    <span class="charge">

                                        ₹<%= record.getAdditionalCharges() == null
                                            ? "0.00"
                                            : record.getAdditionalCharges().toPlainString() %>

                                    </span>

                                </td>


                                <!-- TOTAL CHARGES -->

                                <td>

                                    <span class="charge total-charge">

                                        ₹<%= record.getTotalReturnAmount() == null
                                            ? "0.00"
                                            : record.getTotalReturnAmount().toPlainString() %>

                                    </span>

                                </td>


                                <!-- REMARKS -->

                                <td>

                                    <div class="remarks">

                                        <%= record.getRemarks() == null
                                            || record.getRemarks().trim().isEmpty()
                                            ? "—"
                                            : record.getRemarks() %>

                                    </div>

                                </td>


                            </tr>

                        <% } %>


                        </tbody>

                    </table>

                </div>

            </div>


            <!-- =================================================
                 INFORMATION
                 ================================================= -->

            <div class="return-info">

                <strong>
                    Return Information:
                </strong>

                The total return charges shown above represent the charges
                recorded during the vehicle return process, including late
                fees, damage charges and additional charges.

            </div>


        <% } %>


        <!-- =====================================================
             ACTIONS
             ===================================================== -->

        <div class="return-actions">

            <a class="btn btn-primary"
               href="<%= contextPath %>/rental-history">

                ← Back to Rental History

            </a>


            <a class="btn btn-secondary"
               href="<%= contextPath %>/my-bookings">

                View My Bookings

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