<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Customer Login | Vehicle Rental System</title>

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
                    #eef4ff 0%,
                    #f7f9fc 50%,
                    #eaf2ff 100%
                );
            color: #243b53;
        }

        /* =====================================================
           LOGIN WRAPPER
           ===================================================== */

        .login-wrapper {
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
            background: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.20);
        }

        .brand-name {
            margin: 0;
            color: #102a43;
            font-size: 22px;
            font-weight: 800;
        }

        .brand-subtitle {
            margin: 6px 0 0;
            color: #829ab1;
            font-size: 14px;
        }

        /* =====================================================
           LOGIN CARD
           ===================================================== */

        .login-card {
            width: 100%;
            padding: 42px;
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(16, 42, 67, 0.10);
        }

        .login-heading {
            margin-bottom: 30px;
            text-align: center;
        }

        .login-heading h1 {
            margin: 0 0 9px;
            color: #102a43;
            font-size: 30px;
            font-weight: 800;
        }

        .login-heading p {
            margin: 0;
            color: #627d98;
            font-size: 15px;
            line-height: 1.6;
        }

        /* =====================================================
           ERROR MESSAGE
           ===================================================== */

        .message {
            margin-bottom: 24px;
            padding: 15px 17px;
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
            color: #102a43;
            font-size: 16px;
            font-weight: 700;
        }

        .input-wrapper {
            position: relative;
        }

        input {
            width: 100%;
            height: 56px;
            padding: 0 16px;
            border: 1px solid #bcccdc;
            border-radius: 9px;
            background: #ffffff;
            color: #243b53;
            font-family: Arial, sans-serif;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        input::placeholder {
            color: #9fb3c8;
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
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.20);
        }

        .login-button:active {
            transform: translateY(0);
        }

        /* =====================================================
           REGISTER SECTION
           ===================================================== */

        .register-section {
            margin-top: 28px;
            padding-top: 25px;
            border-top: 1px solid #e6edf3;
            text-align: center;
            color: #627d98;
            font-size: 15px;
        }

        .register-section a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 700;
        }

        .register-section a:hover {
            text-decoration: underline;
        }

        /* =====================================================
           BACK TO HOME
           ===================================================== */

        .back-home {
            margin-top: 22px;
            text-align: center;
        }

        .back-home a {
            color: #627d98;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .back-home a:hover {
            color: #2563eb;
        }

        /* =====================================================
           FOOTER
           ===================================================== */

        .footer {
            margin-top: 22px;
            text-align: center;
            color: #829ab1;
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

    <div class="login-wrapper">

        <!-- =================================================
             BRAND
             ================================================= -->

        <div class="brand">

            <div class="brand-icon">
                🚗
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

            <div class="login-heading">

                <h1>
                    Welcome Back
                </h1>

                <p>
                    Login to your customer account
                </p>

            </div>


            <!-- =================================================
                 ERROR MESSAGES
                 ================================================= -->

            <% if ("1".equals(request.getParameter("error"))) { %>

                <div class="message">
                    ⚠️ Invalid email or password. Please try again.
                </div>

            <% } else if ("2".equals(request.getParameter("error"))) { %>

                <div class="message">
                    ❌ A server error occurred. Please try again later.
                </div>

            <% } %>


            <!-- =================================================
                 LOGIN FORM
                 ================================================= -->

            <form action="${pageContext.request.contextPath}/login"
                  method="post">


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <div class="input-wrapper">

                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Enter your registered email"
                            autocomplete="email"
                            required
                        >

                    </div>

                </div>


                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <div class="input-wrapper">

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required
                        >

                    </div>

                </div>


                <!-- LOGIN -->

                <button type="submit"
                        class="login-button">

                    🔐 Login

                </button>

            </form>


            <!-- =================================================
                 REGISTER
                 ================================================= -->

            <div class="register-section">

                Don't have an account?

                <a href="${pageContext.request.contextPath}/register.jsp">
                    Register here
                </a>

            </div>


            <!-- =================================================
                 BACK HOME
                 ================================================= -->

            <div class="back-home">

                <a href="${pageContext.request.contextPath}/index.jsp">
                    ← Back to Home
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