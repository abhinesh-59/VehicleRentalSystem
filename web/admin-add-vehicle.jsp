<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.vehiclerental.util.DBConnection"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    String result = request.getParameter("result");
    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add Vehicle | Admin</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">

    <style>

        /* =====================================================
           ADD VEHICLE PAGE - LARGE PROFESSIONAL UI
           ===================================================== */

        .add-vehicle-page {
            width: min(1200px, 94%) !important;
            margin: 0 auto !important;
            padding: 50px 0 80px !important;
        }


        /* =====================================================
           NAVBAR
           ===================================================== */

        .add-vehicle-navbar {
            background: #102a43 !important;
            min-height: 72px !important;
        }

        .add-vehicle-navbar .navbar-inner {
            width: min(1280px, 94%) !important;
            margin: 0 auto !important;
        }

        .add-vehicle-navbar .logo {
            font-size: 22px !important;
            font-weight: 800 !important;
        }

        .add-vehicle-navbar .nav-links a {
            font-size: 15px !important;
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .back-dashboard {
            display: inline-block !important;

            color: #2563eb !important;
            text-decoration: none !important;

            font-size: 17px !important;
            font-weight: 700 !important;

            margin-bottom: 30px !important;
        }

        .back-dashboard:hover {
            text-decoration: underline !important;
        }


        /* =====================================================
           PAGE TITLE
           ===================================================== */

        .add-page-header {
            margin-bottom: 35px !important;
        }

        .add-page-header h1 {
            margin: 0 0 12px !important;

            color: #102a43 !important;

            font-size: 40px !important;
            line-height: 1.2 !important;

            font-weight: 800 !important;
        }

        .add-page-header p {
            margin: 0 !important;

            color: #627d98 !important;

            font-size: 18px !important;
            line-height: 1.7 !important;
        }


        /* =====================================================
           MAIN FORM CARD
           ===================================================== */

        .add-vehicle-panel {
            background: #ffffff !important;

            border: 1px solid #d9e2ec !important;

            border-radius: 22px !important;

            padding: 45px !important;

            box-shadow:
                0 12px 35px rgba(16, 42, 67, 0.10) !important;
        }


        /* =====================================================
           FORM HEADER
           ===================================================== */

        .form-panel-heading {
            display: flex !important;
            align-items: center !important;

            gap: 20px !important;

            margin-bottom: 35px !important;
            padding-bottom: 28px !important;

            border-bottom: 1px solid #d9e2ec !important;
        }

        .form-heading-icon {
            width: 70px !important;
            height: 70px !important;

            display: flex !important;
            align-items: center !important;
            justify-content: center !important;

            background: #eef4ff !important;

            border-radius: 17px !important;

            font-size: 36px !important;

            flex-shrink: 0 !important;
        }

        .form-panel-heading h2 {
            margin: 0 0 8px !important;

            color: #102a43 !important;

            font-size: 30px !important;
            line-height: 1.3 !important;

            font-weight: 800 !important;
        }

        .form-panel-heading p {
            margin: 0 !important;

            color: #627d98 !important;

            font-size: 17px !important;
        }


        /* =====================================================
           MESSAGES
           ===================================================== */

        .message {
            padding: 18px 20px !important;

            margin-bottom: 30px !important;

            border-radius: 12px !important;

            font-size: 16px !important;

            font-weight: 600 !important;
        }

        .success {
            background: #ecfdf3 !important;
            color: #166534 !important;

            border: 1px solid #bbf7d0 !important;
        }

        .error {
            background: #fff1f2 !important;
            color: #991b1b !important;

            border: 1px solid #fecdd3 !important;
        }


        /* =====================================================
           FORM GRID
           ===================================================== */

        .vehicle-form {
            width: 100% !important;
        }

        .form-grid {
            display: grid !important;

            grid-template-columns:
                repeat(2, minmax(0, 1fr)) !important;

            gap: 30px 32px !important;
        }

        .field {
            display: flex !important;
            flex-direction: column !important;

            gap: 10px !important;
        }

        .field.full {
            grid-column: 1 / -1 !important;
        }


        /* =====================================================
           LABELS
           ===================================================== */

        .field label {
            color: #243b53 !important;

            font-size: 17px !important;

            font-weight: 700 !important;

            line-height: 1.4 !important;
        }

        .required {
            color: #dc2626 !important;

            font-size: 17px !important;
        }


        /* =====================================================
           INPUTS + SELECTS
           ===================================================== */

        .field input,
        .field select {

            width: 100% !important;

            height: 58px !important;
            min-height: 58px !important;

            padding: 14px 17px !important;

            border: 1px solid #bcccdc !important;

            border-radius: 11px !important;

            background: #ffffff !important;

            color: #243b53 !important;

            font-family: Arial, sans-serif !important;

            font-size: 17px !important;

            line-height: 1.4 !important;

            outline: none !important;

            box-shadow: none !important;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease !important;
        }

        .field input::placeholder {
            color: #9fb3c8 !important;

            font-size: 16px !important;
        }

        .field input:focus,
        .field select:focus {

            border-color: #2563eb !important;

            box-shadow:
                0 0 0 4px rgba(37, 99, 235, 0.12) !important;
        }


        /* =====================================================
           HELP TEXT
           ===================================================== */

        .field-help {
            color: #829ab1 !important;

            font-size: 14px !important;

            line-height: 1.5 !important;

            margin-top: 0 !important;
        }


        /* =====================================================
           ACTION BUTTONS
           ===================================================== */

        .form-actions {

            display: flex !important;
            align-items: center !important;

            gap: 16px !important;

            margin-top: 42px !important;

            padding-top: 30px !important;

            border-top: 1px solid #d9e2ec !important;
        }

        .submit-button,
        .clear-button {

            min-height: 56px !important;

            padding: 14px 30px !important;

            border: none !important;

            border-radius: 11px !important;

            font-family: Arial, sans-serif !important;

            font-size: 16px !important;

            font-weight: 700 !important;

            cursor: pointer !important;

            transition: all 0.2s ease !important;
        }

        .submit-button {

            background: #2563eb !important;

            color: #ffffff !important;

            box-shadow:
                0 6px 18px rgba(37, 99, 235, 0.22) !important;
        }

        .submit-button:hover {

            background: #1d4ed8 !important;

            transform: translateY(-2px) !important;

            box-shadow:
                0 9px 22px rgba(37, 99, 235, 0.28) !important;
        }

        .clear-button {

            background: #e2e8f0 !important;

            color: #334e68 !important;
        }

        .clear-button:hover {

            background: #cbd5e1 !important;

            transform: translateY(-1px) !important;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .add-vehicle-footer {

            text-align: center !important;

            color: #829ab1 !important;

            font-size: 15px !important;

            margin-top: 50px !important;

            padding-top: 28px !important;

            border-top: 1px solid #d9e2ec !important;
        }

        .add-vehicle-footer strong {
            color: #486581 !important;
        }


        /* =====================================================
           MOBILE
           ===================================================== */

        @media (max-width: 700px) {

            .add-vehicle-page {
                width: 92% !important;

                padding-top: 30px !important;
            }

            .add-page-header h1 {
                font-size: 32px !important;
            }

            .add-page-header p {
                font-size: 16px !important;
            }

            .add-vehicle-panel {
                padding: 28px 22px !important;
            }

            .form-grid {
                grid-template-columns: 1fr !important;
            }

            .field.full {
                grid-column: auto !important;
            }

            .form-panel-heading h2 {
                font-size: 25px !important;
            }

            .form-actions {
                flex-direction: column !important;

                align-items: stretch !important;
            }

            .submit-button,
            .clear-button {
                width: 100% !important;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVIGATION
     ===================================================== -->

<nav class="navbar add-vehicle-navbar">

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
     MAIN PAGE
     ===================================================== -->

<main class="add-vehicle-page">


    <!-- BACK LINK -->

    <a class="back-dashboard"
       href="<%= context %>/admin-vehicles">

        ← Back to Vehicle Management

    </a>


    <!-- PAGE TITLE -->

    <section class="add-page-header">

        <h1>
            Add New Vehicle
        </h1>

        <p>
            Register a new vehicle and add it to your rental fleet.
        </p>

    </section>


    <!-- =================================================
         FORM CARD
         ================================================= -->

    <section class="add-vehicle-panel">


        <!-- FORM HEADER -->

        <div class="form-panel-heading">

            <div class="form-heading-icon">
                🚘
            </div>

            <div>

                <h2>
                    Vehicle Information
                </h2>

                <p>
                    Enter the details of the vehicle below.
                </p>

            </div>

        </div>


        <!-- =================================================
             RESULT MESSAGE
             ================================================= -->

        <% if ("success".equals(result)) { %>

            <div class="message success">

                ✓ Vehicle added successfully!

            </div>

        <% } else if ("duplicate".equals(result)) { %>

            <div class="message error">

                ✕ That vehicle number already exists.
                Please enter a unique registration number.

            </div>

        <% } else if ("invalid".equals(result)) { %>

            <div class="message error">

                ✕ Please check your inputs and enter valid values.

            </div>

        <% } else if ("failed".equals(result)) { %>

            <div class="message error">

                ✕ The vehicle could not be added.

            </div>

        <% } %>


        <!-- =================================================
             VEHICLE FORM
             ================================================= -->

        <form class="vehicle-form"
              action="<%= context %>/admin-add-vehicle"
              method="post">


            <div class="form-grid">


                <!-- REGISTRATION NUMBER -->

                <div class="field">

                    <label for="vehicleNumber">

                        Vehicle Registration Number
                        <span class="required">*</span>

                    </label>

                    <input type="text"
                           id="vehicleNumber"
                           name="vehicleNumber"
                           maxlength="20"
                           placeholder="e.g. TS09AB1234"
                           required>

                    <span class="field-help">

                        Enter a unique vehicle registration number.

                    </span>

                </div>


                <!-- CATEGORY -->

                <div class="field">

                    <label for="categoryId">

                        Vehicle Category
                        <span class="required">*</span>

                    </label>

                    <select id="categoryId"
                            name="categoryId"
                            required>

                        <option value="">
                            Select category
                        </option>

                        <%
                            String sql =
                                "SELECT category_id, category_name, daily_rate "
                                + "FROM vehicle_categories "
                                + "ORDER BY category_name";

                            try (
                                Connection con =
                                    DBConnection.getConnection();

                                PreparedStatement ps =
                                    con.prepareStatement(sql);

                                ResultSet rs =
                                    ps.executeQuery()
                            ) {

                                while (rs.next()) {
                        %>

                            <option value="<%= rs.getInt("category_id") %>">

                                <%= rs.getString("category_name") %>
                                -
                                ₹<%= rs.getBigDecimal("daily_rate") %>/day

                            </option>

                        <%
                                }

                            } catch (Exception e) {
                        %>

                            <option value="" disabled>

                                Unable to load categories

                            </option>

                        <%
                            }
                        %>

                    </select>

                </div>


                <!-- BRAND -->

                <div class="field">

                    <label for="brand">

                        Brand
                        <span class="required">*</span>

                    </label>

                    <input type="text"
                           id="brand"
                           name="brand"
                           maxlength="50"
                           placeholder="e.g. Toyota"
                           required>

                </div>


                <!-- MODEL -->

                <div class="field">

                    <label for="model">

                        Model
                        <span class="required">*</span>

                    </label>

                    <input type="text"
                           id="model"
                           name="model"
                           maxlength="50"
                           placeholder="e.g. Fortuner"
                           required>

                </div>


                <!-- YEAR -->

                <div class="field">

                    <label for="year">

                        Manufacturing Year

                    </label>

                    <input type="number"
                           id="year"
                           name="year"
                           min="1900"
                           max="2100"
                           placeholder="e.g. 2024">

                </div>


                <!-- COLOR -->

                <div class="field">

                    <label for="color">

                        Color

                    </label>

                    <input type="text"
                           id="color"
                           name="color"
                           maxlength="30"
                           placeholder="e.g. White">

                </div>


                <!-- SEATING CAPACITY -->

                <div class="field">

                    <label for="seatingCapacity">

                        Seating Capacity

                    </label>

                    <input type="number"
                           id="seatingCapacity"
                           name="seatingCapacity"
                           min="1"
                           placeholder="e.g. 5">

                </div>


                <!-- FUEL TYPE -->

                <div class="field">

                    <label for="fuelType">

                        Fuel Type

                    </label>

                    <select id="fuelType"
                            name="fuelType">

                        <option value="">
                            Select fuel type
                        </option>

                        <option value="Petrol">
                            Petrol
                        </option>

                        <option value="Diesel">
                            Diesel
                        </option>

                        <option value="Electric">
                            Electric
                        </option>

                        <option value="Hybrid">
                            Hybrid
                        </option>

                        <option value="CNG">
                            CNG
                        </option>

                    </select>

                </div>


                <!-- TRANSMISSION -->

                <div class="field full">

                    <label for="transmission">

                        Transmission

                    </label>

                    <select id="transmission"
                            name="transmission">

                        <option value="">
                            Select transmission
                        </option>

                        <option value="Manual">
                            Manual
                        </option>

                        <option value="Automatic">
                            Automatic
                        </option>

                    </select>

                </div>


            </div>


            <!-- =================================================
                 BUTTONS
                 ================================================= -->

            <div class="form-actions">

                <button type="submit"
                        class="submit-button">

                    ✓ Add Vehicle

                </button>

                <button type="reset"
                        class="clear-button">

                    Clear Form

                </button>

            </div>


        </form>

    </section>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <footer class="add-vehicle-footer">

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