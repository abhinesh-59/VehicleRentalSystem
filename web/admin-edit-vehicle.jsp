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

    Object vehicleId = request.getAttribute("vehicleId");

    if (vehicleId == null) {
        response.sendRedirect(request.getContextPath() + "/admin-vehicles");
        return;
    }

    Object categoryId = request.getAttribute("categoryId");
    Object year = request.getAttribute("year");
    Object seatingCapacity = request.getAttribute("seatingCapacity");

    String vehicleNumber = (String) request.getAttribute("vehicleNumber");
    String brand = (String) request.getAttribute("brand");
    String model = (String) request.getAttribute("model");
    String color = (String) request.getAttribute("color");
    String fuelType = (String) request.getAttribute("fuelType");
    String transmission = (String) request.getAttribute("transmission");

    String result = request.getParameter("result");

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Vehicle | Admin</title>

    <!-- Shared Professional CSS -->
    <link rel="stylesheet"
          href="<%= context %>/css/style.css">


    <style>

        /* =====================================================
           EDIT VEHICLE PAGE
           ===================================================== */

        .edit-vehicle-page {

            width: min(1200px, 94%) !important;

            margin: 0 auto !important;

            padding: 50px 0 80px !important;
        }


        /* =====================================================
           ADMIN NAVBAR
           ===================================================== */

        .edit-vehicle-navbar {

            background: #102a43 !important;

            min-height: 72px !important;
        }

        .edit-vehicle-navbar .navbar-inner {

            width: min(1280px, 94%) !important;

            margin: 0 auto !important;
        }

        .edit-vehicle-navbar .logo {

            font-size: 22px !important;

            font-weight: 800 !important;
        }

        .edit-vehicle-navbar .logo span {

            color: #60a5fa !important;
        }

        .edit-vehicle-navbar .nav-links a {

            font-size: 15px !important;
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .back-vehicles {

            display: inline-block !important;

            color: #2563eb !important;

            text-decoration: none !important;

            font-size: 17px !important;

            font-weight: 700 !important;

            margin-bottom: 30px !important;
        }

        .back-vehicles:hover {

            text-decoration: underline !important;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .edit-page-header {

            margin-bottom: 35px !important;
        }

        .edit-page-header h1 {

            margin: 0 0 12px !important;

            color: #102a43 !important;

            font-size: 40px !important;

            line-height: 1.2 !important;

            font-weight: 800 !important;
        }

        .edit-page-header p {

            margin: 0 !important;

            color: #627d98 !important;

            font-size: 18px !important;

            line-height: 1.7 !important;
        }


        /* =====================================================
           MAIN CARD
           ===================================================== */

        .edit-vehicle-panel {

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

        .edit-form-heading {

            display: flex !important;

            align-items: center !important;

            gap: 20px !important;

            margin-bottom: 35px !important;

            padding-bottom: 28px !important;

            border-bottom: 1px solid #d9e2ec !important;
        }


        .edit-heading-icon {

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


        .edit-form-heading h2 {

            margin: 0 0 8px !important;

            color: #102a43 !important;

            font-size: 30px !important;

            line-height: 1.3 !important;

            font-weight: 800 !important;
        }


        .edit-form-heading p {

            margin: 0 !important;

            color: #627d98 !important;

            font-size: 17px !important;
        }


        /* =====================================================
           MESSAGES
           ===================================================== */

        .edit-message {

            padding: 18px 20px !important;

            margin-bottom: 30px !important;

            border-radius: 12px !important;

            font-size: 16px !important;

            font-weight: 600 !important;

            background: #fff1f2 !important;

            color: #991b1b !important;

            border: 1px solid #fecdd3 !important;
        }


        /* =====================================================
           FORM
           ===================================================== */

        .edit-vehicle-form {

            width: 100% !important;
        }


        .edit-form-grid {

            display: grid !important;

            grid-template-columns:
                repeat(2, minmax(0, 1fr)) !important;

            gap: 30px 32px !important;
        }


        .edit-field {

            display: flex !important;

            flex-direction: column !important;

            gap: 10px !important;
        }


        .edit-field.full {

            grid-column: 1 / -1 !important;
        }


        /* =====================================================
           LABELS
           ===================================================== */

        .edit-field label {

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
           INPUTS
           ===================================================== */

        .edit-field input,
        .edit-field select {

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


        .edit-field input:focus,
        .edit-field select:focus {

            border-color: #2563eb !important;

            box-shadow:
                0 0 0 4px rgba(37, 99, 235, 0.12) !important;
        }


        .edit-field input::placeholder {

            color: #9fb3c8 !important;

            font-size: 16px !important;
        }


        /* =====================================================
           FORM ACTIONS
           ===================================================== */

        .edit-form-actions {

            display: flex !important;

            align-items: center !important;

            gap: 16px !important;

            margin-top: 42px !important;

            padding-top: 30px !important;

            border-top: 1px solid #d9e2ec !important;
        }


        .save-button,
        .cancel-button {

            min-height: 56px !important;

            padding: 14px 30px !important;

            border: none !important;

            border-radius: 11px !important;

            font-family: Arial, sans-serif !important;

            font-size: 16px !important;

            font-weight: 700 !important;

            cursor: pointer !important;

            text-decoration: none !important;

            display: inline-flex !important;

            align-items: center !important;

            justify-content: center !important;

            transition: all 0.2s ease !important;
        }


        .save-button {

            background: #2563eb !important;

            color: #ffffff !important;

            box-shadow:
                0 6px 18px rgba(37, 99, 235, 0.22) !important;
        }


        .save-button:hover {

            background: #1d4ed8 !important;

            transform: translateY(-2px) !important;

            box-shadow:
                0 9px 22px rgba(37, 99, 235, 0.28) !important;
        }


        .cancel-button {

            background: #e2e8f0 !important;

            color: #334e68 !important;
        }


        .cancel-button:hover {

            background: #cbd5e1 !important;

            transform: translateY(-1px) !important;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .edit-vehicle-footer {

            text-align: center !important;

            color: #829ab1 !important;

            font-size: 15px !important;

            margin-top: 50px !important;

            padding-top: 28px !important;

            border-top: 1px solid #d9e2ec !important;
        }


        .edit-vehicle-footer strong {

            color: #486581 !important;
        }


        /* =====================================================
           MOBILE
           ===================================================== */

        @media (max-width: 700px) {

            .edit-vehicle-page {

                width: 92% !important;

                padding-top: 30px !important;
            }


            .edit-page-header h1 {

                font-size: 32px !important;
            }


            .edit-page-header p {

                font-size: 16px !important;
            }


            .edit-vehicle-panel {

                padding: 28px 22px !important;
            }


            .edit-form-grid {

                grid-template-columns: 1fr !important;
            }


            .edit-field.full {

                grid-column: auto !important;
            }


            .edit-form-heading h2 {

                font-size: 25px !important;
            }


            .edit-form-actions {

                flex-direction: column !important;

                align-items: stretch !important;
            }


            .save-button,
            .cancel-button {

                width: 100% !important;
            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVIGATION
     ===================================================== -->

<nav class="navbar edit-vehicle-navbar">

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

<main class="edit-vehicle-page">


    <!-- BACK -->

    <a class="back-vehicles"
       href="<%= context %>/admin-vehicles">

        ← Back to Vehicle Management

    </a>


    <!-- PAGE HEADER -->

    <section class="edit-page-header">

        <h1>
            Edit Vehicle
        </h1>

        <p>
            Update the details of the selected vehicle.
        </p>

    </section>


    <!-- =================================================
         FORM CARD
         ================================================= -->

    <section class="edit-vehicle-panel">


        <!-- FORM HEADING -->

        <div class="edit-form-heading">

            <div class="edit-heading-icon">
                ✏️
            </div>


            <div>

                <h2>
                    Vehicle Information
                </h2>

                <p>
                    Modify the vehicle details and save your changes.
                </p>

            </div>

        </div>


        <!-- =================================================
             RESULT MESSAGE
             ================================================= -->

        <% if ("invalid".equals(result)) { %>

            <div class="edit-message">

                ✕ Please enter valid vehicle details.

            </div>

        <% } else if ("duplicate".equals(result)) { %>

            <div class="edit-message">

                ✕ That registration number already exists.

            </div>

        <% } %>


        <!-- =================================================
             EDIT FORM
             ================================================= -->

        <form class="edit-vehicle-form"
              action="<%= context %>/admin-edit-vehicle"
              method="post">


            <!-- Hidden Vehicle ID -->

            <input type="hidden"
                   name="vehicleId"
                   value="<%= vehicleId %>">


            <div class="edit-form-grid">


                <!-- REGISTRATION NUMBER -->

                <div class="edit-field">

                    <label for="vehicleNumber">

                        Registration Number
                        <span class="required">*</span>

                    </label>

                    <input type="text"
                           id="vehicleNumber"
                           name="vehicleNumber"
                           value="<%= vehicleNumber == null ? "" : vehicleNumber %>"
                           maxlength="20"
                           required>

                </div>


                <!-- CATEGORY -->

                <div class="edit-field">

                    <label for="categoryId">

                        Category
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

                                    int currentCategory =
                                        rs.getInt("category_id");

                                    boolean selected =
                                        categoryId != null
                                        &&
                                        currentCategory ==
                                        ((Number) categoryId).intValue();
                        %>

                            <option value="<%= currentCategory %>"
                                    <%= selected ? "selected" : "" %>>

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

                <div class="edit-field">

                    <label for="brand">

                        Brand
                        <span class="required">*</span>

                    </label>

                    <input type="text"
                           id="brand"
                           name="brand"
                           value="<%= brand == null ? "" : brand %>"
                           maxlength="50"
                           required>

                </div>


                <!-- MODEL -->

                <div class="edit-field">

                    <label for="model">

                        Model
                        <span class="required">*</span>

                    </label>

                    <input type="text"
                           id="model"
                           name="model"
                           value="<%= model == null ? "" : model %>"
                           maxlength="50"
                           required>

                </div>


                <!-- YEAR -->

                <div class="edit-field">

                    <label for="year">

                        Manufacturing Year

                    </label>

                    <input type="number"
                           id="year"
                           name="year"
                           min="1900"
                           max="2100"
                           value="<%= year == null ? "" : year %>">

                </div>


                <!-- COLOR -->

                <div class="edit-field">

                    <label for="color">

                        Color

                    </label>

                    <input type="text"
                           id="color"
                           name="color"
                           maxlength="30"
                           value="<%= color == null ? "" : color %>">

                </div>


                <!-- SEATING CAPACITY -->

                <div class="edit-field">

                    <label for="seatingCapacity">

                        Seating Capacity

                    </label>

                    <input type="number"
                           id="seatingCapacity"
                           name="seatingCapacity"
                           min="1"
                           value="<%= seatingCapacity == null ? "" : seatingCapacity %>">

                </div>


                <!-- FUEL TYPE -->

                <div class="edit-field">

                    <label for="fuelType">

                        Fuel Type

                    </label>

                    <select id="fuelType"
                            name="fuelType">

                        <option value="">
                            Select fuel type
                        </option>

                        <option value="Petrol"
                            <%= "Petrol".equals(fuelType)
                                ? "selected" : "" %>>

                            Petrol

                        </option>

                        <option value="Diesel"
                            <%= "Diesel".equals(fuelType)
                                ? "selected" : "" %>>

                            Diesel

                        </option>

                        <option value="Electric"
                            <%= "Electric".equals(fuelType)
                                ? "selected" : "" %>>

                            Electric

                        </option>

                        <option value="Hybrid"
                            <%= "Hybrid".equals(fuelType)
                                ? "selected" : "" %>>

                            Hybrid

                        </option>

                        <option value="CNG"
                            <%= "CNG".equals(fuelType)
                                ? "selected" : "" %>>

                            CNG

                        </option>

                    </select>

                </div>


                <!-- TRANSMISSION -->

                <div class="edit-field full">

                    <label for="transmission">

                        Transmission

                    </label>

                    <select id="transmission"
                            name="transmission">

                        <option value="">
                            Select transmission
                        </option>

                        <option value="Manual"
                            <%= "Manual".equals(transmission)
                                ? "selected" : "" %>>

                            Manual

                        </option>

                        <option value="Automatic"
                            <%= "Automatic".equals(transmission)
                                ? "selected" : "" %>>

                            Automatic

                        </option>

                    </select>

                </div>


            </div>


            <!-- =================================================
                 ACTIONS
                 ================================================= -->

            <div class="edit-form-actions">


                <button type="submit"
                        class="save-button">

                    ✓ Save Changes

                </button>


                <a class="cancel-button"
                   href="<%= context %>/admin-vehicles">

                    Cancel

                </a>


            </div>


        </form>

    </section>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <footer class="edit-vehicle-footer">

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