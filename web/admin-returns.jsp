<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.AdminReturnDAO.ReturnableRental"%>

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

    List<ReturnableRental> rentals =
        (List<ReturnableRental>) request.getAttribute(
            "returnableRentals"
        );

    String result =
        request.getParameter("result");

    String context =
        request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Vehicle Returns | Vehicle Rental Admin</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">


    <style>

        /* =====================================================
           MAIN PAGE
           ===================================================== */

        .return-admin-page {

            width: min(1250px, 94%);

            margin: 0 auto;

            padding: 45px 0 75px;
        }


        /* =====================================================
           NAVBAR
           ===================================================== */

        .return-admin-navbar {

            background: #102a43 !important;

            min-height: 72px !important;
        }


        .return-admin-navbar .navbar-inner {

            width: min(1280px, 94%) !important;

            margin: 0 auto !important;
        }


        .return-admin-navbar .logo {

            font-size: 22px !important;

            font-weight: 800 !important;
        }


        .return-admin-navbar .logo span {

            color: #60a5fa !important;
        }


        .return-admin-navbar .nav-links a {

            font-size: 15px !important;
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .return-back {

            display: inline-block;

            margin-bottom: 25px;

            color: #2563eb;

            text-decoration: none;

            font-size: 16px;

            font-weight: 700;
        }


        .return-back:hover {

            text-decoration: underline;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .return-page-header {

            margin-bottom: 30px;
        }


        .return-page-header h1 {

            margin: 0 0 10px;

            color: #102a43;

            font-size: 40px;

            font-weight: 800;
        }


        .return-page-header p {

            margin: 0;

            max-width: 850px;

            color: #627d98;

            font-size: 17px;

            line-height: 1.7;
        }


        /* =====================================================
           RESULT MESSAGES
           ===================================================== */

        .return-message {

            padding: 18px 22px;

            margin-bottom: 22px;

            border-radius: 12px;

            font-size: 15px;

            line-height: 1.6;

            font-weight: 600;

            border: 1px solid transparent;
        }


        .return-success {

            background: #ecfdf3;

            color: #166534;

            border-color: #bbf7d0;
        }


        .return-error {

            background: #fff1f2;

            color: #991b1b;

            border-color: #fecdd3;
        }


        .return-warning {

            background: #fffbeb;

            color: #92400e;

            border-color: #fde68a;

            margin-bottom: 30px;
        }


        .return-warning strong {

            color: #78350f;
        }


        /* =====================================================
           SECTION HEADER
           ===================================================== */

        .return-section-heading {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            margin-bottom: 20px;

            flex-wrap: wrap;
        }


        .return-section-heading h2 {

            margin: 0;

            color: #243b53;

            font-size: 23px;

            font-weight: 800;
        }


        .return-count {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding: 9px 15px;

            background: #eef4ff;

            color: #1d4ed8;

            border-radius: 20px;

            font-size: 13px;

            font-weight: 800;
        }


        /* =====================================================
           RENTAL CARD
           ===================================================== */

        .return-card {

            background: #ffffff;

            border: 1px solid #d9e2ec;

            border-radius: 20px;

            padding: 32px;

            margin-bottom: 28px;

            box-shadow:
                0 10px 30px rgba(16, 42, 67, 0.08);

            transition: all 0.25s ease;
        }


        .return-card:hover {

            transform: translateY(-3px);

            box-shadow:
                0 16px 38px rgba(16, 42, 67, 0.12);

            border-color: #c5d4e5;
        }


        /* =====================================================
           RENTAL CARD HEADER
           ===================================================== */

        .return-card-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding-bottom: 22px;

            margin-bottom: 24px;

            border-bottom: 1px solid #e5edf5;

            flex-wrap: wrap;
        }


        .return-rental-title {

            display: flex;

            align-items: center;

            gap: 12px;
        }


        .return-icon {

            width: 50px;

            height: 50px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eff6ff;

            border-radius: 13px;

            font-size: 26px;
        }


        .return-rental-title h3 {

            margin: 0;

            color: #102a43;

            font-size: 23px;

            font-weight: 800;
        }


        .active-badge {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding: 8px 13px;

            background: #fef3c7;

            color: #92400e;

            border: 1px solid #fde68a;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 800;

            text-transform: uppercase;
        }


        /* =====================================================
           VEHICLE DETAILS
           ===================================================== */

        .return-details {

            display: grid;

            grid-template-columns:
                repeat(4, minmax(0, 1fr));

            gap: 15px;

            margin-bottom: 28px;
        }


        .detail-box {

            background: #f8fafc;

            border: 1px solid #e5edf5;

            border-radius: 12px;

            padding: 17px;
        }


        .detail-label {

            display: block;

            margin-bottom: 7px;

            color: #829ab1;

            font-size: 12px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.4px;
        }


        .detail-value {

            color: #243b53;

            font-size: 15px;

            font-weight: 800;

            line-height: 1.4;
        }


        /* =====================================================
           FORM
           ===================================================== */

        .return-form-title {

            margin: 0 0 20px;

            color: #243b53;

            font-size: 20px;

            font-weight: 800;
        }


        .return-form {

            padding-top: 5px;
        }


        .return-form-grid {

            display: grid;

            grid-template-columns:
                repeat(3, minmax(0, 1fr));

            gap: 22px;
        }


        .return-form-group {

            min-width: 0;
        }


        .return-form-group label {

            display: block;

            margin-bottom: 9px;

            color: #334e68;

            font-size: 15px;

            font-weight: 700;
        }


        .required-star {

            color: #dc2626;
        }


        .return-form-group input,
        .return-form-group textarea {

            width: 100%;

            border: 1px solid #cbd5e1;

            border-radius: 10px;

            background: #ffffff;

            color: #243b53;

            font-family: Arial, sans-serif;

            font-size: 16px;

            padding: 14px 15px;

            outline: none;

            transition: all 0.2s ease;
        }


        .return-form-group input {

            height: 52px;
        }


        .return-form-group textarea {

            min-height: 115px;

            resize: vertical;

            line-height: 1.6;
        }


        .return-form-group input:focus,
        .return-form-group textarea:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37, 99, 235, 0.10);
        }


        .return-form-group input::placeholder,
        .return-form-group textarea::placeholder {

            color: #9fb3c8;
        }


        /* =====================================================
           REMARKS
           ===================================================== */

        .remarks-group {

            margin-top: 22px;
        }


        .remarks-help {

            margin-top: 7px;

            color: #829ab1;

            font-size: 13px;
        }


        /* =====================================================
           RETURN BUTTON
           ===================================================== */

        .return-submit {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            gap: 8px;

            min-height: 52px;

            margin-top: 25px;

            padding: 13px 25px;

            border: none;

            border-radius: 10px;

            background: #16a34a;

            color: #ffffff;

            font-family: Arial, sans-serif;

            font-size: 15px;

            font-weight: 800;

            cursor: pointer;

            transition: all 0.2s ease;

            box-shadow:
                0 6px 16px rgba(22, 163, 74, 0.20);
        }


        .return-submit:hover {

            background: #15803d;

            transform: translateY(-2px);

            box-shadow:
                0 9px 20px rgba(22, 163, 74, 0.27);
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .return-empty {

            background: #ffffff;

            border: 1px solid #d9e2ec;

            border-radius: 18px;

            padding: 65px 25px;

            text-align: center;

            box-shadow:
                0 8px 25px rgba(16, 42, 67, 0.06);
        }


        .return-empty-icon {

            font-size: 52px;

            margin-bottom: 16px;
        }


        .return-empty h3 {

            margin: 0 0 10px;

            color: #334e68;

            font-size: 24px;
        }


        .return-empty p {

            max-width: 650px;

            margin: 0 auto;

            color: #627d98;

            font-size: 15px;

            line-height: 1.7;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .return-footer {

            text-align: center;

            color: #829ab1;

            font-size: 14px;

            margin-top: 55px;

            padding-top: 28px;

            border-top: 1px solid #d9e2ec;
        }


        .return-footer strong {

            color: #486581;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 1000px) {

            .return-details {

                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
            }


            .return-form-grid {

                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
            }
        }


        @media (max-width: 700px) {

            .return-admin-page {

                width: 92%;

                padding-top: 30px;
            }


            .return-page-header h1 {

                font-size: 32px;
            }


            .return-page-header p {

                font-size: 15px;
            }


            .return-card {

                padding: 22px;
            }


            .return-details {

                grid-template-columns: 1fr;
            }


            .return-form-grid {

                grid-template-columns: 1fr;
            }


            .return-submit {

                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVIGATION
     ===================================================== -->

<nav class="navbar return-admin-navbar">

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

<main class="return-admin-page">


    <a class="return-back"
       href="<%= context %>/admin-dashboard">

        ← Back to Admin Dashboard

    </a>


    <!-- PAGE HEADER -->

    <section class="return-page-header">

        <h1>
            Vehicle Returns
        </h1>

        <p>
            Inspect active rentals, record the returned vehicle's
            condition and odometer reading, and apply any applicable
            damage or additional charges.
        </p>

    </section>


    <!-- =================================================
         RESULT MESSAGES
         ================================================= -->

    <% if ("success".equals(result)) { %>

        <div class="return-message return-success">

            ✓ Vehicle return recorded successfully.
            The rental has been marked as completed and the
            vehicle is available again.

        </div>

    <% } else if ("failed".equals(result)) { %>

        <div class="return-message return-error">

            ✕ Return was not recorded.
            The rental may no longer be active or may already
            have a return record.

        </div>

    <% } else if ("invalid".equals(result)) { %>

        <div class="return-message return-error">

            ✕ Invalid return details.
            Please check the values and try again.

        </div>

    <% } else if ("error".equals(result)) { %>

        <div class="return-message return-error">

            ✕ A database error occurred while processing
            the return. Check the server logs.

        </div>

    <% } %>


    <!-- =================================================
         WARNING
         ================================================= -->

    <div class="return-message return-warning">

        <strong>Before confirming the return:</strong>

        Inspect the vehicle carefully, verify the odometer
        reading and enter the actual damage or additional
        charges.

        The late fee is calculated automatically at
        <strong>₹500 per late day</strong>.

    </div>


    <!-- =================================================
         SECTION HEADER
         ================================================= -->

    <div class="return-section-heading">

        <h2>
            Active Rentals Awaiting Return
        </h2>


        <div class="return-count">

            🔄

            <%= rentals == null ? 0 : rentals.size() %>

            Active Rentals

        </div>

    </div>


    <!-- =================================================
         RETURNABLE RENTALS
         ================================================= -->

    <%
        if (rentals != null && !rentals.isEmpty()) {

            for (ReturnableRental rental : rentals) {
    %>


    <section class="return-card">


        <!-- CARD HEADER -->

        <div class="return-card-header">


            <div class="return-rental-title">

                <div class="return-icon">

                    🚘

                </div>


                <h3>

                    Rental #<%= rental.getRentalId() %>

                </h3>

            </div>


            <div class="active-badge">

                ● ACTIVE RENTAL

            </div>


        </div>


        <!-- =================================================
             RENTAL DETAILS
             ================================================= -->

        <div class="return-details">


            <div class="detail-box">

                <span class="detail-label">
                    Customer
                </span>

                <span class="detail-value">

                    <%= rental.getCustomerName() %>

                </span>

            </div>


            <div class="detail-box">

                <span class="detail-label">
                    Vehicle
                </span>

                <span class="detail-value">

                    <%= rental.getVehicleName() %>

                </span>

            </div>


            <div class="detail-box">

                <span class="detail-label">
                    Vehicle Number
                </span>

                <span class="detail-value">

                    <%= rental.getVehicleNumber() %>

                </span>

            </div>


            <div class="detail-box">

                <span class="detail-label">
                    Scheduled Return
                </span>

                <span class="detail-value">

                    <%= rental.getEndDate() %>

                </span>

            </div>


        </div>


        <!-- =================================================
             RETURN FORM
             ================================================= -->

        <h4 class="return-form-title">

            Return Inspection Details

        </h4>


        <form class="return-form"
              method="post"
              action="<%= context %>/admin-returns"
              onsubmit="return confirm('Confirm that you inspected the vehicle and want to record this return?');">


            <input type="hidden"
                   name="rentalId"
                   value="<%= rental.getRentalId() %>">


            <!-- FORM GRID -->

            <div class="return-form-grid">


                <!-- ODOMETER -->

                <div class="return-form-group">

                    <label>

                        Odometer Reading (km)

                        <span class="required-star">
                            *
                        </span>

                    </label>


                    <input type="number"
                           name="odometerReading"
                           min="0"
                           step="1"
                           placeholder="Enter current reading"
                           required>

                </div>


                <!-- DAMAGE CHARGES -->

                <div class="return-form-group">

                    <label>

                        Damage Charges (₹)

                        <span class="required-star">
                            *
                        </span>

                    </label>


                    <input type="number"
                           name="damageCharges"
                           min="0"
                           max="10000000"
                           step="0.01"
                           value="0"
                           placeholder="0.00"
                           required>

                </div>


                <!-- ADDITIONAL CHARGES -->

                <div class="return-form-group">

                    <label>

                        Additional Charges (₹)

                        <span class="required-star">
                            *
                        </span>

                    </label>


                    <input type="number"
                           name="additionalCharges"
                           min="0"
                           max="10000000"
                           step="0.01"
                           value="0"
                           placeholder="0.00"
                           required>

                </div>


            </div>


            <!-- =================================================
                 REMARKS
                 ================================================= -->

            <div class="return-form-group remarks-group">

                <label>

                    Return Remarks

                </label>


                <textarea name="remarks"
                          maxlength="1000"
                          placeholder="Enter vehicle condition, inspection notes, damage details or other remarks"></textarea>


                <div class="remarks-help">

                    Maximum 1000 characters.

                </div>

            </div>


            <!-- =================================================
                 SUBMIT
                 ================================================= -->

            <button
                class="return-submit"
                type="submit">

                ✓ Confirm Vehicle Return

            </button>


        </form>


    </section>


    <%
            }

        } else {
    %>


        <!-- =================================================
             EMPTY STATE
             ================================================= -->

        <div class="return-empty">

            <div class="return-empty-icon">

                🚗

            </div>


            <h3>

                No Active Rentals to Return

            </h3>


            <p>

                Vehicles will appear here after an administrator
                confirms their handover and the rentals become
                <strong>ACTIVE</strong>.

            </p>

        </div>


    <%
        }
    %>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <footer class="return-footer">

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