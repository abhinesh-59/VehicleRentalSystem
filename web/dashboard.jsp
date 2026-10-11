<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String customerName =
        (String) session.getAttribute("customerName");

    if (customerName == null || customerName.trim().isEmpty()) {
        customerName = "Customer";
    }

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Customer Dashboard | Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">

    <style>

        /* =====================================================
           CUSTOMER DASHBOARD
           ===================================================== */

        .dashboard-grid {
            grid-template-columns: repeat(4, 1fr);
        }

        .dashboard-card {
            min-height: 275px;
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
           RESPONSIVE
           ===================================================== */

        @media (max-width: 1100px) {

            .dashboard-grid {
                grid-template-columns: repeat(2, 1fr);
            }

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


        @media (max-width: 850px) {

            .navbar .navbar-inner {
                flex-direction: column;
                align-items: stretch;
                padding: 15px 0;
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


        @media (max-width: 700px) {

            .dashboard-grid {
                grid-template-columns: 1fr;
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


    <!-- =====================================================
         NAVIGATION
         ===================================================== -->

    <nav class="navbar">

        <div class="navbar-inner">

            <div class="logo">
                🚘 Vehicle<span>Rental</span>
            </div>


            <div class="nav-links">

                <!-- Dashboard -->

                <a href="<%= context %>/dashboard.jsp"
                   class="active">

                    Dashboard

                </a>


                <!-- Vehicles -->

                <a href="<%= context %>/vehicles">

                    Vehicles

                </a>


                <!-- My Bookings -->

                <a href="<%= context %>/my-bookings">

                    My Bookings

                </a>


                <!-- Rental History -->

                <a href="<%= context %>/rental-history">

                    Rental History

                </a>


                <!-- Return History -->

                <a href="<%= context %>/return-history">

                    Return History

                </a>


                <!-- Payments -->

                <a href="<%= context %>/payment-history">

                    Payments

                </a>


                <!-- Profile -->

                <a href="<%= context %>/customer-profile">

                    Profile

                </a>


                <!-- Logout -->

                <a href="<%= context %>/logout"
                   class="btn btn-danger">

                    Logout

                </a>

            </div>

        </div>

    </nav>


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main class="dashboard-container">


        <!-- =================================================
             WELCOME CARD
             ================================================= -->

        <section class="card">

            <h2>
                Welcome, <%= customerName %>! 👋
            </h2>

            <p>
                Welcome to your Vehicle Rental customer portal.
                Browse vehicles, manage your bookings, view rental
                history and manage your profile from one place.
            </p>

        </section>


        <!-- =================================================
             DASHBOARD TITLE
             ================================================= -->

        <div class="page-header">

            <h1>
                Customer Dashboard
            </h1>

            <p>
                Manage your vehicle rentals and account
                from the options below.
            </p>

        </div>


        <!-- =================================================
             DASHBOARD CARDS
             ================================================= -->

        <section class="dashboard-grid">


            <!-- =================================================
                 BROWSE VEHICLES
                 ================================================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    🚘
                </div>

                <h3>
                    Browse Vehicles
                </h3>

                <p>
                    Explore available vehicles, view categories,
                    compare rental prices and check availability.
                </p>

                <a href="<%= context %>/vehicles"
                   class="btn btn-primary">

                    Browse Vehicles →

                </a>

            </div>


            <!-- =================================================
                 MY BOOKINGS
                 ================================================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    📅
                </div>

                <h3>
                    My Bookings
                </h3>

                <p>
                    View your current and previous bookings
                    and check the status of your rentals.
                </p>

                <a href="<%= context %>/my-bookings"
                   class="btn btn-primary">

                    View Bookings →

                </a>

            </div>


            <!-- =================================================
                 RENTAL HISTORY
                 ================================================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    📋
                </div>

                <h3>
                    Rental History
                </h3>

                <p>
                    Review your completed rentals and
                    previous vehicle rental activities.
                </p>

                <a href="<%= context %>/rental-history"
                   class="btn btn-primary">

                    View History →

                </a>

            </div>


            <!-- =================================================
                 RETURN HISTORY
                 ================================================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    🔄
                </div>

                <h3>
                    Return History
                </h3>

                <p>
                    View your completed vehicle returns,
                    return dates, late days and recorded charges.
                </p>

                <a href="<%= context %>/return-history"
                   class="btn btn-primary">

                    View Returns →

                </a>

            </div>


            <!-- =================================================
                 MY PROFILE
                 ================================================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    👤
                </div>

                <h3>
                    My Profile
                </h3>

                <p>
                    View and manage your customer information,
                    including your name, phone number and address.
                </p>

                <a href="<%= context %>/customer-profile"
                   class="btn btn-primary">

                    View Profile →

                </a>

            </div>


        </section>


        <!-- =================================================
             FOOTER
             ================================================= -->

        <footer class="footer">

            <p>
                <strong>
                    Vehicle Rental Management System
                </strong>
            </p>

            <p>
                © 2026 Vehicle Rental System.
                All rights reserved.
            </p>

        </footer>


    </main>

</body>

</html>