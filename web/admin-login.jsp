<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Login | Vehicle Rental System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 20px;
            font-family: Arial, sans-serif;
            background:
                linear-gradient(
                    135deg,
                    #111827 0%,
                    #172554 50%,
                    #1e3a5f 100%
                );
            color: #243b53;
        }

        /* =====================================================
           LOGIN WRAPPER
           ===================================================== */

        .admin-login-wrapper {
            width: 100%;
            max-width: 470px;
        }

        /* =====================================================
           BRAND
           ===================================================== */

        .brand {
            text-align: center;
            margin-bottom: 20px;
        }

        .brand-icon {
            width: 68px;
            height: 68px;
            margin: 0 auto 12px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.20);
        }

        .brand-name {
            margin: 0;
            color: #ffffff;
            font-size: 22px;
            font-weight: 800;
        }

        .brand-subtitle {
            margin: 6px 0 0;
            color: #cbd5e1;
            font-size: 14px;
        }

        /* =====================================================
           LOGIN CARD
           ===================================================== */

        .login-card {
            width: 100%;
            padding: 42px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            box-shadow: 0 18px 50px rgba(0, 0, 0, 0.28);
        }

        .login-heading {
            margin-bottom: 30px;
            text-align: center;
        }

        .login-heading h1 {
            margin: 0 0 9px;
            color: #111827;
            font-size: 30px;
            font-weight: 800;
        }

        .login-heading p {
            margin: 0;
            color: #6b7280;
            font-size: 15px;
            line-height: 1.6;
        }

        /* =====================================================
           ADMIN BADGE
           ===================================================== */

        .admin-badge {
            width: fit-content;
            margin: 0 auto 22px;
            padding: 7px 13px;
            border-radius: 20px;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            color: #1d4ed8;
            font-size: 13px;
            font-weight: 700;
        }

        /* =====================================================
           ERROR
           ===================================================== */

        .error {
            padding: 15px 17px;
            margin-bottom: 24px;
            border-radius: 10px;
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-left: 5px solid #dc2626;
            color: #991b1b;
            font-size: 15px;
            line-height: 1.5;
        }

        /* =====================================================
           FORM
           ===================================================== */

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            color: #374151;
            font-size: 16px;
            font-weight: 700;
        }

        input {
            width: 100%;
            height: 56px;
            padding: 0 16px;
            border: 1px solid #d1d5db;
            border-radius: 9px;
            background: #ffffff;
            color: #1f2937;
            font-family: Arial, sans-serif;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        input::placeholder {
            color: #9ca3af;
        }

        input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px #dbeafe;
        }

        /* =====================================================
           LOGIN BUTTON
           ===================================================== */

        .login-button {
            width: 100%;
            height: 56px;
            margin-top: 5px;
            border: none;
            border-radius: 9px;
            background: #2563eb;
            color: #ffffff;
            font-family: Arial, sans-serif;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .login-button:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.25);
        }

        .login-button:active {
            transform: translateY(0);
        }

        /* =====================================================
           CUSTOMER LOGIN
           ===================================================== */

        .customer-login {
            margin-top: 28px;
            padding-top: 25px;
            border-top: 1px solid #e5e7eb;
            text-align: center;
            color: #6b7280;
            font-size: 15px;
        }

        .customer-login a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 700;
        }

        .customer-login a:hover {
            text-decoration: underline;
        }

        /* =====================================================
           SECURITY NOTE
           ===================================================== */

        .security-note {
            margin-top: 20px;
            padding: 13px 15px;
            border-radius: 9px;
            background: #f8fafc;
            color: #64748b;
            text-align: center;
            font-size: 13px;
            line-height: 1.5;
        }

        /* =====================================================
           FOOTER
           ===================================================== */

        .footer {
            margin-top: 22px;
            text-align: center;
            color: #94a3b8;
            font-size: 13px;
        }

        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 520px) {

            body {
                padding: 20px 15px;
            }

            .login-card {
                padding: 30px 22px;
                border-radius: 16px;
            }

            .brand-icon {
                width: 60px;
                height: 60px;
                font-size: 30px;
            }

            .brand-name {
                font-size: 20px;
            }

            .login-heading h1 {
                font-size: 27px;
            }

            .login-heading p {
                font-size: 14px;
            }

            input,
            .login-button {
                height: 54px;
            }
        }

    </style>

</head>

<body>

    <div class="admin-login-wrapper">

        <!-- =================================================
             BRAND
             ================================================= -->

        <div class="brand">

            <div class="brand-icon">
                🔐
            </div>

            <h2 class="brand-name">
                VehicleRental
            </h2>

            <p class="brand-subtitle">
                Vehicle Rental Management System
            </p>

        </div>


        <!-- =================================================
             LOGIN CARD
             ================================================= -->

        <div class="login-card">

            <div class="admin-badge">
                🛡️ Authorized Personnel Only
            </div>

            <div class="login-heading">

                <h1>
                    Administrator Login
                </h1>

                <p>
                    Access the Vehicle Rental Management Panel
                </p>

            </div>


            <!-- =================================================
                 ERROR MESSAGE
                 ================================================= -->

            <% if ("1".equals(request.getParameter("error"))) { %>

                <div class="error">
                    ⚠️ Invalid username or password. Please try again.
                </div>

            <% } %>


            <!-- =================================================
                 LOGIN FORM
                 ================================================= -->

            <form action="<%= request.getContextPath() %>/admin-login"
                  method="post">


                <!-- USERNAME -->

                <div class="form-group">

                    <label for="username">
                        Admin Username
                    </label>

                    <input
                        type="text"
                        id="username"
                        name="username"
                        required
                        maxlength="50"
                        autocomplete="username"
                        placeholder="Enter admin username"
                    >

                </div>


                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Admin Password
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        required
                        autocomplete="current-password"
                        placeholder="Enter admin password"
                    >

                </div>


                <!-- LOGIN -->

                <button type="submit"
                        class="login-button">

                    🔐 Login to Admin Panel

                </button>

            </form>


            <!-- =================================================
                 SECURITY NOTE
                 ================================================= -->

            <div class="security-note">

                🔒 This area is restricted to authorized
                system administrators.

            </div>


            <!-- =================================================
                 CUSTOMER LOGIN
                 ================================================= -->

            <div class="customer-login">

                Are you a customer?

                <a href="<%= request.getContextPath() %>/login.jsp">
                    Customer Login
                </a>

            </div>

        </div>


        <!-- FOOTER -->

        <div class="footer">

            Vehicle Rental Management System

        </div>

    </div>

</body>
</html>