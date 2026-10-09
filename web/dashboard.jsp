
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String customerName =
        (String) session.getAttribute("customerName");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Customer Dashboard | Vehicle Rental</title>
    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            color: #1e293b;
        }

        header {
            background: #123b70;
            color: white;
            padding: 20px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        header h2 { margin: 0; }

        header a {
            color: white;
            text-decoration: none;
            background: #dc2626;
            padding: 10px 16px;
            border-radius: 6px;
        }

        main { padding: 35px 6%; }

        .welcome {
            background: white;
            padding: 28px;
            border-radius: 12px;
            box-shadow: 0 4px 15px #0000000d;
            margin-bottom: 28px;
        }

        .welcome h1 { margin-top: 0; }

        .cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px #0000000d;
        }

        .card h3 { color: #123b70; }

        .card a {
            display: inline-block;
            background: #2563eb;
            color: white;
            text-decoration: none;
            padding: 10px 14px;
            border-radius: 6px;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #64748b;
        }
    </style>
</head>
<body>

<header>
    <h2>Vehicle Rental System</h2>
    <a href="logout">Logout</a>
</header>

<main>
    <section class="welcome">
        <h1>Welcome, <%= customerName %>!</h1>
        <p>
            Manage your rentals from one place.
            Find a vehicle and plan your next journey.
        </p>
    </section>

    <section class="cards">
        <div class="card">
            <h3>Search Vehicles</h3>
            <p>Explore vehicles and rental prices.</p>
            <a href="vehicles.jsp">Browse Vehicles</a>
        </div>

        <div class="card">
            <h3>My Bookings</h3>
            <p>View your current and previous bookings.</p>
            <a href="my-bookings.jsp">View Bookings</a>
        </div>

        <div class="card">
            <h3>Rental History</h3>
            <p>Review your completed rentals.</p>
            <a href="rental-history.jsp">View History</a>
        </div>

        <div class="card">
            <h3>My Profile</h3>
            <p>View your customer account details.</p>
            <a href="profile.jsp">View Profile</a>
        </div>
    </section>
</main>

<footer>
    Vehicle Rental Management System
</footer>

</body>
</html>
