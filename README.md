📚 Student Track Management System (Java EE)

This is a complete, full-stack web application developed using Java EE (Servlets & JSPs) and MySQL for backend database management. The system is designed to handle core student administrative tasks, including registration, secure login, image streaming, and fee status tracking.

🌟 Visual Showcase

Screen

Description

Login Page

The dual-role login page for students and administrators.





Student Dashboard

Where students access fee status and update their profile.





✨ Key Features

Student Registration & Secure Login: Implements separate authentication portals for students and system administrators.

Real-time Fee Tracking: Students can view their total fees, amount paid, and the current balance due in real-time.

Payment Simulation: Includes functionality to "mock pay" fees, adjusting the database status dynamically for testing.

Dynamic Image Streaming: Uses a dedicated ImageServlet to serve profile pictures stored in the database securely to the frontend.

Data Access Layer: Utilizes the Data Access Object (DAO) pattern (StudentDAO, FeeDAO) for robust and maintainable database interactions.

🛠️ Technology Stack

Category

Technology

Description

Backend

Java EE (Servlets)

Core business logic and request handling.

Frontend

JSP (JavaServer Pages)

Dynamic presentation layer using JSTL and EL.

Database

MySQL

Persistent storage for all application data.

Data Access

JDBC & DAO Pattern

Dedicated layer for clean SQL operations.

Server

Apache Tomcat

Application server for running the Java EE components.

🚀 Setup and Installation Guide

To run this project locally, you will need a Java EE environment (like Eclipse/IntelliJ), a MySQL server, and the JDBC driver.

1. Database Setup (MySQL)

Create Database and Tables:

CREATE DATABASE IF NOT EXISTS student_management_db;
USE student_management_db;
-- Student table definition
CREATE TABLE IF NOT EXISTS student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    -- ... other fields
);
-- Fee table definition
CREATE TABLE IF NOT EXISTS fee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNIQUE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    amount_paid DECIMAL(10, 2) DEFAULT 0.00,
    payment_status VARCHAR(20) DEFAULT 'UNPAID',
    FOREIGN KEY (student_id) REFERENCES student(id)
);


2. Configuration Details (Crucial Step)

You must update the database connection parameters in the src/main/java/com/DBConnection.java file.

Variable

Description

Default Example

DB_URL

JDBC URL for your MySQL instance.

jdbc:mysql://localhost:3306/student_management_db

DB_USERNAME

Your MySQL user (often root).

root

DB_PASSWORD

The password for your MySQL user.

mypassword123

3. Project Setup and Deployment

Clone the Repository:

git clone [https://github.com/prakratis/Student-Track-Magement-System-Java-EE.git](https://github.com/prakratis/Student-Track-Magement-System-Java-EE.git)


Install JDBC Driver: Ensure the appropriate MySQL Connector/J driver JAR is added to your project's build path (or placed in the Tomcat lib directory).

Import and Configure: Import the project into your IDE, ensure Tomcat (v9+) is configured, and deploy the project to the server.

Access: Navigate to http://localhost:8080/StudentTrackManagement/ (adjust port and context path if necessary).

🗃️ Project Structure Overview

StudentTrackManagement/
├── src/main/java/com/
│   ├── .../DBConnection.java       <-- DB Config
│   ├── .../ImageServlet.java       <-- Image Streaming Logic
│   ├── models/Fee.java             <-- Data Models
│   ├── models/Student.java         
│   ├── dao/FeeDAO.java             <-- Data Access Objects
│   └── dao/StudentDAO.java         
└── src/main/webapp/
    ├── admin-dashboard.jsp
    ├── common-login.jsp            <-- Unified Login Page
    └── fees-status.jsp             <-- Core Fee Display Feature


⚠️ Troubleshooting Common Issues

Issue

Solution

java.lang.ClassNotFoundException: com.mysql.cj.jdbc.Driver

The MySQL Connector/J JAR is missing. Download it and add it to your project's build path and/or the Tomcat server's lib folder.

Access denied for user 'root'@'localhost'

Check the DB_USERNAME and DB_PASSWORD variables in DBConnection.java. Ensure your MySQL server is running.

404 - The requested resource is not available

Verify that the project is correctly deployed to Tomcat and that the context path in your browser matches the project name (e.g., /StudentTrackManagement).

Fee Status shows ERROR_DB

This indicates the fee record retrieval failed. Check your SQL query in FeeDAO.java and confirm the student and fee tables are populated and the foreign key relationship is intact.

💡 Future Scope and Enhancements

Admin Panel: Implement a full CRUD (Create, Read, Update, Delete) interface for administrators to manage student and fee records directly.

Payment Gateway Integration: Integrate with a real payment gateway (e.g., Stripe, PayPal) instead of the mock payment feature.

Reporting: Generate printable PDF reports for fee summaries and student attendance using a library like iText.

Architecture: Transition from traditional Servlets/JSPs to a modern framework like Spring Boot for better modularity and RESTful API development.

📄 License

This project is licensed under the MIT License.

📧 Contact

For any questions or suggestions, please contact the author:

Name: Prakrati Saxena

Email: prakratisaxena032@gmail.com
