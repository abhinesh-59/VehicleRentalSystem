<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.AdminBookingDAO.BookingRecord"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(
            request.getContextPath() + "/admin-login.jsp"
        );
        return;
    }

    response.setHeader(
        "Cache-Control",
        "no-cache, no-store, must-revalidate"
    );
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<BookingRecord> bookings =
        (List<BookingRecord>) request.getAttribute("bookings");

    String handoverResult =
        request.getParameter("handover");

    String context =
        request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Bookings | Vehicle Rental Admin</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">

    <style>

        /* =====================================================
           PAGE
           ===================================================== */

        .booking-admin-page {
            width: min(1400px, 94%);
            margin: 0 auto;
            padding: 45px 0 75px;
        }


        /* =====================================================
           NAVBAR
           ===================================================== */

        .booking-admin-navbar {
            background: #102a43 !important;
            min-height: 72px !important;
        }

        .booking-admin-navbar .navbar-inner {
            width: min(1280px, 94%) !important;
            margin: 0 auto !important;
        }

        .booking-admin-navbar .logo {
            font-size: 22px !important;
            font-weight: 800 !important;
        }

        .booking-admin-navbar .logo span {
            color: #60a5fa !important;
        }

        .booking-admin-navbar .nav-links a {
            font-size: 15px !important;
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .booking-back {
            display: inline-block;
            margin-bottom: 25px;
            color: #2563eb;
            text-decoration: none;
            font-size: 16px;
            font-weight: 700;
        }

        .booking-back:hover {
            text-decoration: underline;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .booking-page-header {
            margin-bottom: 32px;
        }

        .booking-page-header h1 {
            margin: 0 0 10px;
            color: #102a43;
            font-size: 40px;
            font-weight: 800;
        }

        .booking-page-header p {
            margin: 0;
            max-width: 850px;
            color: #627d98;
            font-size: 17px;
            line-height: 1.7;
        }


        /* =====================================================
           RESULT MESSAGE
           ===================================================== */

        .booking-message {
            padding: 18px 22px;
            margin-bottom: 28px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            border: 1px solid transparent;
        }

        .booking-message.success {
            background: #ecfdf3;
            color: #166534;
            border-color: #bbf7d0;
        }

        .booking-message.error {
            background: #fff1f2;
            color: #991b1b;
            border-color: #fecdd3;
        }


        /* =====================================================
           SUMMARY
           ===================================================== */

        .booking-summary {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            margin-bottom: 22px;
            flex-wrap: wrap;
        }

        .booking-summary-title {
            color: #334e68;
            font-size: 17px;
            font-weight: 600;
        }

        .booking-count {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 17px;
            background: #eef4ff;
            color: #1d4ed8;
            border-radius: 22px;
            font-size: 14px;
            font-weight: 800;
        }


        /* =====================================================
           TABLE PANEL
           ===================================================== */

        .booking-table-panel {
            background: #ffffff;
            border: 1px solid #d9e2ec;
            border-radius: 20px;
            padding: 10px;
            box-shadow:
                0 12px 35px rgba(16, 42, 67, 0.09);
            overflow: hidden;
        }

        .booking-table-wrapper {
            width: 100%;
            overflow-x: auto;
            border-radius: 13px;
        }

        .booking-table {
            width: 100%;
            min-width: 1250px;
            border-collapse: collapse;
        }


        /* =====================================================
           TABLE HEADER
           ===================================================== */

        .booking-table thead {
            background: #f1f5ff;
        }

        .booking-table th {
            padding: 18px 15px;
            text-align: left;
            color: #24476b;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            border-bottom: 1px solid #dbe5f0;
            white-space: nowrap;
        }


        /* =====================================================
           TABLE BODY
           ===================================================== */

        .booking-table td {
            padding: 19px 15px;
            color: #334e68;
            font-size: 15px;
            border-bottom: 1px solid #edf2f7;
            vertical-align: middle;
            white-space: nowrap;
        }

        .booking-table tbody tr {
            transition: background 0.2s ease;
        }

        .booking-table tbody tr:hover {
            background: #f8fbff;
        }

        .booking-table tbody tr:last-child td {
            border-bottom: none;
        }


        /* =====================================================
           RENTAL ID
           ===================================================== */

        .rental-id {
            color: #1d4ed8;
            font-weight: 800;
        }


        /* =====================================================
           CUSTOMER
           ===================================================== */

        .customer-name {
            color: #102a43;
            font-weight: 800;
            font-size: 15px;
        }


        /* =====================================================
           VEHICLE
           ===================================================== */

        .vehicle-name {
            color: #102a43;
            font-weight: 700;
            font-size: 15px;
        }

        .vehicle-number {
            display: inline-block;
            margin-top: 5px;
            padding: 5px 9px;
            background: #f1f5f9;
            border: 1px solid #dbe3ec;
            border-radius: 6px;
            color: #475569;
            font-size: 12px;
            font-weight: 700;
        }


        /* =====================================================
           DATE
           ===================================================== */

        .booking-date {
            color: #486581;
            font-weight: 600;
        }


        /* =====================================================
           AMOUNT
           ===================================================== */

        .booking-amount {
            color: #15803d;
            font-size: 16px;
            font-weight: 800;
        }


        /* =====================================================
           STATUS BADGES
           ===================================================== */

        .booking-status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 90px;
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.2px;
        }

        .payment-paid {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .payment-unpaid {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .status-booked {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .status-active {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        .status-completed {
            background: #e2e8f0;
            color: #475569;
            border: 1px solid #cbd5e1;
        }

        .status-cancelled {
            background: #fce7f3;
            color: #9d174d;
            border: 1px solid #fbcfe8;
        }


        /* =====================================================
           HANDOVER
           ===================================================== */

        .handover-form {
            margin: 0;
        }

        .handover-btn {
            height: 45px;
            padding: 10px 15px;
            border: none;
            border-radius: 9px;
            background: #16a34a;
            color: #ffffff;
            font-family: Arial, sans-serif;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
            box-shadow:
                0 5px 14px rgba(22, 163, 74, 0.18);
        }

        .handover-btn:hover {
            background: #15803d;
            transform: translateY(-2px);
            box-shadow:
                0 8px 18px rgba(22, 163, 74, 0.25);
        }

        .handed-over {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #166534;
            font-size: 13px;
            font-weight: 800;
            white-space: nowrap;
        }

        .not-available {
            color: #829ab1;
            font-size: 13px;
            font-weight: 600;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .booking-empty {
            text-align: center;
            padding: 70px 25px;
            color: #627d98;
        }

        .booking-empty-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .booking-empty h3 {
            margin: 0 0 10px;
            color: #334e68;
            font-size: 22px;
        }

        .booking-empty p {
            margin: 0;
            font-size: 15px;
        }


        /* =====================================================
           INFORMATION NOTE
           ===================================================== */

        .booking-note {
            margin-top: 25px;
            padding: 19px 21px;
            background: #eff6ff;
            border-left: 4px solid #2563eb;
            border-radius: 9px;
            color: #486581;
            font-size: 15px;
            line-height: 1.7;
        }

        .booking-note strong {
            color: #1e40af;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .booking-footer {
            text-align: center;
            color: #829ab1;
            font-size: 14px;
            margin-top: 52px;
            padding-top: 28px;
            border-top: 1px solid #d9e2ec;
        }

        .booking-footer strong {
            color: #486581;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 700px) {

            .booking-admin-page {
                width: 92%;
                padding-top: 30px;
            }

            .booking-page-header h1 {
                font-size: 32px;
            }

            .booking-page-header p {
                font-size: 15px;
            }

            .booking-table-panel {
                padding: 6px;
            }

            .booking-table th,
            .booking-table td {
                padding: 15px 12px;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVIGATION
     ===================================================== -->

<nav class="navbar booking-admin-navbar">

    <div class="navbar-inner">

        <div class="logo">
            🚘 Vehicle<span>Rental</span> Admin
        </div>

        <div class="nav-links">

            <a href="<%= context %>/admin-dashboard">
                Dashboard
            </a>

            <a href="<%= context %>/admin-vehicles">
                Vehicles
            </a>

            <a href="<%= context %>/admin-categories">
                Categories
            </a>

            <a href="<%= context %>/admin-returns">
                Returns
            </a>

            <a href="<%= context %>/admin-payments">
                Payments
            </a>

            <a href="<%= context %>/admin-logout"
               class="btn btn-danger">
                Logout
            </a>

        </div>

    </div>

</nav>


<!-- =====================================================
     MAIN CONTENT
     ===================================================== -->

<main class="booking-admin-page">


    <a class="booking-back"
       href="<%= context %>/admin-dashboard">

        ← Back to Admin Dashboard

    </a>


    <!-- PAGE HEADER -->

    <section class="booking-page-header">

        <h1>
            Manage Bookings
        </h1>

        <p>
            Review customer reservations, vehicle details,
            rental dates, payment information and confirm
            eligible vehicle handovers.
        </p>

    </section>


    <!-- =================================================
         RESULT MESSAGE
         ================================================= -->

    <% if ("success".equals(handoverResult)) { %>

        <div class="booking-message success">

            ✓ Vehicle handover confirmed successfully.

        </div>

    <% } else if ("failed".equals(handoverResult)) { %>

        <div class="booking-message error">

            ✕ Handover could not be completed.
            Check that the booking is still BOOKED
            and its payment status is PAID.

        </div>

    <% } %>


    <!-- =================================================
         SUMMARY
         ================================================= -->

    <div class="booking-summary">

        <div class="booking-summary-title">

            Booking Records

        </div>

        <div class="booking-count">

            📋

            <%= bookings == null ? 0 : bookings.size() %>

            Total Bookings

        </div>

    </div>


    <!-- =================================================
         TABLE
         ================================================= -->

    <section class="booking-table-panel">

        <div class="booking-table-wrapper">

            <table class="booking-table">

                <thead>

                    <tr>

                        <th>
                            Rental ID
                        </th>

                        <th>
                            Customer
                        </th>

                        <th>
                            Vehicle
                        </th>

                        <th>
                            Vehicle Number
                        </th>

                        <th>
                            Start Date
                        </th>

                        <th>
                            End Date
                        </th>

                        <th>
                            Total Amount
                        </th>

                        <th>
                            Payment
                        </th>

                        <th>
                            Rental Status
                        </th>

                        <th>
                            Handover
                        </th>

                    </tr>

                </thead>


                <tbody>


                <%
                    if (bookings != null && !bookings.isEmpty()) {

                        for (BookingRecord b : bookings) {

                            String payment =
                                b.getPaymentStatus();

                            String status =
                                b.getRentalStatus();

                            String paymentClass =
                                "PAID".equalsIgnoreCase(payment)
                                ? "payment-paid"
                                : "payment-unpaid";

                            String statusClass =
                                "status-booked";

                            if ("ACTIVE".equalsIgnoreCase(status)) {

                                statusClass =
                                    "status-active";

                            } else if (
                                "COMPLETED".equalsIgnoreCase(status)
                            ) {

                                statusClass =
                                    "status-completed";

                            } else if (
                                "CANCELLED".equalsIgnoreCase(status)
                            ) {

                                statusClass =
                                    "status-cancelled";
                            }
                %>


                    <tr>


                        <!-- RENTAL ID -->

                        <td>

                            <span class="rental-id">

                                #<%= b.getRentalId() %>

                            </span>

                        </td>


                        <!-- CUSTOMER -->

                        <td>

                            <span class="customer-name">

                                <%= b.getCustomerName() %>

                            </span>

                        </td>


                        <!-- VEHICLE -->

                        <td>

                            <span class="vehicle-name">

                                <%= b.getVehicleName() %>

                            </span>

                        </td>


                        <!-- VEHICLE NUMBER -->

                        <td>

                            <span class="vehicle-number">

                                <%= b.getVehicleNumber() %>

                            </span>

                        </td>


                        <!-- START DATE -->

                        <td>

                            <span class="booking-date">

                                <%= b.getStartDate() %>

                            </span>

                        </td>


                        <!-- END DATE -->

                        <td>

                            <span class="booking-date">

                                <%= b.getEndDate() %>

                            </span>

                        </td>


                        <!-- AMOUNT -->

                        <td>

                            <span class="booking-amount">

                                ₹<%= String.format(
                                    "%.2f",
                                    b.getTotalAmount()
                                ) %>

                            </span>

                        </td>


                        <!-- PAYMENT -->

                        <td>

                            <span class="booking-status <%= paymentClass %>">

                                <%= payment %>

                            </span>

                        </td>


                        <!-- RENTAL STATUS -->

                        <td>

                            <span class="booking-status <%= statusClass %>">

                                <%= status %>

                            </span>

                        </td>


                        <!-- HANDOVER -->

                        <td>


                            <% if (
                                "BOOKED".equalsIgnoreCase(status)
                                &&
                                "PAID".equalsIgnoreCase(payment)
                            ) { %>


                                <form class="handover-form"
                                      method="post"
                                      action="<%= context %>/admin-handover"
                                      onsubmit="return confirm('Confirm that this vehicle has physically been handed over to the customer?');">


                                    <input type="hidden"
                                           name="rentalId"
                                           value="<%= b.getRentalId() %>">


                                    <button
                                        class="handover-btn"
                                        type="submit">

                                        ✓ Confirm Handover

                                    </button>


                                </form>


                            <% } else if (
                                "ACTIVE".equalsIgnoreCase(status)
                            ) { %>


                                <span class="handed-over">

                                    ✓ Handed Over

                                </span>


                            <% } else { %>


                                <span class="not-available">

                                    Not Available

                                </span>


                            <% } %>


                        </td>


                    </tr>


                <%
                        }

                    } else {
                %>


                    <tr>

                        <td colspan="10">

                            <div class="booking-empty">

                                <div class="booking-empty-icon">
                                    📋
                                </div>

                                <h3>
                                    No Bookings Found
                                </h3>

                                <p>
                                    There are currently no customer
                                    bookings in the system.
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

    </section>


    <!-- =================================================
         INFORMATION NOTE
         ================================================= -->

    <div class="booking-note">

        <strong>Handover Rule:</strong>

        Only bookings with status
        <strong>BOOKED</strong>
        and payment status
        <strong>PAID</strong>
        display the
        <strong>Confirm Handover</strong>
        button.

        Confirm the physical vehicle handover before clicking it.

    </div>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <footer class="booking-footer">

        <p>

            <strong>
                Vehicle Rental Management System
            </strong>

        </p>

        <p>

            © 2026 Vehicle Rental System · Admin Panel

        </p>

    </footer>


</main>


</body>

</html>