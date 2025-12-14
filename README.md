📚 Student Track Management System (Java EE)

This is a complete, full-stack web application developed using Java EE (Servlets & JSPs) and MySQL for backend database management. The system is designed to handle core student administrative tasks, including registration, secure login, image streaming, and fee status tracking.

✨ Key Features

Student Registration: Secure submission of student details and authentication credentials.

Secure Login: Separate login portals for students and administrators.

Real-time Fee Tracking: Students can view their current balance due, total fees, and payment status in real-time by querying the database.

Payment Simulation: Includes a feature to "mock pay" fees, updating the database status from PENDING to PAID.

Dynamic Image Streaming: Uses a dedicated ImageServlet to serve profile pictures directly from the database (via a BLOB or file path storage model) to the frontend, improving security and performance.

Database Integration: Utilizes MySQL for persistent data storage, managed via a DBConnection pool (or similar utility) and comprehensive Data Access Objects (DAOs).

🛠️ Technology Stack

Category

Technology

Description

Backend

Java EE (Servlets)

Core business logic and request handling.

Frontend

JSP (JavaServer Pages)

Dynamic presentation layer.

Database

MySQL

Persistent storage for student and fee records.

Styling

HTML5, CSS3

Clean, responsive UI for admin and student dashboards.

Data Access

JDBC & DAO Pattern

Robust data access layer (StudentDAO, FeeDAO).

🚀 Setup and Installation Guide

To run this project locally on your machine, follow these steps:

1. Database Setup (MySQL)

You must first create the required database and tables.

Create Database:

CREATE DATABASE IF NOT EXISTS student_management_db;
USE student_management_db;


Create Tables:

-- Table for student basic and login information
CREATE TABLE IF NOT EXISTS student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    enrollment_date DATE
);

-- Table for fee tracking
CREATE TABLE IF NOT EXISTS fee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNIQUE NOT NULL,
    session_year VARCHAR(10) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    amount_paid DECIMAL(10, 2) DEFAULT 0.00,
    payment_status VARCHAR(20) DEFAULT 'UNPAID', -- e.g., 'PAID', 'PENDING'
    last_payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES student(id)
);


Update DB Connection: Ensure your DBConnection.java file has the correct database name, username, and password for your local MySQL instance.

2. Project Setup (Eclipse & Tomcat)

Clone the Repository:

git clone [https://github.com/prakratis/Student-Track-Magement-System-Java-EE.git](https://github.com/prakratis/Student-Track-Magement-System-Java-EE.git)


Import into Eclipse:

Open Eclipse.

Go to File -> Import...

Select Existing Maven Projects or General > Existing Projects into Workspace and select the cloned directory.

Configure Tomcat Server:

Ensure you have Apache Tomcat (v9 or later recommended) configured in Eclipse.

Add the StudentTrackManagement project to your Tomcat server.

Run:

Start the Tomcat server.

Access the application in your browser, typically at: http://localhost:8080/StudentTrackManagement/ (or similar).

🗃️ Project Structure Overview

StudentTrackManagement/
├── src/main/java/com/
│   ├── Admin.java
│   ├── AdminAction.java
│   ├── AdminDAO.java
│   ├── AdminLoginServlet.java
│   ├── DBConnection.java       <-- Database Connection Utility
│   ├── Fee.java                <-- Fee Model
│   ├── FeeDAO.java             <-- Fee Database Logic
│   ├── FeeStatusServlet.java   <-- Handles Fee Lookups
│   ├── ImageServlet.java       <-- Handles Image Streaming
│   ├── RegisterServlet.java
│   ├── Student.java
│   └── StudentDAO.java
└── src/main/webapp/
    ├── admin-dashboard.jsp
    ├── admin-login.jsp
    ├── common-login.jsp
    ├── fees-status.jsp         <-- Key feature for viewing fees
    ├── index.jsp               <-- Main entry point
    └── registration.jsp
