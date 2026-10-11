<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.RentalBooking"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<RentalBooking> bookings =
        (List<RentalBooking>) request.getAttribute("bookings");

    String successId = (String) request.getAttribute("successId");
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Bookings - Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        /* =========================================================
           MY BOOKINGS PAGE
           ========================================================= */

        .bookings-page {
            width: min(1280px, 94%);
            margin: 0 auto;
            padding: 50px 0 75px;
            font-size: 16px;
        }


        /* =========================================================
           NAVBAR - FORCE PROFESSIONAL SPACING
           ========================================================= */

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


        /* =========================================================
           PAGE HEADER
           ========================================================= */

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 42px;
            color: #102a43;
            margin: 0 0 12px;
            font-weight: 800;
            line-height: 1.2;
        }

        .page-header p {
            color: #627d98;
            font-size: 18px;
            margin: 0;
            line-height: 1.7;
        }


        /* =========================================================
           SUCCESS MESSAGE
           ========================================================= */

        .success-message {
            background: #ecfdf3;
            border: 1px solid #a7f3d0;
            color: #166534;
            padding: 20px 24px;
            border-radius: 12px;
            margin-bottom: 28px;
            font-size: 17px;
            line-height: 1.6;
            box-shadow: 0 4px 14px rgba(22, 101, 52, 0.06);
        }

        .success-message strong {
            font-weight: 800;
        }


        /* =========================================================
           BOOKING SUMMARY
           ========================================================= */

        .booking-summary {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 16px;
            padding: 25px 30px;
            margin-bottom: 24px;
            box-shadow: 0 7px 22px rgba(16, 42, 67, 0.07);
        }

        .booking-summary h2 {
            margin: 0 0 8px;
            color: #102a43;
            font-size: 26px;
            font-weight: 750;
        }

        .booking-summary p {
            margin: 0;
            color: #627d98;
            font-size: 17px;
            line-height: 1.6;
        }


        /* =========================================================
           TABLE
           ========================================================= */

        .table-wrapper {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 16px;
            overflow-x: auto;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
        }

        .bookings-table {
            width: 100%;
            min-width: 1150px;
            border-collapse: collapse;
        }

        .bookings-table th {
            background: #102a43;
            color: #ffffff;
            padding: 20px 18px;
            text-align: left;
            font-size: 15px;
            font-weight: 700;
            white-space: nowrap;
        }

        .bookings-table td {
            padding: 21px 18px;
            border-bottom: 1px solid #e8eef4;
            color: #334e68;
            font-size: 16px;
            vertical-align: middle;
            line-height: 1.5;
        }

        .bookings-table tbody tr:last-child td {
            border-bottom: none;
        }

        .bookings-table tbody tr:hover {
            background: #f8fbff;
        }


        /* =========================================================
           BOOKING ID
           ========================================================= */

        .booking-id {
            font-weight: 800;
            color: #102a43;
            white-space: nowrap;
            font-size: 16px;
        }


        /* =========================================================
           VEHICLE
           ========================================================= */

        .vehicle-name {
            color: #102a43;
            font-weight: 700;
            font-size: 17px;
            margin-bottom: 5px;
        }

        .vehicle-model {
            color: #829ab1;
            font-size: 15px;
        }


        /* =========================================================
           CATEGORY
           ========================================================= */

        .category-text {
            font-weight: 600;
            color: #486581;
            font-size: 16px;
        }


        /* =========================================================
           DATES
           ========================================================= */

        .date-text {
            white-space: nowrap;
            color: #486581;
            font-weight: 600;
            font-size: 16px;
        }


        /* =========================================================
           AMOUNT
           ========================================================= */

        .amount {
            font-weight: 800;
            color: #102a43;
            white-space: nowrap;
            font-size: 17px;
        }


        /* =========================================================
           STATUS BADGES
           ========================================================= */

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
            background: #dcfce7;
            color: #166534;
        }

        .status-completed {
            background: #e2e8f0;
            color: #475569;
        }

        .status-other {
            background: #fef3c7;
            color: #92400e;
        }


        /* =========================================================
           PAY BUTTON
           ========================================================= */

        .pay-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 19px;
            background: #15803d;
            color: #ffffff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            white-space: nowrap;
            transition: all 0.2s ease;
        }

        .pay-button:hover {
            background: #166534;
            transform: translateY(-1px);
        }

        .not-available {
            color: #94a3b8;
            font-size: 14px;
            font-weight: 600;
        }


        /* =========================================================
           EMPTY STATE
           ========================================================= */

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
            color: #102a43;
            font-size: 30px;
            margin: 0 0 12px;
            font-weight: 800;
        }

        .empty-state p {
            max-width: 600px;
            margin: 0 auto 28px;
            color: #627d98;
            font-size: 17px;
            line-height: 1.8;
        }


        /* =========================================================
           BROWSE BUTTON
           ========================================================= */

        .browse-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 14px 24px;
            background: #2563eb;
            color: #ffffff;
            text-decoration: none;
            border-radius: 9px;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.2s ease;
        }

        .browse-button:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }


        /* =========================================================
           BOTTOM ACTION
           ========================================================= */

        .bottom-actions {
            margin-top: 28px;
            display: flex;
            justify-content: flex-end;
        }

        .secondary-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 14px 22px;
            background: #ffffff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
            text-decoration: none;
            border-radius: 9px;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.2s ease;
        }

        .secondary-button:hover {
            background: #eff6ff;
            transform: translateY(-1px);
        }


        /* =========================================================
           RESPONSIVE
           ========================================================= */

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


        @media (max-width: 900px) {

            .bookings-page {
                width: 94%;
                padding-top: 35px;
            }

            .page-header h1 {
                font-size: 36px;
            }

            .page-header p {
                font-size: 17px;
            }

            .booking-summary h2 {
                font-size: 23px;
            }

            .booking-summary p {
                font-size: 16px;
            }
        }


        @media (max-width: 700px) {

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
        }


        @media (max-width: 600px) {

            .bookings-page {
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

            .bottom-actions {
                justify-content: stretch;
            }

            .secondary-button {
                width: 100%;
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

        <a href="<%= contextPath %>/my-bookings"
           class="active">
            My Bookings
        </a>

        <a href="<%= contextPath %>/rental-history">
            Rental History
        </a>

        <a href="<%= contextPath %>/return-history">
            Return History
        </a>

        <a href="<%= contextPath %>/payment-history">
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

<main class="bookings-page">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <h1>
            My Bookings
        </h1>

        <p>
            View your vehicle reservations, rental dates,
            booking status and payment options.
        </p>

    </div>


    <!-- =====================================================
         SUCCESS MESSAGE
         ===================================================== -->

    <% if (successId != null) { %>

        <div class="success-message">

            ✅ Booking created successfully!

            Your booking ID is
            <strong>#<%= successId %></strong>.

        </div>

    <% } %>


    <!-- =====================================================
         CHECK BOOKINGS
         ===================================================== -->

    <% if (bookings == null || bookings.isEmpty()) { %>


        <!-- EMPTY STATE -->

        <div class="empty-state">

            <div class="empty-icon">
                📋
            </div>

            <h2>
                No Bookings Yet
            </h2>

            <p>
                You have not booked a vehicle yet.
                Browse our available vehicles and make your
                first reservation.
            </p>

            <a class="browse-button"
               href="<%= contextPath %>/vehicles">

                🚗 Browse Vehicles

            </a>

        </div>


    <% } else { %>


        <!-- =================================================
             BOOKING SUMMARY
             ================================================= -->

        <div class="booking-summary">

            <h2>
                Booking History
            </h2>

            <p>

                You currently have

                <strong>
                    <%= bookings.size() %>
                </strong>

                booking<%= bookings.size() == 1 ? "" : "s" %>
                in the system.

            </p>

        </div>


        <!-- =================================================
             BOOKINGS TABLE
             ================================================= -->

        <div class="table-wrapper">

            <table class="bookings-table">

                <thead>

                    <tr>

                        <th>
                            Booking ID
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
                            Booking Status
                        </th>

                        <th>
                            Payment
                        </th>

                    </tr>

                </thead>


                <tbody>


                <% for (RentalBooking booking : bookings) { %>


                    <%

                        String rentalStatus =
                                booking.getRentalStatus();

                        String statusClass =
                                "status-other";

                        if ("BOOKED".equals(rentalStatus)) {

                            statusClass =
                                    "status-booked";

                        } else if ("ACTIVE".equals(rentalStatus)) {

                            statusClass =
                                    "status-active";

                        } else if ("COMPLETED".equals(rentalStatus)) {

                            statusClass =
                                    "status-completed";
                        }

                    %>


                    <tr>


                        <!-- BOOKING ID -->

                        <td>

                            <span class="booking-id">

                                #<%= booking.getRentalId() %>

                            </span>

                        </td>


                        <!-- VEHICLE -->

                        <td>

                            <div class="vehicle-name">

                                <%= booking.getBrand() %>

                            </div>

                            <div class="vehicle-model">

                                <%= booking.getModel() %>

                            </div>

                        </td>


                        <!-- CATEGORY -->

                        <td>

                            <span class="category-text">

                                <%= booking.getCategoryName() %>

                            </span>

                        </td>


                        <!-- PICKUP DATE -->

                        <td>

                            <span class="date-text">

                                <%= booking.getStartDate() %>

                            </span>

                        </td>


                        <!-- RETURN DATE -->

                        <td>

                            <span class="date-text">

                                <%= booking.getEndDate() %>

                            </span>

                        </td>


                        <!-- TOTAL AMOUNT -->

                        <td>

                            <span class="amount">

                                ₹<%= booking.getTotalAmount().toPlainString() %>

                            </span>

                        </td>


                        <!-- BOOKING STATUS -->

                        <td>

                            <span class="status-badge <%= statusClass %>">

                                <%= rentalStatus %>

                            </span>

                        </td>


                        <!-- PAYMENT -->

                        <td>

                            <% if ("BOOKED".equals(rentalStatus)
                                    || "ACTIVE".equals(rentalStatus)) { %>


                                <a class="pay-button"
                                   href="<%= contextPath %>/payment?rentalId=<%= booking.getRentalId() %>">

                                    💳 Pay Now

                                </a>


                            <% } else { %>


                                <span class="not-available">

                                    Not available

                                </span>


                            <% } %>

                        </td>


                    </tr>


                <% } %>


                </tbody>

            </table>

        </div>


    <% } %>


    <!-- =====================================================
         BOTTOM ACTION
         ===================================================== -->

    <div class="bottom-actions">

        <a class="secondary-button"
           href="<%= contextPath %>/vehicles">

            + Book Another Vehicle

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