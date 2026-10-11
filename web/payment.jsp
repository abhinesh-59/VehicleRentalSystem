<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String rentalId = (String) request.getAttribute("rentalId");

    if (rentalId == null) {
        rentalId = request.getParameter("rentalId");
    }

    String error = (String) request.getAttribute("error");
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Payment - Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        /* =====================================================
           PAYMENT PAGE
           ===================================================== */

        .payment-page {
            width: min(900px, 94%);
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

        .payment-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .payment-icon {
            width: 78px;
            height: 78px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #eaf2ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
        }

        .payment-header h1 {
            margin: 0 0 12px;
            color: #102a43;
            font-size: 42px;
            font-weight: 800;
        }

        .payment-header p {
            margin: 0;
            color: #627d98;
            font-size: 18px;
            line-height: 1.7;
        }


        /* =====================================================
           PAYMENT CARD
           ===================================================== */

        .payment-card {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 42px 48px;
            box-shadow: 0 10px 30px rgba(16, 42, 67, 0.09);
        }


        /* =====================================================
           CARD HEADING
           ===================================================== */

        .payment-card h2 {
            margin: 0 0 8px;
            color: #102a43;
            font-size: 28px;
            font-weight: 800;
        }

        .payment-description {
            margin: 0 0 28px;
            color: #627d98;
            font-size: 16px;
            line-height: 1.6;
        }


        /* =====================================================
           BOOKING INFORMATION
           ===================================================== */

        .booking-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            background: #f5f9ff;
            border: 1px solid #dbeafe;
            border-radius: 12px;
            padding: 18px 20px;
            margin-bottom: 28px;
        }

        .booking-info-label {
            color: #627d98;
            font-size: 15px;
            font-weight: 600;
        }

        .booking-info-id {
            color: #102a43;
            font-size: 19px;
            font-weight: 800;
        }


        /* =====================================================
           ERROR MESSAGE
           ===================================================== */

        .error-message {
            background: #fee2e2;
            border: 1px solid #fecaca;
            color: #991b1b;
            padding: 17px 20px;
            border-radius: 10px;
            margin-bottom: 24px;
            font-size: 16px;
            line-height: 1.6;
        }


        /* =====================================================
           FORM
           ===================================================== */

        .payment-form {
            margin-top: 10px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #243b53;
            font-size: 17px;
            font-weight: 700;
        }

        .payment-select {
            width: 100%;
            height: 56px;
            padding: 0 16px;
            border: 1px solid #bcccdc;
            border-radius: 9px;
            background: #ffffff;
            color: #243b53;
            font-size: 17px;
            outline: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .payment-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }


        /* =====================================================
           DEMO NOTICE
           ===================================================== */

        .demo-notice {
            background: #fff8e6;
            border: 1px solid #f6d98b;
            border-left: 5px solid #f59e0b;
            border-radius: 10px;
            padding: 20px 22px;
            margin: 25px 0;
            color: #7c4a03;
            font-size: 16px;
            line-height: 1.7;
        }

        .demo-notice strong {
            color: #92400e;
            font-size: 17px;
        }


        /* =====================================================
           PAY BUTTON
           ===================================================== */

        .payment-button {
            width: 100%;
            height: 58px;
            border: none;
            border-radius: 9px;
            background: #2563eb;
            color: #ffffff;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 5px 14px rgba(37, 99, 235, 0.20);
        }

        .payment-button:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.25);
        }


        /* =====================================================
           INVALID BOOKING
           ===================================================== */

        .invalid-booking {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
        }

        .invalid-booking p {
            margin: 0;
            color: #475569;
            font-size: 17px;
            line-height: 1.6;
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .back-link-wrapper {
            margin-top: 25px;
            text-align: center;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #2563eb;
            text-decoration: none;
            font-size: 16px;
            font-weight: 700;
            padding: 10px 14px;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .back-link:hover {
            background: #eff6ff;
            color: #1d4ed8;
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
           RESPONSIVE PAYMENT PAGE
           ===================================================== */

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

            .payment-page {
                width: 94%;
                padding-top: 32px;
            }

            .payment-header h1 {
                font-size: 34px;
            }

            .payment-header p {
                font-size: 16px;
            }

            .payment-card {
                padding: 30px 24px;
            }

            .payment-card h2 {
                font-size: 24px;
            }

            .booking-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 7px;
            }

            .form-group label {
                font-size: 16px;
            }

            .payment-select {
                font-size: 16px;
            }

            .demo-notice {
                font-size: 15px;
            }

            .payment-button {
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

        <a href="<%= contextPath %>/my-bookings">
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
     MAIN PAYMENT CONTENT
     ========================================================= -->

<main class="payment-page">


    <!-- PAGE HEADER -->

    <div class="payment-header">

        <div class="payment-icon">
            💳
        </div>

        <h1>
            Make Payment
        </h1>

        <p>
            Complete the payment record for your vehicle booking.
        </p>

    </div>


    <!-- PAYMENT CARD -->

    <div class="payment-card">

        <h2>
            Payment Details
        </h2>

        <p class="payment-description">
            Select your preferred payment method to complete
            the booking payment.
        </p>


        <!-- ERROR MESSAGE -->

        <% if (error != null) { %>

            <div class="error-message">

                ⚠️ <%= error %>

            </div>

        <% } %>


        <!-- VALID RENTAL ID -->

        <% if (rentalId == null || !rentalId.matches("\\d+")) { %>


            <div class="invalid-booking">

                <p>
                    ⚠️ Invalid booking ID.
                    Please return to <strong>My Bookings</strong>
                    and select a valid booking.
                </p>

            </div>


        <% } else { %>


            <!-- BOOKING INFORMATION -->

            <div class="booking-info">

                <span class="booking-info-label">
                    Booking / Rental ID
                </span>

                <span class="booking-info-id">
                    #<%= rentalId %>
                </span>

            </div>


            <!-- PAYMENT FORM -->

            <form method="post"
                  action="<%= contextPath %>/payment"
                  class="payment-form">


                <input type="hidden"
                       name="rentalId"
                       value="<%= rentalId %>">


                <!-- PAYMENT METHOD -->

                <div class="form-group">

                    <label for="paymentMethod">
                        Select Payment Method
                    </label>

                    <select id="paymentMethod"
                            name="paymentMethod"
                            class="payment-select"
                            required>

                        <option value="">
                            -- Choose a payment method --
                        </option>

                        <option value="UPI">
                            UPI
                        </option>

                        <option value="CARD">
                            Card
                        </option>

                        <option value="NET_BANKING">
                            Net Banking
                        </option>

                        <option value="CASH">
                            Cash
                        </option>

                    </select>

                </div>


                <!-- DEMO NOTICE -->

                <div class="demo-notice">

                    <strong>
                        ⚠️ Demo Payment Only
                    </strong>

                    <br>

                    This college project records a simulated
                    payment. No real money will be charged.

                </div>


                <!-- CONFIRM PAYMENT -->

                <button type="submit"
                        class="payment-button">

                    💳 Confirm Simulated Payment

                </button>

            </form>


        <% } %>


        <!-- BACK TO BOOKINGS -->

        <div class="back-link-wrapper">

            <a class="back-link"
               href="<%= contextPath %>/my-bookings">

                ← Back to My Bookings

            </a>

        </div>

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