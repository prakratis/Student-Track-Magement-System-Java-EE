# 📚 Student Track Management System

A full-stack web application built using **Java EE (Servlets & JSPs)** and **MySQL**. This system streamlines student administration by managing registrations, secure authentication, and real-time financial tracking.

---

## 🌟 Visual Showcase

| Screen | Description |
| :--- | :--- |
| **Login Page** | Dual-role authentication portal for Students and Administrators. |
| **Student Dashboard** | Central hub for profile updates and real-time fee status overview. |

---

## ✨ Key Features

* **Secure Authentication:** Separate login logic for students and admins using session management.
* **Real-time Fee Tracking:** Instant calculation of `Total Fees`, `Amount Paid`, and `Remaining Balance`.
* **Dynamic Image Streaming:** Implements a custom `ImageServlet` to stream profile pictures directly from MySQL BLOB storage.
* **DAO Architecture:** Utilizes the **Data Access Object** pattern for clean, maintainable SQL operations.
* **Mock Payment System:** Integrated testing feature to simulate fee payments and observe dynamic database updates.

---

## 🛠️ Technology Stack


| Category | Technology | Description |
| :--- | :--- | :--- |
| **Backend** | Java EE (Servlets) | Core business logic and request handling. |
| **Frontend** | JSP, JSTL & EL | Dynamic presentation layer using JSTL and EL. |
| **Database** | MySQL | Persistent storage for application data. |
| **Data Access**| JDBC & DAO | Dedicated layer for clean SQL operations. |
| **Server** | Apache Tomcat | Application server for Java EE components. |

---

## 🚀 Setup and Installation Guide

### 1. Database Configuration
Execute the following SQL script in your MySQL Workbench or Shell to initialize your schema:

```sql
CREATE DATABASE IF NOT EXISTS student_management_db;
USE student_management_db;

-- Student Table definition
CREATE TABLE IF NOT EXISTS student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    profile_pic LONGBLOB
);

-- Fee Table definition
CREATE TABLE IF NOT EXISTS fee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNIQUE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    amount_paid DECIMAL(10, 2) DEFAULT 0.00,
    payment_status VARCHAR(20) DEFAULT 'UNPAID',
    FOREIGN KEY (student_id) REFERENCES student(id)
);
2. Update Connection SettingsModify src/main/java/com/DBConnection.java with your local MySQL credentials:VariableDescriptionDefault ExampleDB_URLJDBC URL for MySQLjdbc:mysql://localhost:3306/student_management_dbDB_USERNAMEMySQL user (often root)rootDB_PASSWORDMySQL user passwordmypassword123🗃️ Project Structure OverviewPlaintextStudentTrackManagement/
├── src/main/java/com/
│   ├── DBConnection.java     <-- DB Config & Credentials
│   ├── ImageServlet.java      <-- Image Streaming Logic
│   ├── models/                <-- Data Models (Student, Fee)
│   └── dao/                   <-- Data Access Objects (StudentDAO, FeeDAO)
└── src/main/webapp/
    ├── common-login.jsp       <-- Unified Login Page
    ├── admin-dashboard.jsp    <-- Admin Control Interface
    └── fees-status.jsp        <-- Core Fee Display Feature
⚠️ Troubleshootingjava.lang.ClassNotFoundException: Ensure the MySQL Connector/J JAR is in the project build path or Tomcat lib folder.Access Denied: Verify DB_USERNAME and DB_PASSWORD in DBConnection.java and ensure MySQL is running.Fee Status shows ERROR_DB: Check SQL queries in FeeDAO.java and confirm foreign key relationships are intact.📧 ContactPrakrati Saxena Email: prakratisaxena032@gmail.com
**Would you like me to help you create a `LICENSE` file for the MIT License mentioned in your descri
