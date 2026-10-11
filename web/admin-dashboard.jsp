<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.vehiclerental.dao.AdminDashboardDAO.DashboardStats"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(
            request.getContextPath() + "/admin-login.jsp"
        );
        return;
    }

    DashboardStats stats =
        (DashboardStats) request.getAttribute("stats");

    String adminName =
        (String) session.getAttribute("adminName");

    if (adminName == null || adminName.trim().isEmpty()) {
        adminName = "System Administrator";
    }

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">


    <style>

        /* =====================================================
           ADMIN DASHBOARD
           ===================================================== */

        .admin-dashboard-page {

            width: min(1280px, 94%);

            margin: 0 auto;

            padding: 45px 0 75px;
        }


        /* =====================================================
           ADMIN NAVBAR
           ===================================================== */

        .admin-navbar {

            background: #102a43 !important;

            min-height: 72px !important;
        }


        .admin-navbar .navbar-inner {

            width: min(1280px, 94%) !important;

            margin: 0 auto !important;
        }


        .admin-navbar .logo {

            font-size: 22px !important;

            font-weight: 800 !important;
        }


        .admin-navbar .logo span {

            color: #60a5fa !important;
        }


        .admin-navbar .nav-links a {

            font-size: 15px !important;
        }


        /* =====================================================
           WELCOME SECTION
           ===================================================== */

        .admin-welcome {

            background:
                linear-gradient(
                    135deg,
                    #ffffff 0%,
                    #f2f7ff 100%
                );

            border: 1px solid #d9e2ec;

            border-radius: 22px;

            padding: 38px 42px;

            margin-bottom: 42px;

            box-shadow:
                0 12px 35px rgba(16, 42, 67, 0.09);

            position: relative;

            overflow: hidden;
        }


        .admin-welcome::after {

            content: "🚘";

            position: absolute;

            right: 45px;

            top: 50%;

            transform: translateY(-50%);

            font-size: 75px;

            opacity: 0.10;
        }


        .admin-welcome h1 {

            margin: 0 0 12px;

            color: #102a43;

            font-size: 34px;

            font-weight: 800;

            position: relative;

            z-index: 1;
        }


        .admin-welcome p {

            margin: 0;

            max-width: 760px;

            color: #627d98;

            font-size: 16px;

            line-height: 1.7;

            position: relative;

            z-index: 1;
        }


        .admin-status {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            margin-top: 20px;

            padding: 8px 15px;

            background: #ecfdf3;

            color: #166534;

            border: 1px solid #bbf7d0;

            border-radius: 20px;

            font-size: 13px;

            font-weight: 700;
        }


        /* =====================================================
           SECTION HEADINGS
           ===================================================== */

        .admin-section-header {

            margin-bottom: 24px;
        }


        .admin-section-title {

            margin: 0 0 7px;

            color: #102a43;

            font-size: 27px;

            font-weight: 800;
        }


        .admin-section-subtitle {

            margin: 0;

            color: #627d98;

            font-size: 15px;

            line-height: 1.6;
        }


        /* =====================================================
           STATISTICS GRID
           ===================================================== */

        .admin-stats-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 24px;

            margin-bottom: 48px;
        }


        /* =====================================================
           STATISTIC CARD
           ===================================================== */

        .admin-stat-card {

            background: #ffffff;

            border: 1px solid #d9e2ec;

            border-radius: 20px;

            padding: 28px;

            min-height: 185px;

            box-shadow:
                0 8px 25px rgba(16, 42, 67, 0.08);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease,
                border-color 0.25s ease;

            position: relative;

            overflow: hidden;
        }


        .admin-stat-card::after {

            content: "";

            position: absolute;

            width: 95px;

            height: 95px;

            border-radius: 50%;

            background: #eef4ff;

            right: -35px;

            bottom: -35px;

            opacity: 0.65;
        }


        .admin-stat-card:hover {

            transform: translateY(-7px);

            box-shadow:
                0 16px 35px rgba(16, 42, 67, 0.14);

            border-color: #bfd2e8;
        }


        .admin-stat-icon {

            width: 58px;

            height: 58px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eef4ff;

            border-radius: 16px;

            font-size: 29px;

            margin-bottom: 20px;

            position: relative;

            z-index: 2;
        }


        .admin-stat-label {

            color: #627d98;

            font-size: 14px;

            font-weight: 700;

            margin-bottom: 8px;

            position: relative;

            z-index: 2;
        }


        .admin-stat-value {

            color: #102a43;

            font-size: 32px;

            font-weight: 800;

            line-height: 1.2;

            overflow-wrap: anywhere;

            position: relative;

            z-index: 2;
        }


        .admin-stat-value.money {

            font-size: 28px;
        }


        /* =====================================================
           MANAGEMENT HEADER
           ===================================================== */

        .management-header {

            margin-top: 5px;

            margin-bottom: 24px;
        }


        /* =====================================================
           MANAGEMENT GRID
           ===================================================== */

        .admin-management-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 24px;
        }


        /* =====================================================
           MANAGEMENT CARD
           ===================================================== */

        .admin-management-card {

            background: #ffffff;

            border: 1px solid #d9e2ec;

            border-radius: 20px;

            padding: 30px;

            min-height: 265px;

            display: flex;

            flex-direction: column;

            box-shadow:
                0 8px 25px rgba(16, 42, 67, 0.08);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease,
                border-color 0.25s ease;
        }


        .admin-management-card:hover {

            transform: translateY(-7px);

            box-shadow:
                0 17px 38px rgba(16, 42, 67, 0.14);

            border-color: #bfd2e8;
        }


        .admin-management-icon {

            width: 62px;

            height: 62px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eef4ff;

            border-radius: 17px;

            font-size: 31px;

            margin-bottom: 19px;
        }


        .admin-management-card h3 {

            color: #102a43;

            font-size: 20px;

            font-weight: 800;

            margin: 0 0 10px;
        }


        .admin-management-card p {

            color: #627d98;

            font-size: 14px;

            line-height: 1.7;

            margin: 0 0 23px;

            flex-grow: 1;
        }


        .admin-management-card .btn {

            width: 100%;

            text-align: center;

            padding: 14px 16px;

            font-size: 15px;

            font-weight: 700;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .admin-footer {

            text-align: center;

            color: #829ab1;

            font-size: 14px;

            margin-top: 55px;

            padding-top: 28px;

            border-top: 1px solid #d9e2ec;
        }


        .admin-footer strong {

            color: #486581;

            font-size: 15px;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 1050px) {

            .admin-stats-grid,
            .admin-management-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }

            .admin-welcome::after {

                display: none;
            }
        }


        @media (max-width: 700px) {

            .admin-dashboard-page {

                width: 92%;

                padding-top: 30px;
            }


            .admin-stats-grid,
            .admin-management-grid {

                grid-template-columns: 1fr;
            }


            .admin-welcome {

                padding: 28px 24px;
            }


            .admin-welcome h1 {

                font-size: 27px;
            }


            .admin-welcome p {

                font-size: 15px;
            }


            .admin-stat-card {

                min-height: 160px;
            }


            .admin-section-title {

                font-size: 24px;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVIGATION
     ===================================================== -->

<nav class="navbar admin-navbar">

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

            <a href="<%= context %>/admin-bookings">
                Bookings
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

<main class="admin-dashboard-page">


    <!-- =================================================
         WELCOME
         ================================================= -->

    <section class="admin-welcome">

        <h1>
            Welcome, <%= adminName %>! 👋
        </h1>

        <p>
            Manage vehicles, customers, bookings, payments and
            rental operations from your centralized administrator
            dashboard.
        </p>

        <div class="admin-status">

            ● System Dashboard Active

        </div>

    </section>


    <!-- =================================================
         SYSTEM OVERVIEW
         ================================================= -->

    <section>

        <div class="admin-section-header">

            <h2 class="admin-section-title">
                System Overview
            </h2>

            <p class="admin-section-subtitle">
                Real-time summary of the vehicle rental management system.
            </p>

        </div>


        <div class="admin-stats-grid">


            <!-- TOTAL VEHICLES -->

            <div class="admin-stat-card">

                <div class="admin-stat-icon">
                    🚘
                </div>

                <div class="admin-stat-label">
                    Total Vehicles
                </div>

                <div class="admin-stat-value">

                    <%= stats != null
                        ? stats.getTotalVehicles()
                        : 0 %>

                </div>

            </div>


            <!-- TOTAL CUSTOMERS -->

            <div class="admin-stat-card">

                <div class="admin-stat-icon">
                    👥
                </div>

                <div class="admin-stat-label">
                    Total Customers
                </div>

                <div class="admin-stat-value">

                    <%= stats != null
                        ? stats.getTotalCustomers()
                        : 0 %>

                </div>

            </div>


            <!-- TOTAL BOOKINGS -->

            <div class="admin-stat-card">

                <div class="admin-stat-icon">
                    📋
                </div>

                <div class="admin-stat-label">
                    Total Bookings
                </div>

                <div class="admin-stat-value">

                    <%= stats != null
                        ? stats.getTotalBookings()
                        : 0 %>

                </div>

            </div>


            <!-- ACTIVE RENTALS -->

            <div class="admin-stat-card">

                <div class="admin-stat-icon">
                    🔑
                </div>

                <div class="admin-stat-label">
                    Active Rentals
                </div>

                <div class="admin-stat-value">

                    <%= stats != null
                        ? stats.getActiveRentals()
                        : 0 %>

                </div>

            </div>


            <!-- COMPLETED RENTALS -->

            <div class="admin-stat-card">

                <div class="admin-stat-icon">
                    ✅
                </div>

                <div class="admin-stat-label">
                    Completed Rentals
                </div>

                <div class="admin-stat-value">

                    <%= stats != null
                        ? stats.getCompletedRentals()
                        : 0 %>

                </div>

            </div>


            <!-- TOTAL PAID -->

            <div class="admin-stat-card">

                <div class="admin-stat-icon">
                    💳
                </div>

                <div class="admin-stat-label">
                    Recorded Paid Amount
                </div>

                <div class="admin-stat-value money">

                    ₹<%= stats != null
                        ? String.format(
                            "%.2f",
                            stats.getTotalPaidAmount()
                          )
                        : "0.00" %>

                </div>

            </div>


        </div>

    </section>


    <!-- =================================================
         MANAGEMENT
         ================================================= -->

    <section class="management-header">

        <div class="admin-section-header">

            <h2 class="admin-section-title">
                Management
            </h2>

            <p class="admin-section-subtitle">
                Access and manage the major operations of the rental system.
            </p>

        </div>


        <div class="admin-management-grid">


            <!-- VEHICLE MANAGEMENT -->

            <div class="admin-management-card">

                <div class="admin-management-icon">
                    🚘
                </div>

                <h3>
                    Vehicle Management
                </h3>

                <p>
                    View registered vehicles, add new vehicles,
                    edit vehicle details and manage your rental fleet.
                </p>

                <a href="<%= context %>/admin-vehicles"
                   class="btn btn-primary">

                    Manage Vehicles →

                </a>

            </div>


            <!-- CATEGORY MANAGEMENT -->

            <div class="admin-management-card">

                <div class="admin-management-icon">
                    🏷️
                </div>

                <h3>
                    Category Management
                </h3>

                <p>
                    Manage vehicle categories and configure
                    their daily rental rates.
                </p>

                <a href="<%= context %>/admin-categories"
                   class="btn btn-primary">

                    Manage Categories →

                </a>

            </div>


            <!-- BOOKING MANAGEMENT -->

            <div class="admin-management-card">

                <div class="admin-management-icon">
                    📋
                </div>

                <h3>
                    Manage Bookings
                </h3>

                <p>
                    Review customer reservations and monitor
                    booking and rental statuses.
                </p>

                <a href="<%= context %>/admin-bookings"
                   class="btn btn-primary">

                    View Bookings →

                </a>

            </div>


            <!-- VEHICLE HANDOVER -->

            <div class="admin-management-card">

                <div class="admin-management-icon">
                    🚙
                </div>

                <h3>
                    Vehicle Handover
                </h3>

                <p>
                    Confirm vehicle handover for eligible
                    customer bookings after successful payment.
                </p>

                <a href="<%= context %>/admin-bookings"
                   class="btn btn-primary">

                    Manage Handovers →

                </a>

            </div>


            <!-- VEHICLE RETURNS -->

            <div class="admin-management-card">

                <div class="admin-management-icon">
                    🔑
                </div>

                <h3>
                    Vehicle Returns
                </h3>

                <p>
                    Record vehicle returns, odometer readings,
                    late fees, damage charges and additional charges.
                </p>

                <a href="<%= context %>/admin-returns"
                   class="btn btn-primary">

                    Manage Returns →

                </a>

            </div>


            <!-- PAYMENT HISTORY -->

            <div class="admin-management-card">

                <div class="admin-management-icon">
                    💳
                </div>

                <h3>
                    Payment History
                </h3>

                <p>
                    Review recorded customer payment transactions
                    and payment statuses.
                </p>

                <a href="<%= context %>/admin-payments"
                   class="btn btn-primary">

                    View Payments →

                </a>

            </div>


        </div>

    </section>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <footer class="admin-footer">

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