<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.RentalHistoryDAO.RentalRecord"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<RentalRecord> rentals =
        (List<RentalRecord>) request.getAttribute("rentalRecords");

    String contextPath = request.getContextPath();

    int totalRentals = rentals == null ? 0 : rentals.size();
    int activeRentals = 0;
    int completedRentals = 0;

    if (rentals != null) {
        for (RentalRecord rental : rentals) {

            if ("ACTIVE".equals(rental.getRentalStatus())) {
                activeRentals++;
            }

            if ("COMPLETED".equals(rental.getRentalStatus())) {
                completedRentals++;
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

    <title>Rental History - Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        /* =====================================================
           RENTAL HISTORY PAGE
           ===================================================== */

        .rental-history-page {
            width: min(1280px, 94%);
            margin: 0 auto;
            padding: 50px 0 75px;
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

        .page-header {
            margin-bottom: 32px;
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
           SUMMARY CARDS
           ===================================================== */

        .rental-summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            margin-bottom: 30px;
        }

        .rental-summary-card {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 17px;
            padding: 27px 28px;
            box-shadow: 0 7px 22px rgba(16, 42, 67, 0.08);
            transition: all 0.25s ease;
        }

        .rental-summary-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 13px 30px rgba(16, 42, 67, 0.12);
        }

        .summary-label {
            margin-bottom: 10px;
            color: #627d98;
            font-size: 16px;
            font-weight: 600;
        }

        .summary-number {
            margin: 0;
            color: #102a43;
            font-size: 34px;
            font-weight: 800;
        }


        /* =====================================================
           TABLE CONTAINER
           ===================================================== */

        .rental-table-wrapper {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 17px;
            overflow-x: auto;
            box-shadow: 0 9px 28px rgba(16, 42, 67, 0.08);
        }

        .rental-table {
            width: 100%;
            min-width: 1150px;
            border-collapse: collapse;
        }


        /* =====================================================
           TABLE HEADER
           ===================================================== */

        .rental-table th {
            background: #102a43;
            color: #ffffff;
            padding: 20px 18px;
            text-align: left;
            font-size: 15px;
            font-weight: 700;
            white-space: nowrap;
        }


        /* =====================================================
           TABLE BODY
           ===================================================== */

        .rental-table td {
            padding: 21px 18px;
            border-bottom: 1px solid #e8eef4;
            color: #334e68;
            font-size: 16px;
            line-height: 1.5;
            vertical-align: middle;
        }

        .rental-table tbody tr:last-child td {
            border-bottom: none;
        }

        .rental-table tbody tr:hover {
            background: #f8fbff;
        }


        /* =====================================================
           RENTAL ID
           ===================================================== */

        .rental-id {
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
           CATEGORY
           ===================================================== */

        .category-name {
            color: #486581;
            font-size: 16px;
            font-weight: 600;
            white-space: nowrap;
        }


        /* =====================================================
           DATES
           ===================================================== */

        .rental-date {
            color: #486581;
            font-size: 15px;
            font-weight: 600;
            white-space: nowrap;
        }


        /* =====================================================
           AMOUNT
           ===================================================== */

        .rental-amount {
            color: #102a43;
            font-size: 17px;
            font-weight: 800;
            white-space: nowrap;
        }


        /* =====================================================
           STATUS BADGES
           ===================================================== */

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 800;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .status-booked {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-active {
            background: #fef3c7;
            color: #92400e;
        }

        .status-completed {
            background: #dcfce7;
            color: #166534;
        }

        .status-cancelled {
            background: #fee2e2;
            color: #991b1b;
        }

        .status-default {
            background: #e5e7eb;
            color: #374151;
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
            max-width: 650px;
            margin: 0 auto 28px;
            color: #627d98;
            font-size: 17px;
            line-height: 1.8;
        }


        /* =====================================================
           BUTTONS
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

        .bottom-action {
            margin-top: 28px;
            display: flex;
            justify-content: flex-start;
        }


        /* =====================================================
           INFORMATION NOTE
           ===================================================== */

        .history-note {
            margin-top: 25px;
            padding: 19px 22px;
            background: #eef6ff;
            border: 1px solid #c7ddf7;
            border-left: 5px solid #2563eb;
            border-radius: 10px;
            color: #345b7d;
            font-size: 16px;
            line-height: 1.7;
        }

        .history-note strong {
            color: #102a43;
            font-size: 17px;
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

            .rental-summary {
                grid-template-columns: 1fr;
            }

            .rental-history-page {
                padding-top: 38px;
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

            .rental-history-page {
                width: 94%;
                padding-top: 30px;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .page-header p {
                font-size: 16px;
            }

            .summary-number {
                font-size: 30px;
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

                <a href="<%= contextPath %>/rental-history"
                   class="active">

                    Rental History

                </a>


                <!-- Return History -->

                <a href="<%= contextPath %>/return-history">

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

    <main class="rental-history-page">


        <!-- =====================================================
             PAGE HEADER
             ===================================================== -->

        <div class="page-header">

            <h1>
                Rental History
            </h1>

            <p>
                View all your vehicle reservations, rental periods
                and booking statuses.
            </p>

        </div>


        <!-- =====================================================
             SUMMARY CARDS
             ===================================================== -->

        <div class="rental-summary">


            <div class="rental-summary-card">

                <div class="summary-label">
                    Total Rentals
                </div>

                <p class="summary-number">
                    <%= totalRentals %>
                </p>

            </div>


            <div class="rental-summary-card">

                <div class="summary-label">
                    Active Rentals
                </div>

                <p class="summary-number">
                    <%= activeRentals %>
                </p>

            </div>


            <div class="rental-summary-card">

                <div class="summary-label">
                    Completed Rentals
                </div>

                <p class="summary-number">
                    <%= completedRentals %>
                </p>

            </div>


        </div>


        <!-- =====================================================
             RENTAL RECORDS
             ===================================================== -->

        <% if (rentals == null || rentals.isEmpty()) { %>


            <!-- =================================================
                 EMPTY STATE
                 ================================================= -->

            <div class="empty-state">

                <div class="empty-icon">
                    🚗
                </div>

                <h2>
                    No Rental History Available
                </h2>

                <p>
                    Your bookings will appear here after you
                    reserve a vehicle.
                </p>

                <a class="history-button"
                   href="<%= contextPath %>/vehicles">

                    🚘 Browse Vehicles

                </a>

            </div>


        <% } else { %>


            <!-- =================================================
                 RENTAL TABLE
                 ================================================= -->

            <div class="rental-table-wrapper">

                <table class="rental-table">

                    <thead>

                        <tr>

                            <th>
                                Rental ID
                            </th>

                            <th>
                                Booking Date
                            </th>

                            <th>
                                Vehicle
                            </th>

                            <th>
                                Category
                            </th>

                            <th>
                                Pickup Date
                            </th>

                            <th>
                                Return Date
                            </th>

                            <th>
                                Total Amount
                            </th>

                            <th>
                                Status
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (RentalRecord rental : rentals) {

                        String status = rental.getRentalStatus();

                        String statusClass = "status-default";

                        if ("BOOKED".equals(status)) {
                            statusClass = "status-booked";
                        }
                        else if ("ACTIVE".equals(status)) {
                            statusClass = "status-active";
                        }
                        else if ("COMPLETED".equals(status)) {
                            statusClass = "status-completed";
                        }
                        else if ("CANCELLED".equals(status)) {
                            statusClass = "status-cancelled";
                        }

                    %>


                        <tr>


                            <!-- RENTAL ID -->

                            <td>

                                <span class="rental-id">

                                    #<%= rental.getRentalId() %>

                                </span>

                            </td>


                            <!-- BOOKING DATE -->

                            <td>

                                <span class="rental-date">

                                    <%= rental.getBookingDate() %>

                                </span>

                            </td>


                            <!-- VEHICLE -->

                            <td>

                                <div class="vehicle-name">

                                    <%= rental.getBrand() %>

                                </div>

                                <div class="vehicle-model">

                                    <%= rental.getModel() %>

                                </div>

                            </td>


                            <!-- CATEGORY -->

                            <td>

                                <span class="category-name">

                                    <%= rental.getCategoryName() %>

                                </span>

                            </td>


                            <!-- PICKUP DATE -->

                            <td>

                                <span class="rental-date">

                                    <%= rental.getStartDate() %>

                                </span>

                            </td>


                            <!-- RETURN DATE -->

                            <td>

                                <span class="rental-date">

                                    <%= rental.getEndDate() %>

                                </span>

                            </td>


                            <!-- TOTAL AMOUNT -->

                            <td>

                                <span class="rental-amount">

                                    ₹<%= rental.getTotalAmount().toPlainString() %>

                                </span>

                            </td>


                            <!-- STATUS -->

                            <td>

                                <span class="status-badge <%= statusClass %>">

                                    <%= status %>

                                </span>

                            </td>


                        </tr>


                    <% } %>


                    </tbody>

                </table>

            </div>


            <!-- =================================================
                 INFORMATION NOTE
                 ================================================= -->

            <div class="history-note">

                <strong>
                    ℹ️ Rental Status
                </strong>

                <br>

                <b>BOOKED</b> means your vehicle reservation is confirmed.

                <b>ACTIVE</b> means the vehicle has been handed over to you.

                <b>COMPLETED</b> means the vehicle has been returned successfully.

            </div>


        <% } %>


        <!-- =====================================================
             BOTTOM ACTION
             ================================================= -->

        <div class="bottom-action">

            <a class="history-button"
               href="<%= contextPath %>/my-bookings">

                ← View My Bookings

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