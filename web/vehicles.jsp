<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.Vehicle"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>

<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<Vehicle> vehicles =
        (List<Vehicle>) request.getAttribute("vehicles");

    String keyword = (String) request.getAttribute("keyword");

    String selectedCategory =
        (String) request.getAttribute("selectedCategory");

    if (keyword == null) {
        keyword = "";
    }

    if (selectedCategory == null) {
        selectedCategory = "";
    }

    NumberFormat currency =
        NumberFormat.getCurrencyInstance(new Locale("en", "IN"));

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Browse Vehicles | Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">

    <style>

        .vehicles-page {
            width: min(1280px, 94%);
            margin: 0 auto;
            padding: 45px 0 70px;
        }

        /* Page Header */

        .vehicles-header {
            margin-bottom: 30px;
        }

        .vehicles-header h1 {
            margin: 0 0 10px;
            font-size: 40px !important;
            color: #102a43;
            font-weight: 800;
        }

        .vehicles-header p {
            margin: 0;
            color: #627d98;
            font-size: 17px !important;
            line-height: 1.7;
        }

        /* Search Panel */

        .search-panel {
            background: #ffffff;
            border: 1px solid #d9e2ec;
            border-radius: 18px;
            padding: 25px;
            margin-bottom: 32px;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
        }

        .search-title {
            margin: 0 0 18px;
            color: #102a43;
            font-size: 20px;
            font-weight: 700;
        }

        .search-form {
            display: grid;
            grid-template-columns: 1fr 220px auto auto;
            gap: 14px;
            align-items: center;
        }

        .search-form input,
        .search-form select {
            width: 100%;
            height: 52px;
            padding: 0 16px;
            border: 1px solid #bcccdc;
            border-radius: 10px;
            background: #ffffff;
            color: #243b53;
            font-size: 15px;
            outline: none;
            transition: 0.2s ease;
        }

        .search-form input:focus,
        .search-form select:focus {
            border-color: #175cd3;
            box-shadow: 0 0 0 3px rgba(23, 92, 211, 0.10);
        }

        .search-btn {
            height: 52px;
            padding: 0 22px;
            border: none;
            border-radius: 10px;
            background: #175cd3;
            color: white;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s ease;
            white-space: nowrap;
        }

        .search-btn:hover {
            background: #1249ad;
            transform: translateY(-1px);
        }

        .clear-btn {
            height: 52px;
            padding: 0 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            border: 1px solid #bcccdc;
            color: #334e68;
            background: #ffffff;
            text-decoration: none;
            font-size: 15px;
            font-weight: 600;
            white-space: nowrap;
            transition: 0.2s ease;
        }

        .clear-btn:hover {
            background: #f0f4f8;
        }

        /* Results */

        .results-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 22px;
        }

        .results-bar h2 {
            margin: 0;
            color: #102a43;
            font-size: 23px;
        }

        .results-count {
            color: #627d98;
            font-size: 14px;
        }

        /* Vehicle Grid */

        .vehicle-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .vehicle-card {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 26px;
            box-shadow: 0 7px 22px rgba(16, 42, 67, 0.08);
            transition: all 0.25s ease;
            display: flex;
            flex-direction: column;
            min-height: 500px;
        }

        .vehicle-card:hover {
            transform: translateY(-7px);
            box-shadow: 0 16px 35px rgba(16, 42, 67, 0.14);
            border-color: #cbdaf0;
        }

        .vehicle-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 15px;
        }

        .vehicle-icon {
            width: 65px;
            height: 65px;
            border-radius: 16px;
            background: #eef4ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
        }

        .availability-badge {
            padding: 7px 11px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
            white-space: nowrap;
        }

        .available-badge {
            background: #dcfce7;
            color: #166534;
        }

        .unavailable-badge {
            background: #fee2e2;
            color: #991b1b;
        }

        .vehicle-card h3 {
            margin: 5px 0 8px;
            color: #102a43;
            font-size: 21px;
            line-height: 1.35;
        }

        .category-badge {
            display: inline-block;
            width: fit-content;
            padding: 6px 11px;
            border-radius: 20px;
            background: #e8f1ff;
            color: #175cd3;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 18px;
        }

        .vehicle-details {
            background: #f8fafc;
            border-radius: 12px;
            padding: 15px;
            color: #486581;
            font-size: 14px;
            line-height: 1.9;
            margin-bottom: 20px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            border-bottom: 1px solid #e5eaf0;
            padding: 5px 0;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #829ab1;
        }

        .detail-value {
            color: #334e68;
            font-weight: 600;
            text-align: right;
        }

        .vehicle-footer {
            margin-top: auto;
        }

        .price-section {
            margin-bottom: 16px;
        }

        .price {
            color: #087443;
            font-size: 27px;
            font-weight: 800;
        }

        .price-label {
            color: #829ab1;
            font-size: 12px;
            margin-left: 4px;
        }

        .book-btn {
            width: 100%;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #175cd3;
            color: #ffffff;
            text-decoration: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            transition: 0.2s ease;
        }

        .book-btn:hover {
            background: #1249ad;
            transform: translateY(-1px);
        }

        .unavailable-btn {
            width: 100%;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f0f4f8;
            color: #829ab1;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
        }

        /* Empty State */

        .empty-state {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 65px 25px;
            text-align: center;
            box-shadow: 0 7px 22px rgba(16, 42, 67, 0.06);
        }

        .empty-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            margin: 0 0 8px;
            color: #243b53;
            font-size: 22px;
        }

        .empty-state p {
            margin: 0 0 20px;
            color: #829ab1;
        }

        .show-all-btn {
            display: inline-flex;
            padding: 11px 18px;
            background: #175cd3;
            color: #ffffff;
            border-radius: 9px;
            text-decoration: none;
            font-weight: 600;
        }

        .show-all-btn:hover {
            background: #1249ad;
        }

        /* Error State */

        .error-state {
            background: #fff7ed;
            border: 1px solid #fed7aa;
            border-radius: 14px;
            padding: 20px;
            color: #9a3412;
            line-height: 1.6;
        }

        /* Responsive */

        @media (max-width: 1100px) {

            .search-form {
                grid-template-columns: 1fr 1fr;
            }

            .vehicle-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            .vehicles-page {
                width: 92%;
                padding-top: 30px;
            }

            .vehicles-header h1 {
                font-size: 32px !important;
            }

            .vehicles-header p {
                font-size: 15px !important;
            }

            .search-form {
                grid-template-columns: 1fr;
            }

            .vehicle-grid {
                grid-template-columns: 1fr;
            }

            .results-bar {
                align-items: flex-start;
                flex-direction: column;
            }

            .navbar-links {
                gap: 10px;
            }

        }

        @media (max-width: 450px) {

            .vehicle-card {
                padding: 21px;
            }

            .vehicle-card h3 {
                font-size: 19px;
            }

            .price {
                font-size: 24px;
            }

        }

    </style>

</head>


<body>


<!-- ================= CUSTOMER NAVIGATION ================= -->

<nav class="navbar">

    <div class="navbar-brand">
        🚗 VehicleRental
    </div>

    <div class="navbar-links">

        <a href="<%= contextPath %>/dashboard.jsp">
            Dashboard
        </a>

        <a href="<%= contextPath %>/vehicles"
           class="active">
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

        <a href="<%= contextPath %>/logout"
           class="logout-link">
            Logout
        </a>

    </div>

</nav>


<!-- ================= MAIN CONTENT ================= -->

<main class="vehicles-page">


    <!-- ================= PAGE HEADER ================= -->

    <section class="vehicles-header">

        <h1>
            Browse Vehicles
        </h1>

        <p>
            Explore our available vehicles and choose the perfect
            option for your next journey.
        </p>

    </section>


    <!-- ================= SEARCH ================= -->

    <section class="search-panel">

        <h2 class="search-title">
            🔎 Find Your Vehicle
        </h2>

        <form method="get"
              action="<%= contextPath %>/vehicles"
              class="search-form">

            <input
                type="text"
                name="keyword"
                maxlength="100"
                placeholder="Search by brand or model..."
                value="<%= escapeHtml(keyword) %>">

            <select name="category">

                <option value="">
                    All Categories
                </option>

                <option value="Hatchback"
                    <%= "Hatchback".equals(selectedCategory)
                        ? "selected" : "" %>>
                    Hatchback
                </option>

                <option value="Sedan"
                    <%= "Sedan".equals(selectedCategory)
                        ? "selected" : "" %>>
                    Sedan
                </option>

                <option value="SUV"
                    <%= "SUV".equals(selectedCategory)
                        ? "selected" : "" %>>
                    SUV
                </option>

                <option value="Luxury"
                    <%= "Luxury".equals(selectedCategory)
                        ? "selected" : "" %>>
                    Luxury
                </option>

                <option value="Bike"
                    <%= "Bike".equals(selectedCategory)
                        ? "selected" : "" %>>
                    Bike
                </option>

            </select>

            <button type="submit"
                    class="search-btn">
                Search Vehicles
            </button>

            <a href="<%= contextPath %>/vehicles"
               class="clear-btn">
                Clear
            </a>

        </form>

    </section>


    <!-- ================= VEHICLE RESULTS ================= -->

    <% if (vehicles == null) { %>

        <div class="error-state">

            <strong>
                Vehicles were not loaded.
            </strong>

            <br>

            Please open this page through the
            <strong>Browse Vehicles</strong>
            option on your dashboard.

        </div>


    <% } else if (vehicles.isEmpty()) { %>


        <!-- ================= EMPTY STATE ================= -->

        <div class="empty-state">

            <div class="empty-icon">
                🚗
            </div>

            <h3>
                No Vehicles Found
            </h3>

            <p>
                We couldn't find any vehicles matching your search.
                Try another keyword or category.
            </p>

            <a href="<%= contextPath %>/vehicles"
               class="show-all-btn">

                Show All Vehicles

            </a>

        </div>


    <% } else { %>


        <!-- ================= RESULTS HEADER ================= -->

        <div class="results-bar">

            <h2>
                Available Vehicles
            </h2>

            <div class="results-count">

                Showing
                <strong>
                    <%= vehicles.size() %>
                </strong>
                vehicle(s)

            </div>

        </div>


        <!-- ================= VEHICLE CARDS ================= -->

        <section class="vehicle-grid">


            <% for (Vehicle vehicle : vehicles) { %>

                <article class="vehicle-card">


                    <!-- Vehicle Icon / Status -->

                    <div class="vehicle-top">

                        <div class="vehicle-icon">

                            <% if ("Bike".equalsIgnoreCase(
                                    vehicle.getCategoryName())) { %>

                                🏍️

                            <% } else if ("SUV".equalsIgnoreCase(
                                    vehicle.getCategoryName())) { %>

                                🚙

                            <% } else if ("Luxury".equalsIgnoreCase(
                                    vehicle.getCategoryName())) { %>

                                🚘

                            <% } else { %>

                                🚗

                            <% } %>

                        </div>


                        <% if ("AVAILABLE".equalsIgnoreCase(
                                vehicle.getStatus())) { %>

                            <span class="availability-badge available-badge">
                                ● Available
                            </span>

                        <% } else { %>

                            <span class="availability-badge unavailable-badge">

                                ● <%= escapeHtml(
                                    vehicle.getStatus() == null
                                    ? "Unavailable"
                                    : vehicle.getStatus()) %>

                            </span>

                        <% } %>

                    </div>


                    <!-- Vehicle Name -->

                    <h3>

                        <%= escapeHtml(vehicle.getBrand()) %>

                        <%= escapeHtml(vehicle.getModel()) %>

                    </h3>


                    <!-- Category -->

                    <span class="category-badge">

                        <%= escapeHtml(
                            vehicle.getCategoryName()) %>

                    </span>


                    <!-- Vehicle Details -->

                    <div class="vehicle-details">


                        <div class="detail-row">

                            <span class="detail-label">
                                Registration
                            </span>

                            <span class="detail-value">

                                <%= escapeHtml(
                                    vehicle.getVehicleNumber()) %>

                            </span>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Year
                            </span>

                            <span class="detail-value">

                                <%= vehicle.getYear() %>

                            </span>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Color
                            </span>

                            <span class="detail-value">

                                <%= escapeHtml(
                                    vehicle.getColor() == null
                                    ? "Not specified"
                                    : vehicle.getColor()) %>

                            </span>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Seating
                            </span>

                            <span class="detail-value">

                                <%= vehicle.getSeatingCapacity() %>
                                Seats

                            </span>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Fuel
                            </span>

                            <span class="detail-value">

                                <%= escapeHtml(
                                    vehicle.getFuelType() == null
                                    ? "Not specified"
                                    : vehicle.getFuelType()) %>

                            </span>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Transmission
                            </span>

                            <span class="detail-value">

                                <%= escapeHtml(
                                    vehicle.getTransmission() == null
                                    ? "Not specified"
                                    : vehicle.getTransmission()) %>

                            </span>

                        </div>


                    </div>


                    <!-- Price + Booking -->

                    <div class="vehicle-footer">


                        <div class="price-section">

                            <span class="price">

                                <%= currency.format(
                                    vehicle.getDailyRate()) %>

                            </span>

                            <span class="price-label">
                                / day
                            </span>

                        </div>


                        <% if ("AVAILABLE".equalsIgnoreCase(
                                vehicle.getStatus())) { %>

                            <a class="book-btn"
                               href="<%= contextPath %>/book-vehicle?vehicleId=<%= vehicle.getVehicleId() %>">

                                Book This Vehicle →

                            </a>

                        <% } else { %>

                            <div class="unavailable-btn">

                                Currently Unavailable

                            </div>

                        <% } %>


                    </div>


                </article>

            <% } %>


        </section>


    <% } %>


</main>


<!-- ================= FOOTER ================= -->

<footer class="footer">

    <p>
        © 2026 Vehicle Rental Management System.
        All rights reserved.
    </p>

</footer>


</body>

</html>