\# 🚗 Vehicle Rental Management System



A web-based Vehicle Rental Management System developed using \*\*JSP, Servlets, JDBC, MySQL, HTML, CSS and JavaScript\*\*.



The system provides separate portals for customers and administrators to manage the complete vehicle rental lifecycle — from vehicle browsing and booking to payment, vehicle handover, return processing and rental history.



\---



\## 📌 Project Overview



The Vehicle Rental Management System is designed to digitize and simplify vehicle rental operations.



Customers can:



\- Create an account

\- Login securely

\- Browse available vehicles

\- Search vehicles

\- Check vehicle availability

\- Book vehicles

\- Make simulated payments

\- View booking history

\- View rental history

\- View payment history

\- View return history

\- Manage their profile



Administrators can:



\- Login through a dedicated admin portal

\- View dashboard statistics

\- Manage vehicles

\- Add vehicles

\- Edit vehicles

\- Delete vehicles

\- Manage vehicle categories

\- Update rental rates

\- Manage customer bookings

\- Verify payment status

\- Perform vehicle handover

\- Process vehicle returns

\- Record return charges

\- View payment history

\- Monitor rental operations



\---



\## ✨ Key Features



\### 👤 Customer Module



\- Customer Registration

\- Customer Login

\- Customer Dashboard

\- Vehicle Search

\- Vehicle Availability Checking

\- Vehicle Booking

\- Booking Date Validation

\- Overlapping Booking Prevention

\- Simulated Payment

\- Payment History

\- Rental History

\- Return History

\- Customer Profile Management

\- Secure Logout



\### 🛡️ Admin Module



\- Admin Login

\- Admin Dashboard

\- Vehicle Management

\- Add Vehicle

\- Edit Vehicle

\- Delete Vehicle

\- Category Management

\- Rental Rate Management

\- Booking Management

\- Payment History

\- Vehicle Handover

\- Vehicle Return Management

\- Return Charges

\- Rental Status Management

\- Secure Admin Logout



\---



\## 🔄 Rental Lifecycle



The system follows a complete rental lifecycle:



```text

Vehicle Available

&#x20;       ↓

Customer Booking

&#x20;       ↓

Booking Confirmed

&#x20;       ↓

Payment

&#x20;       ↓

Admin Vehicle Handover

&#x20;       ↓

Rental Active

&#x20;       ↓

Vehicle Return

&#x20;       ↓

Rental Completed

&#x20;       ↓

Vehicle Available Again



Vehicle Status

AVAILABLE

&#x20;   ↓

RENTED

&#x20;   ↓

AVAILABLE



Rental Status

BOOKED

&#x20;  ↓

ACTIVE

&#x20;  ↓

COMPLETED



🏗️ System Architecture

The project follows a layered web application architecture.

&#x20;               ┌──────────────────────┐

&#x20;               │     User / Admin     │

&#x20;               └──────────┬───────────┘

&#x20;                          │

&#x20;                          ↓

&#x20;               ┌──────────────────────┐

&#x20;               │     JSP / HTML / CSS │

&#x20;               │     User Interface   │

&#x20;               └──────────┬───────────┘

&#x20;                          │

&#x20;                          ↓

&#x20;               ┌──────────────────────┐

&#x20;               │       Servlets       │

&#x20;               │  Business Processing │

&#x20;               └──────────┬───────────┘

&#x20;                          │

&#x20;                          ↓

&#x20;               ┌──────────────────────┐

&#x20;               │         DAO          │

&#x20;               │ Database Operations  │

&#x20;               └──────────┬───────────┘

&#x20;                          │

&#x20;                          ↓

&#x20;               ┌──────────────────────┐

&#x20;               │         JDBC         │

&#x20;               └──────────┬───────────┘

&#x20;                          │

&#x20;                          ↓

&#x20;               ┌──────────────────────┐

&#x20;               │        MySQL         │

&#x20;               │       Database       │

&#x20;               └──────────────────────┘



🛠️ Technologies Used

Frontend

\- HTML5

\- CSS3

\- JavaScript

\- JSP

Backend

\- Java

\- Java Servlets

\- JDBC

Database

\- MySQL

Server

\- Apache Tomcat 9

Development Tools

\- Apache NetBeans

\- JDK 21

\- MySQL Workbench

\- Git

\- GitHub

Security

\- BCrypt password hashing

\- HTTP Session based authentication

\- Customer/Admin access separation

🗄️ Database

The application uses a MySQL database named:

vehicle\_rental\_db



Major database entities include:

\- Customers

\- Admins

\- Vehicles

\- Vehicle Categories

\- Rentals

\- Payments

\- Returns

These entities support the complete vehicle rental lifecycle.

📂 Project Structure

VehicleRentalSystem/

│

├── src/

│   └── java/

│       └── com/

│           └── vehiclerental/

│               ├── dao/

│               ├── model/

│               ├── servlet/

│               └── util/

│

├── web/

│   ├── css/

│   │   └── style.css

│   │

│   ├── index.jsp

│   ├── login.jsp

│   ├── register.jsp

│   ├── dashboard.jsp

│   ├── vehicles.jsp

│   ├── booking.jsp

│   ├── my-bookings.jsp

│   ├── payment.jsp

│   ├── payment-history.jsp

│   ├── rental-history.jsp

│   ├── return-history.jsp

│   ├── customer-profile.jsp

│   │

│   ├── admin-login.jsp

│   ├── admin-dashboard.jsp

│   ├── admin-vehicles.jsp

│   ├── admin-add-vehicle.jsp

│   ├── admin-edit-vehicle.jsp

│   ├── admin-categories.jsp

│   ├── admin-bookings.jsp

│   ├── admin-returns.jsp

│   └── admin-payments.jsp

│

├── nbproject/

│

├── pom.xml

│

└── README.md



🚀 How to Run the Project

Prerequisites

Install the following:

\- JDK 21

\- Apache NetBeans

\- Apache Tomcat 9

\- MySQL Server

\- MySQL Workbench

\- Git

1\. Clone the Repository

git clone https://github.com/abhinesh-59/VehicleRentalSystem.git



Navigate into the project:

cd VehicleRentalSystem



2\. Configure MySQL

Create the database:

CREATE DATABASE vehicle\_rental\_db;



Create/import the required tables and sample data.

Update the database connection configuration according to your local MySQL credentials.

3\. Open the Project

Open the project in Apache NetBeans.

Configure:

JDK 21

Apache Tomcat 9



4\. Build the Project

Use:

Clean and Build



from NetBeans.

5\. Run the Application

Start the project using Apache Tomcat.

The application will be available at:

http://localhost:8080/VehicleRentalSystem/



🔐 Application Portals

Customer Portal

http://localhost:8080/VehicleRentalSystem/login.jsp



Customers can register and login through the customer portal.

Admin Portal

http://localhost:8080/VehicleRentalSystem/admin-login.jsp



Administrators can access the management dashboard.

💳 Payment

The current payment module is implemented as a simulated payment system for academic and demonstration purposes.

Supported payment methods include:

\- UPI

\- Card

\- Net Banking

\- Cash

No real financial transaction is performed.

🔒 Security Features

The application implements:

\- BCrypt password hashing

\- Customer authentication

\- Admin authentication

\- Session management

\- Protected customer pages

\- Protected admin pages

\- Customer/Admin access separation

\- Secure logout

\- Prepared statements for database queries

📊 Admin Dashboard

The administrator dashboard provides statistics such as:

\- Total Vehicles

\- Total Customers

\- Total Bookings

\- Active Rentals

\- Completed Rentals

\- Recorded Paid Amount

🎯 Project Objectives

The main objectives of the project are:

1\. Digitize vehicle rental operations.

2\. Simplify vehicle booking for customers.

3\. Provide centralized vehicle management.

4\. Reduce manual rental management.

5\. Maintain rental and payment records.

6\. Track vehicle handover and return.

7\. Provide separate customer and administrator portals.

8\. Improve rental process transparency and efficiency.

🔮 Future Enhancements

Possible future improvements include:

\- Real online payment gateway integration

\- Email/SMS booking notifications

\- GPS-based vehicle tracking

\- Mobile application

\- Advanced analytics dashboard

\- Automated invoice generation

\- Cloud deployment

\- AI-based vehicle recommendation

\- Online document verification

\- Multi-branch rental management

👨‍💻 Developer

Vehicle Rental Management System

Developed as an academic software engineering project using Java web technologies and MySQL.

📜 License

This project is developed for educational and academic purposes.

