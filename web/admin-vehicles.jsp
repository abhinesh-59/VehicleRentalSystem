<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.AdminVehicleDAO.VehicleRecord"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(
            request.getContextPath() + "/admin-login.jsp"
        );
        return;
    }

    List<VehicleRecord> vehicles =
        (List<VehicleRecord>) request.getAttribute("vehicles");

    String result = request.getParameter("result");

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Vehicle Management | Admin</title>

    <!-- Shared Professional CSS -->
    <link rel="stylesheet"
          href="<%= context %>/css/style.css">


    <style>

        /* ================= PAGE ================= */

        .vehicle-admin-page {

            width: min(1280px, 94%);

            margin: 0 auto;

            padding: 42px 0 70px;
        }


        /* ================= HEADER ================= */

        .vehicle-admin-header {

            background: #102a43;

            color: white;

            min-height: 68px;
        }

        .vehicle-admin-header .navbar-inner {

            width: min(1280px, 94%);

            margin: 0 auto;
        }

        .vehicle-admin-header .logo {

            font-size: 21px;

            font-weight: 800;
        }

        .vehicle-admin-header .logo span {

            color: #60a5fa;
        }


        /* ================= PAGE TOP ================= */

        .vehicle-page-heading {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 25px;

            margin-bottom: 30px;
        }


        .vehicle-page-heading h1 {

            margin: 0 0 8px;

            color: #102a43;

            font-size: 30px;

            font-weight: 800;
        }


        .vehicle-page-heading p {

            margin: 0;

            color: #627d98;

            font-size: 15px;
        }


        .back-dashboard {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            color: #2563eb;

            text-decoration: none;

            font-size: 14px;

            font-weight: 700;

            margin-bottom: 22px;
        }


        .back-dashboard:hover {

            text-decoration: underline;
        }


        /* ================= ADD BUTTON ================= */

        .add-vehicle-btn {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            gap: 7px;

            background: #2563eb;

            color: white;

            text-decoration: none;

            border-radius: 10px;

            padding: 13px 20px;

            font-size: 14px;

            font-weight: 700;

            white-space: nowrap;

            transition: all 0.2s ease;

            box-shadow:
                0 5px 14px rgba(37, 99, 235, 0.22);
        }


        .add-vehicle-btn:hover {

            background: #1d4ed8;

            transform: translateY(-2px);

            box-shadow:
                0 8px 18px rgba(37, 99, 235, 0.28);
        }


        /* ================= MAIN PANEL ================= */

        .vehicle-panel {

            background: white;

            border: 1px solid #e1e8f0;

            border-radius: 20px;

            padding: 30px;

            box-shadow:
                0 9px 28px rgba(16, 42, 67, 0.08);
        }


        .vehicle-panel-top {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 15px;

            margin-bottom: 25px;
        }


        .vehicle-panel-top h2 {

            margin: 0 0 6px;

            color: #102a43;

            font-size: 23px;

            font-weight: 800;
        }


        .vehicle-panel-top p {

            margin: 0;

            color: #627d98;

            font-size: 14px;
        }


        .vehicle-count {

            background: #eef4ff;

            color: #1d4ed8;

            padding: 9px 14px;

            border-radius: 20px;

            font-size: 13px;

            font-weight: 700;

            white-space: nowrap;
        }


        /* ================= MESSAGES ================= */

        .message {

            padding: 14px 17px;

            border-radius: 10px;

            margin-bottom: 20px;

            font-size: 14px;

            font-weight: 600;

            border: 1px solid transparent;
        }


        .success {

            background: #ecfdf3;

            color: #166534;

            border-color: #bbf7d0;
        }


        .error {

            background: #fff1f2;

            color: #991b1b;

            border-color: #fecdd3;
        }


        /* ================= TABLE ================= */

        .table-wrapper {

            width: 100%;

            overflow-x: auto;

            border: 1px solid #e1e8f0;

            border-radius: 14px;
        }


        table {

            width: 100%;

            border-collapse: collapse;

            min-width: 1000px;
        }


        thead {

            background: #f1f5ff;
        }


        th {

            padding: 16px 15px;

            text-align: left;

            color: #24476b;

            font-size: 13px;

            font-weight: 800;

            border-bottom: 1px solid #dbe5f0;

            white-space: nowrap;
        }


        td {

            padding: 17px 15px;

            color: #334e68;

            font-size: 14px;

            border-bottom: 1px solid #edf2f7;

            vertical-align: middle;
        }


        tbody tr {

            transition: background 0.2s ease;
        }


        tbody tr:hover {

            background: #f8fbff;
        }


        tbody tr:last-child td {

            border-bottom: none;
        }


        .vehicle-id {

            color: #829ab1;

            font-weight: 700;
        }


        .vehicle-name {

            color: #102a43;

            font-weight: 750;
        }


        .registration {

            font-weight: 700;

            color: #486581;

            letter-spacing: 0.3px;
        }


        .price {

            color: #102a43;

            font-weight: 800;

            white-space: nowrap;
        }


        /* ================= STATUS ================= */

        .status-badge {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding: 7px 12px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 800;

            white-space: nowrap;
        }


        .status-badge.available {

            background: #dcfce7;

            color: #166534;
        }


        .status-badge.rented {

            background: #fee2e2;

            color: #991b1b;
        }


        .status-badge.unknown {

            background: #f1f5f9;

            color: #475569;
        }


        /* ================= ACTIONS ================= */

        .vehicle-actions {

            display: flex;

            align-items: center;

            gap: 8px;
        }


        .vehicle-action {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            padding: 9px 13px;

            border: none;

            border-radius: 8px;

            color: white;

            text-decoration: none;

            font-size: 12px;

            font-weight: 800;

            cursor: pointer;

            transition: all 0.2s ease;

            white-space: nowrap;
        }


        .edit-action {

            background: #2563eb;
        }


        .edit-action:hover {

            background: #1d4ed8;

            transform: translateY(-1px);
        }


        .delete-action {

            background: #dc2626;
        }


        .delete-action:hover {

            background: #b91c1c;

            transform: translateY(-1px);
        }


        .vehicle-actions form {

            margin: 0;
        }


        /* ================= EMPTY STATE ================= */

        .empty-state {

            text-align: center;

            padding: 55px 25px;

            color: #627d98;
        }


        .empty-state-icon {

            font-size: 45px;

            margin-bottom: 12px;
        }


        .empty-state h3 {

            margin: 0 0 8px;

            color: #334e68;

            font-size: 20px;
        }


        .empty-state p {

            margin: 0;

            font-size: 14px;
        }


        /* ================= FOOTER ================= */

        .vehicle-footer {

            text-align: center;

            color: #829ab1;

            font-size: 13px;

            margin-top: 45px;

            padding-top: 25px;

            border-top: 1px solid #d9e2ec;
        }


        .vehicle-footer strong {

            color: #486581;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 800px) {

            .vehicle-page-heading {

                align-items: flex-start;

                flex-direction: column;
            }


            .vehicle-panel {

                padding: 20px;
            }


            .vehicle-panel-top {

                align-items: flex-start;

                flex-direction: column;
            }


            .vehicle-count {

                align-self: flex-start;
            }
        }


        @media (max-width: 600px) {

            .vehicle-admin-page {

                width: 92%;

                padding-top: 25px;
            }


            .vehicle-page-heading h1 {

                font-size: 25px;
            }


            .vehicle-panel {

                padding: 15px;
            }


            .add-vehicle-btn {

                width: 100%;
            }
        }

    </style>

</head>


<body>


    <!-- ================= NAVIGATION ================= -->

    <nav class="navbar vehicle-admin-header">

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


    <!-- ================= MAIN CONTENT ================= -->

    <main class="vehicle-admin-page">


        <!-- Back -->

        <a class="back-dashboard"
           href="<%= context %>/admin-dashboard">

            ← Back to Admin Dashboard

        </a>


        <!-- Page Heading -->

        <section class="vehicle-page-heading">

            <div>

                <h1>
                    Vehicle Management
                </h1>

                <p>
                    Manage your vehicle fleet, rental status
                    and registered vehicle information.
                </p>

            </div>


            <a class="add-vehicle-btn"
               href="<%= context %>/admin-add-vehicle.jsp">

                ＋ Add Vehicle

            </a>

        </section>


        <!-- ================= VEHICLE PANEL ================= -->

        <section class="vehicle-panel">


            <div class="vehicle-panel-top">

                <div>

                    <h2>
                        Registered Vehicles
                    </h2>

                    <p>
                        View, edit or remove vehicles from your fleet.
                    </p>

                </div>


                <div class="vehicle-count">

                    🚘
                    <%= vehicles == null ? 0 : vehicles.size() %>
                    Vehicles

                </div>

            </div>


            <!-- ================= MESSAGES ================= -->

            <% if ("updated".equals(result)) { %>

                <div class="message success">

                    ✓ Vehicle updated successfully.

                </div>

            <% } else if ("deleted".equals(result)) { %>

                <div class="message success">

                    ✓ Vehicle deleted successfully.

                </div>

            <% } else if ("invalid".equals(result)) { %>

                <div class="message error">

                    ✕ Invalid vehicle request.

                </div>

            <% } else if ("duplicate".equals(result)) { %>

                <div class="message error">

                    ✕ That registration number already exists.

                </div>

            <% } else if ("hasrecords".equals(result)) { %>

                <div class="message error">

                    ✕ This vehicle has rental history and cannot
                    be deleted.

                </div>

            <% } else if ("notallowed".equals(result)) { %>

                <div class="message error">

                    ✕ Only AVAILABLE vehicles can be deleted.

                </div>

            <% } else if ("notfound".equals(result)) { %>

                <div class="message error">

                    ✕ Vehicle not found.

                </div>

            <% } %>


            <!-- ================= TABLE ================= -->

            <div class="table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                ID
                            </th>

                            <th>
                                Vehicle
                            </th>

                            <th>
                                Registration
                            </th>

                            <th>
                                Category
                            </th>

                            <th>
                                Rental / Day
                            </th>

                            <th>
                                Status
                            </th>

                            <th>
                                Actions
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                    <%
                        if (vehicles != null && !vehicles.isEmpty()) {

                            for (VehicleRecord vehicle : vehicles) {

                                String vehicleStatus =
                                    vehicle.getStatus() == null
                                    ? "UNKNOWN"
                                    : vehicle.getStatus();

                                String statusClass =
                                    "AVAILABLE".equalsIgnoreCase(vehicleStatus)
                                    ? "available"
                                    : "RENTED".equalsIgnoreCase(vehicleStatus)
                                    ? "rented"
                                    : "unknown";
                    %>


                        <tr>


                            <!-- ID -->

                            <td class="vehicle-id">

                                #<%= vehicle.getVehicleId() %>

                            </td>


                            <!-- Vehicle Name -->

                            <td class="vehicle-name">

                                <%= vehicle.getVehicleName() == null
                                    ? "-"
                                    : vehicle.getVehicleName() %>

                            </td>


                            <!-- Registration -->

                            <td class="registration">

                                <%= vehicle.getRegistrationNumber() == null
                                    ? "-"
                                    : vehicle.getRegistrationNumber() %>

                            </td>


                            <!-- Category -->

                            <td>

                                <%= vehicle.getCategoryName() == null
                                    ? "Uncategorized"
                                    : vehicle.getCategoryName() %>

                            </td>


                            <!-- Price -->

                            <td class="price">

                                ₹<%= String.format(
                                    "%.2f",
                                    vehicle.getRentalPrice()
                                ) %>

                            </td>


                            <!-- Status -->

                            <td>

                                <span class="status-badge <%= statusClass %>">

                                    <%= "AVAILABLE".equalsIgnoreCase(vehicleStatus)
                                        ? "● Available"
                                        : "RENTED".equalsIgnoreCase(vehicleStatus)
                                        ? "● Rented"
                                        : "● " + vehicleStatus %>

                                </span>

                            </td>


                            <!-- Actions -->

                            <td>

                                <div class="vehicle-actions">


                                    <!-- Edit -->

                                    <a class="vehicle-action edit-action"
                                       href="<%= context %>/admin-edit-vehicle-form?id=<%= vehicle.getVehicleId() %>">

                                        Edit

                                    </a>


                                    <!-- Delete -->

                                    <form method="post"
                                          action="<%= context %>/admin-delete-vehicle"
                                          onsubmit="return confirm('Are you sure you want to delete this vehicle? This action cannot be undone.');">

                                        <input type="hidden"
                                               name="vehicleId"
                                               value="<%= vehicle.getVehicleId() %>">


                                        <button type="submit"
                                                class="vehicle-action delete-action">

                                            Delete

                                        </button>

                                    </form>


                                </div>

                            </td>


                        </tr>


                    <%
                            }

                        } else {
                    %>


                        <tr>

                            <td colspan="7">

                                <div class="empty-state">

                                    <div class="empty-state-icon">
                                        🚘
                                    </div>

                                    <h3>
                                        No Vehicles Found
                                    </h3>

                                    <p>
                                        Your vehicle fleet is currently empty.
                                        Click <strong>＋ Add Vehicle</strong>
                                        to register your first vehicle.
                                    </p>

                                </div>

                            </td>

                        </tr>


                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>


        </section>


        <!-- ================= FOOTER ================= -->

        <footer class="vehicle-footer">

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