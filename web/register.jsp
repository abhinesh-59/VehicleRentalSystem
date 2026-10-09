
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            padding: 40px 15px;
            font-family: Arial, sans-serif;
            background: #f2f5f9;
            color: #263449;
        }

        .container {
            width: 100%;
            max-width: 470px;
            margin: 0 auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.09);
        }

        h1 {
            margin: 0 0 10px;
            text-align: center;
            color: #183153;
            font-size: 27px;
        }

        .subtitle {
            margin-bottom: 25px;
            text-align: center;
            color: #667085;
            font-size: 14px;
        }

        label {
            display: block;
            margin: 16px 0 7px;
            font-weight: bold;
            font-size: 14px;
        }

        input,
        textarea {
            display: block;
            width: 100%;
            padding: 12px;
            border: 1px solid #ccd5e0;
            border-radius: 7px;
            font-family: inherit;
            font-size: 15px;
            background: #ffffff;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #1769e0;
            box-shadow: 0 0 0 3px rgba(23, 105, 224, 0.12);
        }

        textarea {
            resize: vertical;
        }

        button {
            width: 100%;
            margin-top: 24px;
            padding: 13px;
            border: none;
            border-radius: 7px;
            background: #1769e0;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1054b8;
        }

        .message {
            padding: 12px;
            margin-bottom: 18px;
            border-radius: 7px;
            text-align: center;
            font-size: 14px;
        }

        .success {
            color: #166534;
            background: #dcfce7;
            border: 1px solid #86efac;
        }

        .error {
            color: #991b1b;
            background: #fee2e2;
            border: 1px solid #fca5a5;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            color: #667085;
            font-size: 13px;
        }

        @media (max-width: 480px) {
            body {
                padding: 20px 12px;
            }

            .container {
                padding: 22px;
            }

            h1 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>
    <div class="container">

        <h1>Customer Registration</h1>
        <p class="subtitle">
            Create your Vehicle Rental System account
        </p>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="message success" role="status">
                Registration successful! Your account has been created.
            </div>
        <% } %>

        <% if ("duplicate".equals(request.getParameter("error"))) { %>
            <div class="message error" role="alert">
                This email is already registered. Please use another email.
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register"
              method="post">

            <label for="fullName">Full Name</label>
            <input
                type="text"
                id="fullName"
                name="fullName"
                maxlength="100"
                autocomplete="name"
                placeholder="Enter your full name"
                required>

            <label for="email">Email Address</label>
            <input
                type="email"
                id="email"
                name="email"
                maxlength="100"
                autocomplete="email"
                placeholder="Enter your email"
                required>

            <label for="phone">Phone Number</label>
            <input
                type="tel"
                id="phone"
                name="phone"
                maxlength="15"
                autocomplete="tel"
                placeholder="Enter your phone number"
                required>

            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                minlength="8"
                maxlength="72"
                autocomplete="new-password"
                placeholder="At least 8 characters"
                required>

            <label for="address">Address</label>
            <textarea
                id="address"
                name="address"
                rows="3"
                maxlength="255"
                autocomplete="street-address"
                placeholder="Enter your address (optional)"></textarea>

            <button type="submit">Create Account</button>
        </form>

        <div class="footer">
            Vehicle Rental Management System
        </div>

    </div>
</body>
</html>
