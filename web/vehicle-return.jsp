
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.VehicleReturnDAO.ReturnableRental"%>

<%
    if (session.getAttribute("customerId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<ReturnableRental> rentals =
        (List<ReturnableRental>) request.getAttribute("returnableRentals");

    String contextPath = request.getContextPath();
    String error = (String) request.getAttribute("error");
    String successMessage =
        (String) request.getAttribute("successMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Vehicle Return - Vehicle Rental System</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        header {
            background: #102a43;
            color: white;
            padding: 20px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        header h2 {
            margin: 0;
        }

        nav {
            display: flex;
            gap: 18px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
        }

        nav a:hover {
            text-decoration: underline;
        }

        main {
            width: 92%;
            max-width: 850px;
            margin: 35px auto;
        }

        .card {
            background: white;
            padding: 28px;
            border-radius: 12px;
            box-shadow: 0 4px 18px #0000000d;
            margin-bottom: 25px;
        }

        h1 {
            margin-bottom: 8px;
        }

        .subtitle {
            color: #64748b;
            margin-bottom: 25px;
        }

        .notice {
            padding: 14px;
            border-radius: 8px;
            background: #fef3c7;
            color: #92400e;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .success {
            background: #dcfce7;
            color: #166534;
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin: 17px 0 8px;
            font-weight: bold;
        }

        select,
        input,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 15px;
            font-family: inherit;
        }

        textarea {
            resize: vertical;
        }

        .help {
            color: #64748b;
            font-size: 13px;
            margin-top: 6px;
        }

        button,
        .button {
            display: inline-block;
            padding: 12px 18px;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            font-size: 15px;
            cursor: pointer;
            margin-top: 22px;
        }

        button:hover,
        .button:hover {
            background: #1d4ed8;
        }

        .empty {
            text-align: center;
            padding: 35px 20px;
            background: white;
            border-radius: 12px;
        }

        .empty p {
            color: #64748b;
        }

        @media (max-width: 600px) {
            header {
                padding: 18px 5%;
            }

            .card {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<header>
    <h2>Vehicle Rental System</h2>

    <nav>
        <a href="<%= contextPath %>/dashboard.jsp">Dashboard</a>
        <a href="<%= contextPath %>/my-bookings">My Bookings</a>
        <a href="<%= contextPath %>/rental-history">Rental History</a>
    </nav>
</header>

<main>

    <h1>Vehicle Return</h1>

    <p class="subtitle">
        Select an active rental and enter the vehicle return details.
    </p>

    <% if (successMessage != null) { %>
        <div class="success">
            <%= successMessage %>
        </div>
    <% } %>

    <% if (error != null) { %>
        <div class="error">
            <%= error %>
        </div>
    <% } %>

    <div class="notice">
        <strong>Return policy:</strong>
        The current demonstration uses a late fee of ₹500 per late day.
        Damage and additional charges are entered manually for demonstration.
        These charges are recorded but are not collected as a payment.
    </div>

    <% if (rentals == null || rentals.isEmpty()) { %>

        <div class="empty">
            <h2>No returnable rentals found</h2>

            <p>
                Only rentals with status ACTIVE can be returned.
                A booking marked BOOKED must first be marked ACTIVE.
            </p>

            <a class="button"
               href="<%= contextPath %>/my-bookings">
                View My Bookings
            </a>
        </div>

    <% } else { %>

        <div class="card">

            <form method="post"
                  action="<%= contextPath %>/vehicle-return">

                <label for="rentalId">Select Rental</label>

                <select id="rentalId"
                        name="rentalId"
                        required>

                    <option value="">-- Select a rental --</option>

                    <% for (ReturnableRental rental : rentals) { %>

                        <% if ("ACTIVE".equals(
                                rental.getRentalStatus())) { %>

                            <option value="<%= rental.getRentalId() %>">
                                Booking #<%= rental.getRentalId() %>
                                -
                                <%= rental.getBrand() %>
                                <%= rental.getModel() %>
                                (Return by <%= rental.getEndDate() %>)
                            </option>

                        <% } %>

                    <% } %>

                </select>

                <label for="odometerReading">
                    Odometer Reading (km)
                </label>

                <input type="number"
                       id="odometerReading"
                       name="odometerReading"
                       min="0"
                       step="1"
                       required
                       placeholder="Enter current odometer reading">

                <label for="damageCharges">
                    Damage Charges (₹)
                </label>

                <input type="number"
                       id="damageCharges"
                       name="damageCharges"
                       min="0"
                       step="0.01"
                       value="0.00"
                       required>

                <label for="additionalCharges">
                    Additional Charges (₹)
                </label>

                <input type="number"
                       id="additionalCharges"
                       name="additionalCharges"
                       min="0"
                       step="0.01"
                       value="0.00"
                       required>

                <label for="remarks">
                    Return Condition / Remarks
                </label>

                <textarea id="remarks"
                          name="remarks"
                          rows="4"
                          maxlength="255"
                          placeholder="Describe the vehicle condition or other remarks"></textarea>

                <p class="help">
                    The return date is recorded as the current server date.
                    Late fees are calculated automatically.
                </p>

                <button type="submit">
                    Submit Vehicle Return
                </button>

            </form>

        </div>

    <% } %>

</main>

</body>
</html>
