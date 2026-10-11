<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.vehiclerental.dao.CustomerProfileDAO.CustomerProfile"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    CustomerProfile profile =
        (CustomerProfile) request.getAttribute("profile");

    if (profile == null) {
        response.sendRedirect(request.getContextPath() + "/customer-profile");
        return;
    }

    String result = request.getParameter("result");
    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Profile - Vehicle Rental System</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">

    <style>

        /* =====================================================
           PROFILE PAGE
           ===================================================== */

        .profile-page {
            width: min(1200px, 94%);
            margin: 0 auto;
            padding: 50px 0 70px;
        }

        /* =====================================================
           CUSTOMER NAVIGATION
           ===================================================== */

        .navbar {
            width: 100%;
        }

        .navbar-inner {
            width: min(1400px, 94%);
            margin: 0 auto;
            min-height: 72px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
        }

        .navbar .logo {
            flex-shrink: 0;
            white-space: nowrap;
        }

        .navbar .nav-links {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 8px !important;
            flex-wrap: wrap;
        }

        .navbar .nav-links a {
            padding: 10px 13px !important;
            border-radius: 8px;
            white-space: nowrap;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .navbar .nav-links a:hover {
            background: rgba(255, 255, 255, 0.10);
        }

        .navbar .nav-links a.active {
            background: rgba(255, 255, 255, 0.14);
            font-weight: 700;
        }

        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .profile-page-header {
            margin-bottom: 32px;
        }

        .profile-page-header h1 {
            margin: 0 0 10px;
            color: #102a43;
            font-size: 42px;
            font-weight: 800;
            line-height: 1.2;
        }

        .profile-page-header p {
            margin: 0;
            color: #627d98;
            font-size: 18px;
            line-height: 1.7;
        }

        /* =====================================================
           PROFILE LAYOUT
           ===================================================== */

        .profile-layout {
            display: grid;
            grid-template-columns: 310px 1fr;
            gap: 30px;
            align-items: start;
        }

        /* =====================================================
           PROFILE SIDE CARD
           ===================================================== */

        .profile-intro {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 35px 25px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
            position: sticky;
            top: 25px;
        }

        .profile-avatar {
            width: 105px;
            height: 105px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #eaf2ff;
            border: 5px solid #dbeafe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
        }

        .profile-intro h2 {
            margin: 0 0 8px;
            color: #102a43;
            font-size: 24px;
            font-weight: 800;
            word-break: break-word;
        }

        .profile-intro p {
            margin: 0;
            color: #627d98;
            font-size: 15px;
            line-height: 1.6;
        }

        .profile-id {
            margin-top: 22px;
            padding: 14px 15px;
            background: #f5f8fc;
            border-radius: 10px;
            color: #486581;
            font-size: 14px;
        }

        .profile-id strong {
            color: #102a43;
            font-size: 15px;
        }

        /* =====================================================
           FORM CARD
           ===================================================== */

        .profile-form-card {
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 18px;
            padding: 42px;
            box-shadow: 0 8px 25px rgba(16, 42, 67, 0.08);
        }

        .profile-form-card h2 {
            margin: 0 0 8px;
            color: #102a43;
            font-size: 30px;
            font-weight: 800;
        }

        .profile-form-card > p {
            margin: 0 0 32px;
            color: #627d98;
            font-size: 16px;
            line-height: 1.6;
        }

        /* =====================================================
           MESSAGES
           ===================================================== */

        .profile-message {
            padding: 17px 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            font-size: 16px;
            line-height: 1.6;
        }

        .profile-message.success {
            background: #ecfdf3;
            border: 1px solid #a7f3d0;
            border-left: 5px solid #16a34a;
            color: #166534;
        }

        .profile-message.error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-left: 5px solid #dc2626;
            color: #991b1b;
        }

        /* =====================================================
           FORM
           ===================================================== */

        .profile-form-group {
            margin-bottom: 25px;
        }

        .profile-form-group label {
            display: block;
            margin-bottom: 9px;
            color: #102a43;
            font-size: 17px;
            font-weight: 700;
        }

        .profile-input,
        .profile-textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 15px 16px;
            border: 1px solid #bcccdc;
            border-radius: 9px;
            background: #ffffff;
            color: #243b53;
            font-family: Arial, sans-serif;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        .profile-input {
            height: 56px;
        }

        .profile-textarea {
            min-height: 130px;
            resize: vertical;
            line-height: 1.6;
        }

        .profile-input:focus,
        .profile-textarea:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px #dbeafe;
        }

        .profile-input[readonly] {
            background: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }

        .profile-hint {
            display: block;
            margin-top: 8px;
            color: #829ab1;
            font-size: 14px;
            line-height: 1.5;
        }

        /* =====================================================
           BUTTONS
           ===================================================== */

        .profile-button-row {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
            margin-top: 32px;
            padding-top: 26px;
            border-top: 1px solid #e6edf3;
        }

        .profile-btn {
            min-width: 165px;
            padding: 15px 23px;
            border: none;
            border-radius: 9px;
            text-decoration: none;
            text-align: center;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            box-sizing: border-box;
        }

        .profile-btn-primary {
            background: #2563eb;
            color: #ffffff;
        }

        .profile-btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .profile-btn-secondary {
            background: #e8eef5;
            color: #334e68;
        }

        .profile-btn-secondary:hover {
            background: #d9e2ec;
            transform: translateY(-1px);
        }

        /* =====================================================
           FOOTER
           ===================================================== */

        .profile-footer {
            text-align: center;
            margin-top: 38px;
            color: #829ab1;
            font-size: 14px;
        }

        /* =====================================================
           RESPONSIVE NAVIGATION
           ===================================================== */

        @media (max-width: 1100px) {

            .navbar-inner {
                align-items: flex-start;
                padding: 15px 0;
                flex-direction: column;
            }

            .navbar .nav-links {
                width: 100%;
                justify-content: flex-start;
            }
        }

        /* =====================================================
           RESPONSIVE PROFILE
           ===================================================== */

        @media (max-width: 850px) {

            .profile-layout {
                grid-template-columns: 1fr;
            }

            .profile-intro {
                position: static;
                max-width: 500px;
                width: 100%;
                margin: 0 auto;
                box-sizing: border-box;
            }
        }

        @media (max-width: 600px) {

            .profile-page {
                width: 94%;
                padding-top: 32px;
            }

            .profile-page-header h1 {
                font-size: 34px;
            }

            .profile-page-header p {
                font-size: 16px;
            }

            .profile-form-card {
                padding: 25px 20px;
            }

            .profile-form-card h2 {
                font-size: 25px;
            }

            .profile-btn {
                width: 100%;
            }

            .navbar .nav-links {
                gap: 5px !important;
            }

            .navbar .nav-links a {
                padding: 9px 10px !important;
                font-size: 13px;
            }
        }

    </style>

</head>

<body>

<!-- =========================================================
     CUSTOMER NAVIGATION
     ========================================================= -->

<nav class="navbar">

    <div class="navbar-inner">

        <div class="logo">
            🚗 VehicleRental
        </div>

        <div class="nav-links">

            <a href="<%= context %>/dashboard.jsp">
                Dashboard
            </a>

            <a href="<%= context %>/vehicles">
                Vehicles
            </a>

            <a href="<%= context %>/my-bookings">
                My Bookings
            </a>

            <a href="<%= context %>/rental-history">
                Rental History
            </a>

            <a href="<%= context %>/return-history">
                Return History
            </a>

            <a href="<%= context %>/payment-history">
                Payments
            </a>

            <a href="<%= context %>/customer-profile"
               class="active">
                Profile
            </a>

            <a href="<%= context %>/logout">
                Logout
            </a>

        </div>

    </div>

</nav>


<!-- =========================================================
     MAIN CONTENT
     ========================================================= -->

<main class="profile-page">

    <!-- PAGE HEADER -->

    <div class="profile-page-header">

        <h1>
            My Profile
        </h1>

        <p>
            View and update your personal information.
        </p>

    </div>


    <!-- =====================================================
         PROFILE LAYOUT
         ===================================================== -->

    <div class="profile-layout">


        <!-- =================================================
             PROFILE INTRO
             ================================================= -->

        <div class="profile-intro">

            <div class="profile-avatar">
                👤
            </div>

            <h2>
                <%= profile.getFullName() %>
            </h2>

            <p>
                Registered Customer
            </p>

            <div class="profile-id">

                Customer ID:
                <strong>
                    #<%= profile.getCustomerId() %>
                </strong>

            </div>

        </div>


        <!-- =================================================
             PROFILE FORM
             ================================================= -->

        <div class="profile-form-card">

            <h2>
                Personal Information
            </h2>

            <p>
                Keep your customer information up to date.
            </p>


            <!-- =================================================
                 RESULT MESSAGES
                 ================================================= -->

            <% if ("updated".equals(result)) { %>

                <div class="profile-message success">

                    ✅ Your profile was updated successfully.

                </div>

            <% } else if ("invalid".equals(result)) { %>

                <div class="profile-message error">

                    ⚠️ Please check your details.
                    Enter a valid name and phone number.

                </div>

            <% } else if ("error".equals(result)) { %>

                <div class="profile-message error">

                    ❌ Your profile could not be updated.
                    Please try again.

                </div>

            <% } %>


            <!-- =================================================
                 FORM
                 ================================================= -->

            <form action="<%= context %>/customer-profile"
                  method="post">


                <!-- CUSTOMER ID -->

                <div class="profile-form-group">

                    <label for="customerId">
                        Customer ID
                    </label>

                    <input type="text"
                           id="customerId"
                           class="profile-input"
                           value="<%= profile.getCustomerId() %>"
                           readonly>

                </div>


                <!-- FULL NAME -->

                <div class="profile-form-group">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input type="text"
                           id="fullName"
                           name="fullName"
                           class="profile-input"
                           maxlength="100"
                           value="<%= profile.getFullName() %>"
                           required>

                </div>


                <!-- EMAIL -->

                <div class="profile-form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input type="email"
                           id="email"
                           class="profile-input"
                           value="<%= profile.getEmail() %>"
                           readonly>

                    <span class="profile-hint">
                        Your registered email is used for login
                        and cannot be changed here.
                    </span>

                </div>


                <!-- PHONE -->

                <div class="profile-form-group">

                    <label for="phone">
                        Phone Number
                    </label>

                    <input type="tel"
                           id="phone"
                           name="phone"
                           class="profile-input"
                           maxlength="15"
                           pattern="[0-9+() -]{7,15}"
                           value="<%= profile.getPhone() %>"
                           required>

                </div>


                <!-- ADDRESS -->

                <div class="profile-form-group">

                    <label for="address">
                        Address
                    </label>

                    <textarea id="address"
                              name="address"
                              class="profile-textarea"
                              maxlength="255"
                              placeholder="Enter your address"><%= profile.getAddress() == null ? "" : profile.getAddress() %></textarea>

                </div>


                <!-- BUTTONS -->

                <div class="profile-button-row">

                    <button type="submit"
                            class="profile-btn profile-btn-primary">

                        💾 Save Changes

                    </button>

                    <a href="<%= context %>/dashboard.jsp"
                       class="profile-btn profile-btn-secondary">

                        ← Cancel

                    </a>

                </div>


            </form>

        </div>


    </div>


    <!-- FOOTER -->

    <div class="profile-footer">

        Vehicle Rental Management System

    </div>


</main>


</body>
</html> 