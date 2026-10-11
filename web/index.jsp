<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>VehicleRental | Vehicle Rental Management System</title>

    <style>

        /* =====================================================
           GLOBAL
           ===================================================== */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f8fafc;
            color: #102a43;
            overflow-x: hidden;
        }

        a {
            text-decoration: none;
        }

        /* =====================================================
           NAVBAR
           ===================================================== */

        .navbar {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 100;
            padding: 22px 0;
        }

        .navbar-container {
            width: min(1200px, 92%);
            margin: auto;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;

            color: #ffffff;
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .logo-icon {
            width: 42px;
            height: 42px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background: rgba(255, 255, 255, 0.13);
            border: 1px solid rgba(255, 255, 255, 0.20);

            font-size: 21px;
        }

        .logo span {
            color: #60a5fa;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-link {
            color: #dbeafe;
            font-size: 14px;
            font-weight: 600;

            padding: 11px 17px;
            border-radius: 9px;

            transition: 0.25s ease;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.10);
            color: #ffffff;
        }

        .nav-login {
            color: #ffffff;

            padding: 11px 20px;

            border: 1px solid rgba(255, 255, 255, 0.35);
            border-radius: 9px;

            font-size: 14px;
            font-weight: 700;

            transition: 0.25s ease;
        }

        .nav-login:hover {
            background: #ffffff;
            color: #1d4ed8;
        }

        /* =====================================================
           HERO
           ===================================================== */

        .hero {
            position: relative;
            min-height: 720px;

            overflow: hidden;

            background:
                radial-gradient(
                    circle at 80% 25%,
                    rgba(59, 130, 246, 0.35),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 15% 80%,
                    rgba(37, 99, 235, 0.25),
                    transparent 28%
                ),
                linear-gradient(
                    135deg,
                    #071a33 0%,
                    #0b2850 45%,
                    #123b70 100%
                );

            color: #ffffff;
        }

        .hero::before {
            content: "";

            position: absolute;
            width: 500px;
            height: 500px;

            border-radius: 50%;

            right: -180px;
            top: 150px;

            background: rgba(96, 165, 250, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.06);
        }

        .hero::after {
            content: "";

            position: absolute;

            width: 350px;
            height: 350px;

            border-radius: 50%;

            left: -180px;
            bottom: -180px;

            background: rgba(37, 99, 235, 0.12);
        }

        .hero-container {
            position: relative;
            z-index: 2;

            width: min(1200px, 92%);
            margin: auto;

            min-height: 720px;

            display: grid;
            grid-template-columns: 1.05fr 0.95fr;
            align-items: center;

            gap: 60px;

            padding-top: 80px;
        }

        /* =====================================================
           HERO CONTENT
           ===================================================== */

        .hero-content {
            max-width: 650px;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;

            padding: 8px 14px;

            margin-bottom: 24px;

            border-radius: 30px;

            background: rgba(96, 165, 250, 0.14);
            border: 1px solid rgba(147, 197, 253, 0.25);

            color: #bfdbfe;

            font-size: 13px;
            font-weight: 700;
        }

        .status-dot {
            width: 8px;
            height: 8px;

            border-radius: 50%;

            background: #4ade80;

            box-shadow: 0 0 10px rgba(74, 222, 128, 0.7);
        }

        .hero h1 {
            font-size: clamp(44px, 5vw, 68px);

            line-height: 1.05;

            letter-spacing: -2px;

            margin-bottom: 24px;

            color: #ffffff;
        }

        .hero h1 span {
            color: #60a5fa;
        }

        .hero-description {
            max-width: 590px;

            color: #bfdbfe;

            font-size: 17px;
            line-height: 1.75;

            margin-bottom: 34px;
        }

        /* =====================================================
           HERO BUTTONS
           ===================================================== */

        .hero-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 13px;
        }

        .primary-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;

            min-width: 170px;

            padding: 15px 22px;

            border-radius: 10px;

            background: #2563eb;
            color: #ffffff;

            font-size: 15px;
            font-weight: 700;

            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.30);

            transition: all 0.25s ease;
        }

        .primary-btn:hover {
            background: #3b82f6;
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(37, 99, 235, 0.38);
        }

        .secondary-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;

            min-width: 170px;

            padding: 15px 22px;

            border-radius: 10px;

            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.22);

            color: #ffffff;

            font-size: 15px;
            font-weight: 700;

            transition: all 0.25s ease;
        }

        .secondary-btn:hover {
            background: #ffffff;
            color: #1d4ed8;
            transform: translateY(-3px);
        }

        /* =====================================================
           HERO TRUST
           ===================================================== */

        .hero-trust {
            display: flex;
            align-items: center;
            gap: 25px;

            margin-top: 38px;

            color: #93c5fd;

            font-size: 13px;
        }

        .trust-item {
            display: flex;
            align-items: center;
            gap: 7px;
        }

        .trust-icon {
            color: #60a5fa;
            font-size: 16px;
        }

        /* =====================================================
           VEHICLE VISUAL
           ===================================================== */

        .hero-visual {
            position: relative;

            min-height: 500px;

            display: flex;
            align-items: center;
            justify-content: center;
        }

        .vehicle-glow {
            position: absolute;

            width: 430px;
            height: 430px;

            border-radius: 50%;

            background:
                radial-gradient(
                    circle,
                    rgba(96, 165, 250, 0.24),
                    rgba(37, 99, 235, 0.04) 65%,
                    transparent 70%
                );
        }

        .vehicle-card {
            position: relative;
            z-index: 2;

            width: 430px;

            padding: 28px;

            border-radius: 25px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255, 255, 255, 0.14),
                    rgba(255, 255, 255, 0.05)
                );

            border: 1px solid rgba(255, 255, 255, 0.20);

            backdrop-filter: blur(15px);

            box-shadow:
                0 30px 70px rgba(0, 0, 0, 0.28);

            transform: rotate(2deg);

            transition: 0.4s ease;
        }

        .vehicle-card:hover {
            transform: rotate(0deg) translateY(-8px);
        }

        .vehicle-top {
            display: flex;
            align-items: center;
            justify-content: space-between;

            margin-bottom: 22px;
        }

        .vehicle-label {
            color: #bfdbfe;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .available-badge {
            padding: 6px 10px;

            border-radius: 20px;

            background: rgba(74, 222, 128, 0.14);
            color: #86efac;

            font-size: 11px;
            font-weight: 700;
        }

        .car-display {
            height: 220px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 18px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255, 255, 255, 0.11),
                    rgba(255, 255, 255, 0.03)
                );

            border: 1px solid rgba(255, 255, 255, 0.08);

            margin-bottom: 22px;
        }

        .car-emoji {
            font-size: 145px;

            filter:
                drop-shadow(
                    0 20px 25px rgba(0, 0, 0, 0.30)
                );
        }

        .vehicle-info {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .vehicle-name {
            color: #ffffff;

            font-size: 21px;
            font-weight: 800;

            margin-bottom: 5px;
        }

        .vehicle-type {
            color: #93c5fd;
            font-size: 13px;
        }

        .vehicle-price {
            text-align: right;
        }

        .price-value {
            color: #ffffff;
            font-size: 23px;
            font-weight: 800;
        }

        .price-label {
            color: #93c5fd;
            font-size: 11px;
        }

        /* =====================================================
           FLOATING CARD
           ===================================================== */

        .floating-card {
            position: absolute;
            z-index: 5;

            right: -15px;
            bottom: 55px;

            width: 185px;

            padding: 16px;

            border-radius: 15px;

            background: #ffffff;

            box-shadow:
                0 18px 40px rgba(0, 0, 0, 0.25);

            animation: floatCard 3s ease-in-out infinite;
        }

        @keyframes floatCard {

            0%, 100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-9px);
            }

        }

        .floating-title {
            color: #64748b;
            font-size: 11px;
            font-weight: 700;

            margin-bottom: 8px;
        }

        .floating-value {
            color: #102a43;

            font-size: 24px;
            font-weight: 800;
        }

        .floating-text {
            color: #64748b;

            font-size: 11px;

            margin-top: 4px;
        }

        /* =====================================================
           STATS
           ===================================================== */

        .stats-section {
            position: relative;
            z-index: 10;

            margin-top: -55px;
        }

        .stats-container {
            width: min(1100px, 92%);
            margin: auto;

            display: grid;
            grid-template-columns: repeat(4, 1fr);

            background: #ffffff;

            border-radius: 18px;

            box-shadow:
                0 15px 45px rgba(16, 42, 67, 0.12);

            border: 1px solid #e5e7eb;

            overflow: hidden;
        }

        .stat {
            padding: 25px 20px;

            text-align: center;

            border-right: 1px solid #e5e7eb;
        }

        .stat:last-child {
            border-right: none;
        }

        .stat-number {
            color: #1d4ed8;

            font-size: 28px;
            font-weight: 800;

            margin-bottom: 5px;
        }

        .stat-label {
            color: #64748b;

            font-size: 12px;
            font-weight: 600;
        }

        /* =====================================================
           FEATURES
           ===================================================== */

        .features-section {
            padding: 110px 0 90px;

            background: #ffffff;
        }

        .section-container {
            width: min(1150px, 92%);
            margin: auto;
        }

        .section-heading {
            text-align: center;

            max-width: 650px;

            margin: 0 auto 50px;
        }

        .section-tag {
            display: inline-block;

            padding: 7px 13px;

            margin-bottom: 13px;

            border-radius: 20px;

            background: #eff6ff;
            color: #2563eb;

            font-size: 12px;
            font-weight: 800;

            text-transform: uppercase;
            letter-spacing: 0.7px;
        }

        .section-heading h2 {
            color: #102a43;

            font-size: 38px;

            line-height: 1.2;

            margin-bottom: 13px;
        }

        .section-heading p {
            color: #627d98;

            font-size: 15px;

            line-height: 1.7;
        }

        .features-grid {
            display: grid;

            grid-template-columns: repeat(3, 1fr);

            gap: 22px;
        }

        .feature-card {
            padding: 30px;

            border-radius: 17px;

            background: #f8fafc;

            border: 1px solid #e5e7eb;

            transition: all 0.25s ease;
        }

        .feature-card:hover {
            background: #ffffff;

            transform: translateY(-6px);

            box-shadow:
                0 15px 35px rgba(16, 42, 67, 0.10);

            border-color: #bfdbfe;
        }

        .feature-icon {
            width: 52px;
            height: 52px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 13px;

            background: #dbeafe;

            font-size: 24px;

            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #102a43;

            font-size: 18px;

            margin-bottom: 10px;
        }

        .feature-card p {
            color: #627d98;

            font-size: 14px;

            line-height: 1.7;
        }

        /* =====================================================
           PORTALS
           ===================================================== */

        .portal-section {
            padding: 90px 0;

            background: #f1f5f9;
        }

        .portal-grid {
            display: grid;

            grid-template-columns: repeat(2, 1fr);

            gap: 25px;
        }

        .portal-card {
            position: relative;

            padding: 38px;

            border-radius: 20px;

            overflow: hidden;

            color: #ffffff;
        }

        .customer-portal {
            background:
                linear-gradient(
                    135deg,
                    #1d4ed8,
                    #2563eb,
                    #3b82f6
                );
        }

        .admin-portal {
            background:
                linear-gradient(
                    135deg,
                    #111827,
                    #1e293b,
                    #334155
                );
        }

        .portal-card::after {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            border-radius: 50%;

            right: -60px;
            top: -70px;

            background: rgba(255, 255, 255, 0.08);
        }

        .portal-icon {
            font-size: 35px;

            margin-bottom: 20px;
        }

        .portal-card h3 {
            font-size: 25px;

            margin-bottom: 10px;
        }

        .portal-card p {
            max-width: 470px;

            color: #dbeafe;

            font-size: 14px;

            line-height: 1.7;

            margin-bottom: 25px;
        }

        .portal-button {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            padding: 12px 20px;

            border-radius: 9px;

            background: #ffffff;

            color: #1d4ed8;

            font-size: 14px;
            font-weight: 800;

            transition: 0.25s ease;
        }

        .portal-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 8px 20px rgba(0, 0, 0, 0.20);
        }

        .admin-portal .portal-button {
            color: #111827;
        }

        /* =====================================================
           CTA
           ===================================================== */

        .cta-section {
            padding: 90px 0;
            background: #ffffff;
        }

        .cta-box {
            position: relative;

            overflow: hidden;

            padding: 55px 45px;

            border-radius: 24px;

            text-align: center;

            background:
                linear-gradient(
                    135deg,
                    #0f2d52,
                    #1d4ed8
                );

            box-shadow:
                0 20px 50px rgba(29, 78, 216, 0.20);
        }

        .cta-box::before {
            content: "";

            position: absolute;

            width: 300px;
            height: 300px;

            border-radius: 50%;

            left: -130px;
            top: -180px;

            background: rgba(255, 255, 255, 0.06);
        }

        .cta-box h2 {
            position: relative;

            color: #ffffff;

            font-size: 34px;

            margin-bottom: 12px;
        }

        .cta-box p {
            position: relative;

            max-width: 650px;

            margin: 0 auto 25px;

            color: #bfdbfe;

            font-size: 15px;

            line-height: 1.7;
        }

        .cta-button {
            position: relative;

            display: inline-flex;

            padding: 14px 25px;

            border-radius: 9px;

            background: #ffffff;

            color: #1d4ed8;

            font-size: 15px;
            font-weight: 800;

            transition: 0.25s ease;
        }

        .cta-button:hover {
            transform: translateY(-3px);

            box-shadow:
                0 12px 25px rgba(0, 0, 0, 0.20);
        }

        /* =====================================================
           FOOTER
           ===================================================== */

        .footer {
            padding: 28px 0;

            background: #071a33;

            color: #94a3b8;
        }

        .footer-container {
            width: min(1150px, 92%);
            margin: auto;

            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 20px;
        }

        .footer-brand {
            color: #ffffff;

            font-size: 16px;
            font-weight: 800;
        }

        .footer-brand span {
            color: #60a5fa;
        }

        .footer-text {
            font-size: 12px;
        }

        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 1000px) {

            .hero-container {
                grid-template-columns: 1fr;

                text-align: center;

                padding-top: 120px;
                padding-bottom: 70px;
            }

            .hero-content {
                margin: auto;
            }

            .hero-description {
                margin-left: auto;
                margin-right: auto;
            }

            .hero-buttons,
            .hero-trust {
                justify-content: center;
            }

            .hero-visual {
                min-height: 430px;
            }

            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }

            .stat:nth-child(2) {
                border-right: none;
            }

            .stat:nth-child(-n+2) {
                border-bottom: 1px solid #e5e7eb;
            }

        }

        @media (max-width: 800px) {

            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .portal-grid {
                grid-template-columns: 1fr;
            }

            .section-heading h2 {
                font-size: 32px;
            }

        }

        @media (max-width: 600px) {

            .navbar {
                position: absolute;
            }

            .nav-link {
                display: none;
            }

            .hero {
                min-height: auto;
            }

            .hero-container {
                min-height: auto;

                padding-top: 125px;
                padding-bottom: 70px;
            }

            .hero h1 {
                font-size: 42px;

                letter-spacing: -1.5px;
            }

            .hero-description {
                font-size: 15px;
            }

            .hero-buttons {
                flex-direction: column;
            }

            .primary-btn,
            .secondary-btn {
                width: 100%;
            }

            .hero-trust {
                flex-direction: column;
                gap: 10px;
            }

            .vehicle-card {
                width: 100%;

                transform: none;
            }

            .vehicle-card:hover {
                transform: translateY(-5px);
            }

            .floating-card {
                right: -5px;
                bottom: 25px;
            }

            .car-display {
                height: 190px;
            }

            .car-emoji {
                font-size: 110px;
            }

            .stats-section {
                margin-top: -25px;
            }

            .stats-container {
                grid-template-columns: 1fr 1fr;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .portal-card {
                padding: 30px;
            }

            .cta-box {
                padding: 40px 25px;
            }

            .cta-box h2 {
                font-size: 28px;
            }

            .footer-container {
                flex-direction: column;

                text-align: center;
            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     NAVBAR
     ========================================================= -->

<header class="navbar">

    <div class="navbar-container">

        <a href="<%= request.getContextPath() %>/"
           class="logo">

            <div class="logo-icon">
                🚗
            </div>

            Vehicle<span>Rental</span>

        </a>


        <div class="nav-actions">

            <a href="<%= request.getContextPath() %>/login.jsp"
               class="nav-link">

                Customer Login

            </a>

            <a href="<%= request.getContextPath() %>/admin-login.jsp"
               class="nav-login">

                Admin Login →

            </a>

        </div>

    </div>

</header>



<!-- =========================================================
     HERO SECTION
     ========================================================= -->

<section class="hero">

    <div class="hero-container">


        <!-- HERO CONTENT -->

        <div class="hero-content">

            <div class="hero-badge">

                <span class="status-dot"></span>

                Smart & Simple Vehicle Rental

            </div>


            <h1>

                Your Journey.

                <br>

                <span>Our Vehicles.</span>

            </h1>


            <p class="hero-description">

                A complete digital vehicle rental management system
                designed to make vehicle booking, payments, rentals,
                returns, and fleet management simple and efficient.

            </p>


            <div class="hero-buttons">

                <a href="<%= request.getContextPath() %>/login.jsp"
                   class="primary-btn">

                    🚗 Explore Vehicles →

                </a>


                <a href="<%= request.getContextPath() %>/register.jsp"
                   class="secondary-btn">

                    Create Account

                </a>

            </div>


            <div class="hero-trust">

                <div class="trust-item">

                    <span class="trust-icon">✓</span>

                    Easy Booking

                </div>


                <div class="trust-item">

                    <span class="trust-icon">✓</span>

                    Secure Payments

                </div>


                <div class="trust-item">

                    <span class="trust-icon">✓</span>

                    Complete Rental Tracking

                </div>

            </div>

        </div>



        <!-- VEHICLE VISUAL -->

        <div class="hero-visual">

            <div class="vehicle-glow"></div>


            <div class="vehicle-card">

                <div class="vehicle-top">

                    <span class="vehicle-label">
                        FEATURED VEHICLE
                    </span>

                    <span class="available-badge">
                        ● AVAILABLE
                    </span>

                </div>


                <div class="car-display">

                    <div class="car-emoji">
                        🚙
                    </div>

                </div>


                <div class="vehicle-info">

                    <div>

                        <div class="vehicle-name">
                            Premium SUV
                        </div>

                        <div class="vehicle-type">
                            Comfortable • Reliable • Ready
                        </div>

                    </div>


                    <div class="vehicle-price">

                        <div class="price-value">
                            ₹2,500
                        </div>

                        <div class="price-label">
                            PER DAY
                        </div>

                    </div>

                </div>

            </div>


            <div class="floating-card">

                <div class="floating-title">
                    RENTAL EXPERIENCE
                </div>

                <div class="floating-value">
                    24/7
                </div>

                <div class="floating-text">
                    Simple & convenient vehicle management
                </div>

            </div>

        </div>

    </div>

</section>



<!-- =========================================================
     STATS
     ========================================================= -->

<section class="stats-section">

    <div class="stats-container">


        <div class="stat">

            <div class="stat-number">
                5+
            </div>

            <div class="stat-label">
                Vehicle Categories
            </div>

        </div>


        <div class="stat">

            <div class="stat-number">
                100%
            </div>

            <div class="stat-label">
                Digital Management
            </div>

        </div>


        <div class="stat">

            <div class="stat-number">
                24/7
            </div>

            <div class="stat-label">
                System Availability
            </div>

        </div>


        <div class="stat">

            <div class="stat-number">
                1
            </div>

            <div class="stat-label">
                Centralized Platform
            </div>

        </div>

    </div>

</section>



<!-- =========================================================
     FEATURES
     ========================================================= -->

<section class="features-section">

    <div class="section-container">


        <div class="section-heading">

            <div class="section-tag">
                Powerful Features
            </div>

            <h2>
                Everything You Need in One Platform
            </h2>

            <p>
                From finding the right vehicle to completing a rental,
                the system manages the complete rental lifecycle
                through one centralized platform.
            </p>

        </div>


        <div class="features-grid">


            <div class="feature-card">

                <div class="feature-icon">
                    🚗
                </div>

                <h3>
                    Vehicle Management
                </h3>

                <p>
                    Manage vehicle details, categories, rental rates,
                    availability, and vehicle status from one place.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon">
                    📅
                </div>

                <h3>
                    Easy Booking
                </h3>

                <p>
                    Customers can browse vehicles, select rental
                    dates, and make bookings through a simple interface.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon">
                    💳
                </div>

                <h3>
                    Payment Management
                </h3>

                <p>
                    Track rental payments, payment status, methods,
                    transaction details, and payment history.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon">
                    🔑
                </div>

                <h3>
                    Vehicle Handover
                </h3>

                <p>
                    Admins can manage vehicle handovers and activate
                    rentals after successful booking and payment.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon">
                    🔄
                </div>

                <h3>
                    Return Management
                </h3>

                <p>
                    Record vehicle returns, odometer readings,
                    late fees, damages, and additional charges.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon">
                    📊
                </div>

                <h3>
                    Rental History
                </h3>

                <p>
                    Customers and administrators can view complete
                    rental, return, and payment history.
                </p>

            </div>

        </div>

    </div>

</section>



<!-- =========================================================
     PORTALS
     ========================================================= -->

<section class="portal-section">

    <div class="section-container">


        <div class="section-heading">

            <div class="section-tag">
                Choose Your Portal
            </div>

            <h2>
                Built for Customers & Administrators
            </h2>

            <p>
                Two dedicated portals make it easy for customers
                and administrators to access exactly what they need.
            </p>

        </div>


        <div class="portal-grid">


            <!-- CUSTOMER -->

            <div class="portal-card customer-portal">

                <div class="portal-icon">
                    👤
                </div>

                <h3>
                    Customer Portal
                </h3>

                <p>
                    Browse available vehicles, make rental bookings,
                    manage payments, view rental history, and track
                    vehicle returns from your personal dashboard.
                </p>

                <a href="<%= request.getContextPath() %>/login.jsp"
                   class="portal-button">

                    Customer Login →

                </a>

            </div>


            <!-- ADMIN -->

            <div class="portal-card admin-portal">

                <div class="portal-icon">
                    🛡️
                </div>

                <h3>
                    Admin Portal
                </h3>

                <p>
                    Manage vehicles, categories, bookings, payments,
                    vehicle handovers, returns, and overall system
                    operations through the administration panel.
                </p>

                <a href="<%= request.getContextPath() %>/admin-login.jsp"
                   class="portal-button">

                    Admin Login →

                </a>

            </div>

        </div>

    </div>

</section>



<!-- =========================================================
     CALL TO ACTION
     ========================================================= -->

<section class="cta-section">

    <div class="section-container">

        <div class="cta-box">

            <h2>
                Ready to Start Your Journey?
            </h2>

            <p>
                Find your vehicle, choose your rental dates,
                and experience a simple digital rental process.
            </p>

            <a href="<%= request.getContextPath() %>/register.jsp"
               class="cta-button">

                Get Started Today →

            </a>

        </div>

    </div>

</section>



<!-- =========================================================
     FOOTER
     ========================================================= -->

<footer class="footer">

    <div class="footer-container">

        <div class="footer-brand">

            Vehicle<span>Rental</span>

        </div>


        <div class="footer-text">

            Vehicle Rental Management System

            &nbsp;•&nbsp;

            JSP • Servlets • JDBC • MySQL

        </div>


        <div class="footer-text">

            © 2026 All Rights Reserved

        </div>

    </div>

</footer>


</body>

</html>