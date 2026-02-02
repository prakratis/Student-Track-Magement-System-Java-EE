# 📚 Student Track Management System (Java EE)

This is a complete, full-stack web application developed using Java EE (Servlets & JSPs) and MySQL for backend database management. The system is designed to handle core student administrative tasks, including registration, secure login, image streaming, and fee status tracking.

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

### 1. Database Configuration (MySQL)
Execute the following SQL script in your MySQL Workbench or Shell:

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
2. Update Connection SettingsYou must update the database connection parameters in the src/main/java/com/DBConnection.java file:VariableDescriptionDefault ExampleDB_URLJDBC URL for your MySQL instancejdbc:mysql://localhost:3306/student_management_dbDB_USERNAMEYour MySQL user (often root)rootDB_PASSWORD The password for your MySQL usermypassword1233. Project Setup and DeploymentClone the Repository: git clone https://github.com/prakratis/Student-Track-Magement-System-Java-EE.gitInstall JDBC Driver: Ensure the appropriate MySQL Connector/J driver JAR is added to your project's build path.Import and Configure: Import the project into your IDE, ensure Tomcat (v9+) is configured, and deploy.Access: Navigate to http://localhost:8080/StudentTrackManagement/.🗃️ Project Structure OverviewPlaintextStudentTrackManagement/
├── src/main/java/com/
│   ├── DBConnection.java     <-- DB Config
│   ├── ImageServlet.java      <-- Image Streaming Logic
│   ├── models/                <-- Data Models (Student, Fee)
│   └── dao/                   <-- Data Access Objects
└── src/main/webapp/
    ├── common-login.jsp       <-- Unified Login Page
    ├── admin-dashboard.jsp    <-- Admin Interface
    └── fees-status.jsp        <-- Core Fee Display
⚠️ Troubleshooting Common IssuesClassNotFoundException: The MySQL Connector/J JAR is missing. Add it to the Tomcat lib folder.Access Denied: Check DB_USERNAME and DB_PASSWORD in DBConnection.java.404 Resource Not Available: Verify the project is correctly deployed and the context path matches.Fee Status ERROR_DB: Check your SQL query in FeeDAO.java and confirm table relationships.🔮 Future ScopePayment Gateway Integration: Transition from mock payments to a real provider like Stripe.Reporting: Generate printable PDF reports using the iText library.Modernization: Transition to Spring Boot for better modularity and RESTful APIs.📄 LicenseLicensed under the MIT License.📧 ContactPrakrati Saxena | Email: prakratisaxena032@gmail.com
**Would you like me to help you format the `StudentDAO` or `FeeDAO` classes to match this database stru
