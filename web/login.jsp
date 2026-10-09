
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            padding: 20px;
            font-family: Arial, sans-serif;
            background: #f2f5f9;
            color: #263449;
        }

        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 32px;
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.09);
        }

        h1 {
            margin: 0 0 10px;
            text-align: center;
            font-size: 27px;
            color: #17365d;
        }

        .subtitle {
            margin-bottom: 28px;
            text-align: center;
            color: #718096;
            font-size: 14px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #1769e0;
            box-shadow: 0 0 0 2px rgba(23, 105, 224, 0.12);
        }

        button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #1769e0;
            color: white;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }

        button:hover {
            background: #1054b8;
        }

        .message {
            margin-bottom: 16px;
            padding: 10px;
            border-radius: 6px;
            background: #fff0f0;
            color: #c62828;
            text-align: center;
            font-size: 14px;
        }

        .footer {
            margin-top: 22px;
            text-align: center;
            font-size: 14px;
            color: #718096;
        }

        a {
            color: #1769e0;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <div class="login-card">

        <h1>Welcome Back</h1>
        <p class="subtitle">
            Login to your Vehicle Rental account
        </p>

        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="message">
                Invalid email or password. Please try again.
            </div>
        <% } else if ("2".equals(request.getParameter("error"))) { %>
            <div class="message">
                A server error occurred. Please try again later.
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

            <label for="email">Email Address</label>
            <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your registered email"
                autocomplete="email"
                required
            >

            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                autocomplete="current-password"
                required
            >

            <button type="submit">Login</button>
        </form>

        <div class="footer">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register.jsp">
                Register here
            </a>
        </div>

    </div>
</body>
</html>