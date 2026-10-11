<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.vehiclerental.dao.AdminCategoryDAO.CategoryRecord"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    List<CategoryRecord> categories =
        (List<CategoryRecord>) request.getAttribute("categories");

    String result = request.getParameter("result");

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Category Management | Admin</title>

    <link rel="stylesheet"
          href="<%= context %>/css/style.css">


    <style>

        /* =====================================================
           CATEGORY MANAGEMENT PAGE
           ===================================================== */

        .category-admin-page {

            width: min(1200px, 94%) !important;

            margin: 0 auto !important;

            padding: 50px 0 80px !important;
        }


        /* =====================================================
           NAVBAR
           ===================================================== */

        .category-admin-navbar {

            background: #102a43 !important;

            min-height: 72px !important;
        }


        .category-admin-navbar .navbar-inner {

            width: min(1280px, 94%) !important;

            margin: 0 auto !important;
        }


        .category-admin-navbar .logo {

            font-size: 22px !important;

            font-weight: 800 !important;
        }


        .category-admin-navbar .logo span {

            color: #60a5fa !important;
        }


        .category-admin-navbar .nav-links a {

            font-size: 15px !important;
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .back-dashboard {

            display: inline-block !important;

            color: #2563eb !important;

            text-decoration: none !important;

            font-size: 17px !important;

            font-weight: 700 !important;

            margin-bottom: 30px !important;
        }


        .back-dashboard:hover {

            text-decoration: underline !important;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .category-page-header {

            margin-bottom: 35px !important;
        }


        .category-page-header h1 {

            margin: 0 0 12px !important;

            color: #102a43 !important;

            font-size: 40px !important;

            line-height: 1.2 !important;

            font-weight: 800 !important;
        }


        .category-page-header p {

            margin: 0 !important;

            color: #627d98 !important;

            font-size: 18px !important;

            line-height: 1.7 !important;
        }


        /* =====================================================
           MAIN PANEL
           ===================================================== */

        .category-panel {

            background: #ffffff !important;

            border: 1px solid #d9e2ec !important;

            border-radius: 22px !important;

            padding: 40px !important;

            box-shadow:
                0 12px 35px rgba(16, 42, 67, 0.10) !important;
        }


        /* =====================================================
           PANEL HEADER
           ===================================================== */

        .category-panel-heading {

            display: flex !important;

            align-items: center !important;

            justify-content: space-between !important;

            gap: 20px !important;

            margin-bottom: 30px !important;

            padding-bottom: 28px !important;

            border-bottom: 1px solid #d9e2ec !important;
        }


        .category-heading-left {

            display: flex !important;

            align-items: center !important;

            gap: 20px !important;
        }


        .category-heading-icon {

            width: 70px !important;

            height: 70px !important;

            display: flex !important;

            align-items: center !important;

            justify-content: center !important;

            background: #eef4ff !important;

            border-radius: 17px !important;

            font-size: 35px !important;

            flex-shrink: 0 !important;
        }


        .category-panel-heading h2 {

            margin: 0 0 8px !important;

            color: #102a43 !important;

            font-size: 30px !important;

            font-weight: 800 !important;
        }


        .category-panel-heading p {

            margin: 0 !important;

            color: #627d98 !important;

            font-size: 17px !important;
        }


        .category-count {

            background: #eef4ff !important;

            color: #1d4ed8 !important;

            padding: 10px 17px !important;

            border-radius: 22px !important;

            font-size: 14px !important;

            font-weight: 800 !important;

            white-space: nowrap !important;
        }


        /* =====================================================
           MESSAGES
           ===================================================== */

        .category-message {

            padding: 18px 20px !important;

            margin-bottom: 30px !important;

            border-radius: 12px !important;

            font-size: 16px !important;

            font-weight: 600 !important;

            border: 1px solid transparent !important;
        }


        .category-message.success {

            background: #ecfdf3 !important;

            color: #166534 !important;

            border-color: #bbf7d0 !important;
        }


        .category-message.error {

            background: #fff1f2 !important;

            color: #991b1b !important;

            border-color: #fecdd3 !important;
        }


        /* =====================================================
           TABLE
           ===================================================== */

        .category-table-wrapper {

            width: 100% !important;

            overflow-x: auto !important;

            border: 1px solid #d9e2ec !important;

            border-radius: 15px !important;
        }


        .category-table {

            width: 100% !important;

            min-width: 850px !important;

            border-collapse: collapse !important;
        }


        .category-table thead {

            background: #f1f5ff !important;
        }


        .category-table th {

            padding: 18px 17px !important;

            text-align: left !important;

            color: #24476b !important;

            font-size: 14px !important;

            font-weight: 800 !important;

            border-bottom: 1px solid #dbe5f0 !important;

            white-space: nowrap !important;
        }


        .category-table td {

            padding: 20px 17px !important;

            color: #334e68 !important;

            font-size: 16px !important;

            border-bottom: 1px solid #edf2f7 !important;

            vertical-align: middle !important;
        }


        .category-table tbody tr {

            transition: background 0.2s ease !important;
        }


        .category-table tbody tr:hover {

            background: #f8fbff !important;
        }


        .category-table tbody tr:last-child td {

            border-bottom: none !important;
        }


        /* =====================================================
           CATEGORY ID
           ===================================================== */

        .category-id {

            color: #829ab1 !important;

            font-weight: 700 !important;
        }


        /* =====================================================
           CATEGORY NAME
           ===================================================== */

        .category-name {

            color: #102a43 !important;

            font-size: 17px !important;

            font-weight: 800 !important;
        }


        /* =====================================================
           RATE
           ===================================================== */

        .current-rate {

            color: #15803d !important;

            font-size: 18px !important;

            font-weight: 800 !important;

            white-space: nowrap !important;
        }


        /* =====================================================
           UPDATE FORM
           ===================================================== */

        .category-update-form {

            display: flex !important;

            align-items: center !important;

            gap: 12px !important;

            min-width: 310px !important;

            margin: 0 !important;
        }


        .category-rate-input {

            width: 145px !important;

            height: 50px !important;

            padding: 12px 14px !important;

            border: 1px solid #bcccdc !important;

            border-radius: 10px !important;

            background: #ffffff !important;

            color: #243b53 !important;

            font-family: Arial, sans-serif !important;

            font-size: 16px !important;

            font-weight: 600 !important;

            outline: none !important;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease !important;
        }


        .category-rate-input:focus {

            border-color: #2563eb !important;

            box-shadow:
                0 0 0 4px rgba(37, 99, 235, 0.12) !important;
        }


        .update-category-btn {

            height: 50px !important;

            padding: 12px 20px !important;

            border: none !important;

            border-radius: 10px !important;

            background: #2563eb !important;

            color: #ffffff !important;

            font-family: Arial, sans-serif !important;

            font-size: 15px !important;

            font-weight: 700 !important;

            cursor: pointer !important;

            transition: all 0.2s ease !important;

            white-space: nowrap !important;

            box-shadow:
                0 5px 14px rgba(37, 99, 235, 0.18) !important;
        }


        .update-category-btn:hover {

            background: #1d4ed8 !important;

            transform: translateY(-2px) !important;

            box-shadow:
                0 8px 18px rgba(37, 99, 235, 0.25) !important;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .category-empty {

            text-align: center !important;

            padding: 60px 25px !important;

            color: #627d98 !important;
        }


        .category-empty-icon {

            font-size: 48px !important;

            margin-bottom: 15px !important;
        }


        .category-empty h3 {

            margin: 0 0 10px !important;

            color: #334e68 !important;

            font-size: 22px !important;
        }


        .category-empty p {

            margin: 0 !important;

            font-size: 16px !important;
        }


        /* =====================================================
           NOTE
           ===================================================== */

        .category-note {

            margin-top: 25px !important;

            padding: 18px 20px !important;

            background: #f8fafc !important;

            border-left: 4px solid #2563eb !important;

            border-radius: 8px !important;

            color: #627d98 !important;

            font-size: 15px !important;

            line-height: 1.7 !important;
        }


        .category-note strong {

            color: #334e68 !important;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .category-footer {

            text-align: center !important;

            color: #829ab1 !important;

            font-size: 15px !important;

            margin-top: 50px !important;

            padding-top: 28px !important;

            border-top: 1px solid #d9e2ec !important;
        }


        .category-footer strong {

            color: #486581 !important;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 800px) {

            .category-panel-heading {

                align-items: flex-start !important;

                flex-direction: column !important;
            }

            .category-count {

                align-self: flex-start !important;
            }
        }


        @media (max-width: 600px) {

            .category-admin-page {

                width: 92% !important;

                padding-top: 30px !important;
            }


            .category-page-header h1 {

                font-size: 32px !important;
            }


            .category-page-header p {

                font-size: 16px !important;
            }


            .category-panel {

                padding: 25px 18px !important;
            }


            .category-heading-left {

                align-items: flex-start !important;
            }


            .category-panel-heading h2 {

                font-size: 25px !important;
            }


            .category-panel-heading p {

                font-size: 15px !important;
            }


            .category-update-form {

                flex-direction: column !important;

                align-items: stretch !important;

                min-width: 200px !important;
            }


            .category-rate-input,
            .update-category-btn {

                width: 100% !important;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVIGATION
     ===================================================== -->

<nav class="navbar category-admin-navbar">

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


<!-- =====================================================
     MAIN CONTENT
     ===================================================== -->

<main class="category-admin-page">


    <!-- BACK -->

    <a class="back-dashboard"
       href="<%= context %>/admin-dashboard">

        ← Back to Admin Dashboard

    </a>


    <!-- PAGE HEADER -->

    <section class="category-page-header">

        <h1>
            Category Management
        </h1>

        <p>
            Manage vehicle categories and configure their daily rental rates.
        </p>

    </section>


    <!-- =================================================
         MAIN PANEL
         ================================================= -->

    <section class="category-panel">


        <!-- PANEL HEADING -->

        <div class="category-panel-heading">

            <div class="category-heading-left">

                <div class="category-heading-icon">
                    🏷️
                </div>

                <div>

                    <h2>
                        Vehicle Categories
                    </h2>

                    <p>
                        View and update the pricing for each category.
                    </p>

                </div>

            </div>


            <div class="category-count">

                🏷️
                <%= categories == null ? 0 : categories.size() %>
                Categories

            </div>

        </div>


        <!-- =================================================
             RESULT MESSAGES
             ================================================= -->

        <% if ("updated".equals(result)) { %>

            <div class="category-message success">

                ✓ Daily rental rate updated successfully.

            </div>

        <% } else if ("invalid".equals(result)) { %>

            <div class="category-message error">

                ✕ Please enter a valid category and a rate greater than zero.

            </div>

        <% } else if ("error".equals(result)) { %>

            <div class="category-message error">

                ✕ Unable to update the rental rate. Please try again.

            </div>

        <% } %>


        <!-- =================================================
             CATEGORY TABLE
             ================================================= -->

        <div class="category-table-wrapper">

            <table class="category-table">


                <thead>

                    <tr>

                        <th>
                            Category ID
                        </th>

                        <th>
                            Category Name
                        </th>

                        <th>
                            Current Daily Rate
                        </th>

                        <th>
                            Update Daily Rate
                        </th>

                    </tr>

                </thead>


                <tbody>


                <% if (categories != null && !categories.isEmpty()) {

                       for (CategoryRecord category : categories) {
                %>


                    <tr>


                        <!-- CATEGORY ID -->

                        <td class="category-id">

                            #<%= category.getCategoryId() %>

                        </td>


                        <!-- CATEGORY NAME -->

                        <td class="category-name">

                            <%= category.getCategoryName() %>

                        </td>


                        <!-- CURRENT RATE -->

                        <td class="current-rate">

                            ₹<%= String.format(
                                "%.2f",
                                category.getDailyRate()
                            ) %>

                            / day

                        </td>


                        <!-- UPDATE -->

                        <td>

                            <form class="category-update-form"
                                  action="<%= context %>/admin-update-category"
                                  method="post">


                                <input type="hidden"
                                       name="categoryId"
                                       value="<%= category.getCategoryId() %>">


                                <input class="category-rate-input"
                                       type="number"
                                       name="dailyRate"
                                       min="0.01"
                                       step="0.01"
                                       value="<%= category.getDailyRate() %>"
                                       required>


                                <button class="update-category-btn"
                                        type="submit">

                                    ✓ Update Rate

                                </button>


                            </form>

                        </td>


                    </tr>


                <%
                       }

                   } else {
                %>


                    <tr>

                        <td colspan="4">

                            <div class="category-empty">

                                <div class="category-empty-icon">
                                    🏷️
                                </div>

                                <h3>
                                    No Vehicle Categories Found
                                </h3>

                                <p>
                                    There are currently no categories
                                    available in the system.
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


        <!-- =================================================
             INFORMATION NOTE
             ================================================= -->

        <div class="category-note">

            <strong>Note:</strong>

            Changing a category's daily rate affects the pricing
            used for vehicles in that category. Review the new
            rate carefully before updating it.

        </div>


    </section>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <footer class="category-footer">

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