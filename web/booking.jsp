<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String vehicleId = (String) request.getAttribute("vehicleId");

    if (vehicleId == null) {
        vehicleId = request.getParameter("vehicleId");
    }

    String error = (String) request.getAttribute("error");
    String contextPath = request.getContextPath();

    LocalDate today = LocalDate.now();
    LocalDate tomorrow = today.plusDays(1);

    String todayValue = today.toString();
    String tomorrowValue = tomorrow.toString();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Book Vehicle | Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        .booking-page {
            width: min(900px, 94%);
            margin: 0 auto;
            padding: 45px 0 70px;
        }

        .booking-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .booking-icon {
            width: 75px;
            height: 75px;
            margin: 0 auto 18px;
            border-radius: 20px;
            background: #eaf2ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
        }

        .booking-header h1 {
            margin: 0 0 10px;
            color: #102a43;
            font-size: 40px !important;
            font-weight: 800;
        }

        .booking-header p {
            margin: 0 auto;
            max-width: 650px;
            color: #627d98;
            font-size: 17px !important;
            line-height: 1.7;
        }

        .booking-card {
            background: #ffffff;
            border: 1px solid #d9e2ec;
            border-radius: 20px;
            padding: 42px;
            box-shadow: 0 10px 30px rgba(16, 42, 67, 0.09);
        }

        .card-heading {
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e1e8f0;
        }

        .card-heading h2 {
            margin: 0 0 7px;
            color: #102a43;
            font-size: 25px;
        }

        .card-heading p {
            margin: 0;
            color: #829ab1;
            font-size: 14px;
        }

        .error-box {
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #9f1239;
            border-radius: 12px;
            padding: 16px 18px;
            margin-bottom: 25px;
            font-size: 14px;
            line-height: 1.6;
        }

        .error-box a {
            color: #be123c;
            font-weight: 700;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 9px;
            color: #243b53;
            font-size: 15px;
            font-weight: 700;
        }

        .form-group input {
            width: 100%;
            height: 56px;
            padding: 0 16px;
            border: 1px solid #bcccdc;
            border-radius: 10px;
            background: #ffffff;
            color: #243b53;
            font-size: 16px;
            outline: none;
            transition: 0.2s ease;
        }

        .form-group input:focus {
            border-color: #175cd3;
            box-shadow: 0 0 0 3px rgba(23, 92, 211, 0.10);
        }

        .date-icon {
            font-size: 13px;
            color: #829ab1;
            margin-top: 8px;
            line-height: 1.5;
        }

        .booking-summary {
            margin-top: 30px;
            padding: 20px;
            background: #f7faff;
            border: 1px solid #dbe7f5;
            border-radius: 13px;
        }

        .booking-summary h3 {
            margin: 0 0 8px;
            color: #102a43;
            font-size: 17px;
        }

        .booking-summary p {
            margin: 0;
            color: #627d98;
            font-size: 14px;
            line-height: 1.6;
        }

        .confirm-btn {
            width: 100%;
            height: 56px;
            margin-top: 28px;
            border: none;
            border-radius: 11px;
            background: #175cd3;
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .confirm-btn:hover {
            background: #1249ad;
            transform: translateY(-1px);
            box-shadow: 0 7px 18px rgba(23, 92, 211, 0.20);
        }

        .back-section {
            text-align: center;
            margin-top: 22px;
        }

        .back-link {
            color: #175cd3;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .invalid-state {
            text-align: center;
            padding: 15px 0;
        }

        .invalid-icon {
            font-size: 45px;
            margin-bottom: 12px;
        }

        .invalid-state h3 {
            color: #102a43;
            margin: 0 0 8px;
        }

        .invalid-state p {
            color: #627d98;
            line-height: 1.6;
        }

        .browse-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-top: 12px;
            padding: 12px 20px;
            background: #175cd3;
            color: #ffffff;
            text-decoration: none;
            border-radius: 9px;
            font-weight: 600;
        }

        @media (max-width: 700px) {

            .booking-page {
                width: 92%;
                padding-top: 30px;
            }

            .booking-header h1 {
                font-size: 32px !important;
            }

            .booking-header p {
                font-size: 15px !important;
            }

            .booking-card {
                padding: 28px 22px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

        }

        @media (max-width: 450px) {

            .booking-header h1 {
                font-size: 28px !important;
            }

            .booking-card {
                padding: 24px 18px;
            }

            .booking-icon {
                width: 65px;
                height: 65px;
                font-size: 32px;
            }

        }

    </style>
</head>


<body>

<!-- Customer Navigation -->
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

        <a href="<%= contextPath %>/customer-profile">
            Profile
        </a>

        <a href="<%= contextPath %>/logout"
           class="logout-link">
            Logout
        </a>

    </div>

</nav>


<main class="booking-page">

    <!-- Header -->

    <section class="booking-header">

        <div class="booking-icon">
            🚘
        </div>

        <h1>Book Your Vehicle</h1>

        <p>
            Select your pickup and return dates to reserve
            your vehicle for your journey.
        </p>

    </section>


    <!-- Booking Card -->

    <section class="booking-card">

        <div class="card-heading">

            <h2>Rental Details</h2>

            <p>
                Choose the dates for your vehicle rental.
            </p>

        </div>


        <% if (error != null) { %>

            <div class="error-box">
                <strong>Booking Error:</strong>
                <%= error %>
            </div>

        <% } %>


        <% if (vehicleId == null || !vehicleId.matches("\\d+")) { %>

            <div class="invalid-state">

                <div class="invalid-icon">
                    ⚠️
                </div>

                <h3>No Valid Vehicle Selected</h3>

                <p>
                    Please return to the vehicle listing and select
                    a vehicle before continuing with your booking.
                </p>

                <a href="<%= contextPath %>/vehicles"
                   class="browse-btn">
                    Browse Vehicles
                </a>

            </div>


        <% } else { %>


            <form action="<%= contextPath %>/book-vehicle"
                  method="post">

                <input type="hidden"
                       name="vehicleId"
                       value="<%= vehicleId %>">


                <div class="form-grid">

                    <!-- Pickup Date -->

                    <div class="form-group">

                        <label for="startDate">
                            📅 Pickup Date
                        </label>

                        <input
                            type="date"
                            id="startDate"
                            name="startDate"
                            min="<%= todayValue %>"
                            value="<%= todayValue %>"
                            required>

                        <div class="date-icon">
                            Select the date when you will collect
                            the vehicle.
                        </div>

                    </div>


                    <!-- Return Date -->

                    <div class="form-group">

                        <label for="endDate">
                            📅 Return Date
                        </label>

                        <input
                            type="date"
                            id="endDate"
                            name="endDate"
                            min="<%= tomorrowValue %>"
                            value="<%= tomorrowValue %>"
                            required>

                        <div class="date-icon">
                            Return date must be after the pickup date.
                        </div>

                    </div>

                </div>


                <!-- Booking Information -->

                <div class="booking-summary">

                    <h3>
                        ℹ️ Booking Information
                    </h3>

                    <p>
                        Your rental amount will be calculated based
                        on the vehicle's daily rental rate and the
                        number of rental days. The vehicle will only
                        be reserved if it is available for the
                        selected dates.
                    </p>

                </div>


                <button type="submit"
                        class="confirm-btn">

                    Confirm Booking →

                </button>

            </form>


            <div class="back-section">

                <a href="<%= contextPath %>/vehicles"
                   class="back-link">

                    ← Back to Vehicles

                </a>

            </div>


        <% } %>

    </section>

</main>


<footer class="footer">

    <p>
        © 2026 Vehicle Rental Management System.
        All rights reserved.
    </p>

</footer>


<script>

    const startDate =
        document.getElementById("startDate");

    const endDate =
        document.getElementById("endDate");


    if (startDate && endDate) {

        function updateReturnMinimum() {

            if (!startDate.value) {
                return;
            }

            const nextDay =
                new Date(startDate.value + "T00:00:00");

            nextDay.setDate(
                nextDay.getDate() + 1
            );

            const minDate =
                nextDay.getFullYear() + "-" +
                String(
                    nextDay.getMonth() + 1
                ).padStart(2, "0") + "-" +
                String(
                    nextDay.getDate()
                ).padStart(2, "0");

            endDate.min = minDate;

            if (
                endDate.value &&
                endDate.value < minDate
            ) {
                endDate.value = minDate;
            }
        }


        startDate.addEventListener(
            "change",
            updateReturnMinimum
        );

    }

</script>


</body>
</html>