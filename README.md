
# 📚 Student Track Management System (Java EE)

This is a complete, full-stack web application developed using Java EE (Servlets & JSPs) and MySQL for backend database management. The system handles core student administrative tasks, including registration, secure login, image streaming, and fee status tracking.

---

## 🌟 Visual Showcase

| Screen | Description |
| :--- | :--- |
| **Login Page** | The dual-role login page for students and administrators. |
| **Student Dashboard** | Where students access fee status and update their profile. |

---

## ✨ Key Features

* **Student Registration & Secure Login:** Implements separate authentication portals for students and system administrators.
* **Real-time Fee Tracking:** Students can view their total fees, amount paid, and the current balance due in real-time.
* **Payment Simulation:** Includes functionality to "mock pay" fees, adjusting the database status dynamically for testing.
* **Dynamic Image Streaming:** Uses a dedicated `ImageServlet` to serve profile pictures stored in the database securely to the frontend.
* **Data Access Layer:** Utilizes the Data Access Object (DAO) pattern (`StudentDAO`, `FeeDAO`) for robust and maintainable database interactions.

---

## 🛠️ Technology Stack



| Category | Technology | Description |
| :--- | :--- | :--- |
| **Backend** | Java EE (Servlets) | Core business logic and request handling. |
| **Frontend** | JSP (JavaServer Pages) | Dynamic presentation layer using JSTL and EL. |
| **Database** | MySQL | Persistent storage for all application data. |
| **Data Access** | JDBC & DAO Pattern | Dedicated layer for clean SQL operations. |
| **Server** | Apache Tomcat | Application server for running the Java EE components. |

---

## 🚀 Setup and Installation Guide

To run this project locally, you will need a Java EE environment (like Eclipse/IntelliJ), a MySQL server, and the JDBC driver.

### 1. Database Setup (MySQL)
Execute the following script to create the database and tables:

```sql
CREATE DATABASE IF NOT EXISTS student_management_db;
USE student_management_db;

-- Student table definition
CREATE TABLE IF NOT EXISTS student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    profile_pic LONGBLOB
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

```

### 2. Configuration Details

Update the database connection parameters in `src/main/java/com/DBConnection.java`:

| Variable | Description | Default Example |
| --- | --- | --- |
| **DB_URL** | JDBC URL for your MySQL instance | `jdbc:mysql://localhost:3306/student_management_db` |
| **DB_USERNAME** | Your MySQL user (often root) | `root` |
| **DB_PASSWORD** | The password for your MySQL user | `mypassword123` |

### 3. Project Setup and Deployment

1. **Clone the Repository:** `git clone https://github.com/prakratis/Student-Track-Magement-System-Java-EE.git`
2. **Install JDBC Driver:** Ensure the appropriate MySQL Connector/J driver JAR is added to your project's build path (or placed in the Tomcat lib directory).
3. **Import and Configure:** Import the project into your IDE, ensure Tomcat (v9+) is configured, and deploy the project to the server.
4. **Access:** Navigate to `http://localhost:8080/StudentTrackManagement/`.

---

## 🗃️ Project Structure Overview

```text
StudentTrackManagement/
├── src/main/java/com/
│   ├── DBConnection.java     <-- DB Config
│   ├── ImageServlet.java     <-- Image Streaming Logic
│   ├── models/               <-- Data Models (Student, Fee)
│   └── dao/                  <-- Data Access Objects (StudentDAO, FeeDAO)
└── src/main/webapp/
    ├── common-login.jsp      <-- Unified Login Page
    ├── admin-dashboard.jsp   <-- Admin Dashboard
    └── fees-status.jsp       <-- Core Fee Display Feature

```

---

## ⚠️ Troubleshooting Common Issues

| Issue | Solution |
| --- | --- |
| **ClassNotFoundException** | The MySQL Connector/J JAR is missing. Add it to your build path or Tomcat/lib. |
| **Access denied for 'root'** | Check DB_USERNAME and DB_PASSWORD in DBConnection.java. Ensure MySQL is running. |
| **404 - Not Found** | Verify project deployment and that the URL context path matches the project name. |
| **Fee Status ERROR_DB** | Retrieval failed. Check SQL in FeeDAO.java and confirm table records/foreign keys. |

---

## 💡 Future Scope and Enhancements

* **Admin Panel:** Implement full CRUD interface for administrators to manage records directly.
* **Payment Gateway Integration:** Integrate with real gateways like Stripe or PayPal.
* **Reporting:** Generate printable PDF reports for summaries using libraries like iText.
* **Architecture:** Transition to Spring Boot for better modularity and RESTful API development.

---

## 📄 License

This project is licensed under the MIT License.

## 📧 Contact

**Name:** Prakrati Saxena

**Email:** [prakratisaxena032@gmail.com](mailto:prakratisaxena032@gmail.com)

```

```
