<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Customer Registration | Vehicle Rental System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 35px 20px;
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
           REGISTER WRAPPER
           ===================================================== */

        .register-wrapper {
            width: 100%;
            max-width: 560px;
            margin: 0 auto;
        }

        /* =====================================================
           BRAND
           ===================================================== */

        .brand {
            text-align: center;
            margin-bottom: 20px;
        }

        .brand-icon {
            width: 65px;
            height: 65px;
            margin: 0 auto 12px;
            border-radius: 18px;
            background: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
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
           REGISTRATION CARD
           ===================================================== */

        .register-card {
            width: 100%;
            padding: 42px;
            background: #ffffff;
            border: 1px solid #e1e8f0;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(16, 42, 67, 0.10);
        }

        .register-heading {
            margin-bottom: 30px;
            text-align: center;
        }

        .register-heading h1 {
            margin: 0 0 9px;
            color: #102a43;
            font-size: 30px;
            font-weight: 800;
        }

        .register-heading p {
            margin: 0;
            color: #627d98;
            font-size: 15px;
            line-height: 1.6;
        }

        /* =====================================================
           MESSAGES
           ===================================================== */

        .message {
            padding: 15px 17px;
            margin-bottom: 23px;
            border-radius: 10px;
            font-size: 15px;
            line-height: 1.5;
        }

        .success {
            color: #166534;
            background: #ecfdf3;
            border: 1px solid #a7f3d0;
            border-left: 5px solid #16a34a;
        }

        .error {
            color: #991b1b;
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-left: 5px solid #dc2626;
        }

        /* =====================================================
           FORM
           ===================================================== */

        .form-group {
            margin-bottom: 21px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            color: #102a43;
            font-size: 16px;
            font-weight: 700;
        }

        input,
        textarea {
            display: block;
            width: 100%;
            border: 1px solid #bcccdc;
            border-radius: 9px;
            background: #ffffff;
            color: #243b53;
            font-family: Arial, sans-serif;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        input {
            height: 54px;
            padding: 0 16px;
        }

        textarea {
            min-height: 115px;
            padding: 14px 16px;
            resize: vertical;
            line-height: 1.6;
        }

        input::placeholder,
        textarea::placeholder {
            color: #9fb3c8;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px #dbeafe;
        }

        /* =====================================================
           PASSWORD HINT
           ===================================================== */

        .field-hint {
            display: block;
            margin-top: 7px;
            color: #829ab1;
            font-size: 13px;
            line-height: 1.5;
        }

        /* =====================================================
           CREATE ACCOUNT BUTTON
           ===================================================== */

        .register-button {
            width: 100%;
            height: 56px;
            margin-top: 8px;
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

        .register-button:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.20);
        }

        .register-button:active {
            transform: translateY(0);
        }

        /* =====================================================
           LOGIN SECTION
           ===================================================== */

        .login-section {
            margin-top: 28px;
            padding-top: 25px;
            border-top: 1px solid #e6edf3;
            text-align: center;
            color: #627d98;
            font-size: 15px;
        }

        .login-section a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 700;
        }

        .login-section a:hover {
            text-decoration: underline;
        }

        /* =====================================================
           BACK HOME
           ===================================================== */

        .back-home {
            margin-top: 20px;
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

        @media (max-width: 600px) {

            body {
                padding: 22px 15px;
            }

            .register-card {
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

            .register-heading h1 {
                font-size: 27px;
            }

            .register-heading p {
                font-size: 14px;
            }

            input {
                height: 53px;
            }

            .register-button {
                height: 54px;
            }
        }

    </style>

</head>

<body>

    <div class="register-wrapper">

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
             REGISTRATION CARD
             ================================================= -->

        <div class="register-card">

            <div class="register-heading">

                <h1>
                    Create Your Account
                </h1>

                <p>
                    Register as a customer to start renting vehicles
                </p>

            </div>


            <!-- =================================================
                 SUCCESS MESSAGE
                 ================================================= -->

            <% if ("1".equals(request.getParameter("success"))) { %>

                <div class="message success" role="status">

                    ✅ Registration successful!
                    Your account has been created.

                </div>

            <% } %>


            <!-- =================================================
                 ERROR MESSAGE
                 ================================================= -->

            <% if ("duplicate".equals(request.getParameter("error"))) { %>

                <div class="message error" role="alert">

                    ⚠️ This email is already registered.
                    Please use another email.

                </div>

            <% } %>


            <!-- =================================================
                 REGISTRATION FORM
                 ================================================= -->

            <form action="${pageContext.request.contextPath}/register"
                  method="post">


                <!-- FULL NAME -->

                <div class="form-group">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        maxlength="100"
                        autocomplete="name"
                        placeholder="Enter your full name"
                        required
                    >

                </div>


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        maxlength="100"
                        autocomplete="email"
                        placeholder="Enter your email"
                        required
                    >

                </div>


                <!-- PHONE -->

                <div class="form-group">

                    <label for="phone">
                        Phone Number
                    </label>

                    <input
                        type="tel"
                        id="phone"
                        name="phone"
                        maxlength="15"
                        autocomplete="tel"
                        placeholder="Enter your phone number"
                        required
                    >

                </div>


                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        minlength="8"
                        maxlength="72"
                        autocomplete="new-password"
                        placeholder="Enter at least 8 characters"
                        required
                    >

                    <span class="field-hint">
                        Password must contain at least 8 characters.
                    </span>

                </div>


                <!-- ADDRESS -->

                <div class="form-group">

                    <label for="address">
                        Address
                    </label>

                    <textarea
                        id="address"
                        name="address"
                        rows="3"
                        maxlength="255"
                        autocomplete="street-address"
                        placeholder="Enter your address (optional)"
                    ></textarea>

                </div>


                <!-- CREATE ACCOUNT -->

                <button type="submit"
                        class="register-button">

                    🚀 Create Account

                </button>

            </form>


            <!-- =================================================
                 LOGIN LINK
                 ================================================= -->

            <div class="login-section">

                Already have an account?

                <a href="${pageContext.request.contextPath}/login.jsp">
                    Login here
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