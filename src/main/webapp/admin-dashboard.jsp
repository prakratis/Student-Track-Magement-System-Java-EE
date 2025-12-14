<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Inside admin-dashboard.jsp
    // 1. Get the session without creating a new one (false)
    HttpSession sessionAdmin = request.getSession(false);
    
    // 2. Check if the session is invalid OR the 'admin' attribute is missing
    if (sessionAdmin == null || sessionAdmin.getAttribute("admin") == null) { 
        // Redirect to the CORRECT login page (admin-login.jsp)
        response.sendRedirect("admin-login.jsp");
        return; // Important: Stop processing the rest of the JSP
    }
    
    // 3. Extract the admin username once the session is validated
    String adminUsername = (String) sessionAdmin.getAttribute("admin");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
            color: #333;
        }

        .header {
            background-color: #007bff;
            color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }

        .welcome-message {
            font-size: 1.8em;
            color: #007bff;
            margin-bottom: 10px;
            border-bottom: 2px solid #eee;
            padding-bottom: 15px;
            text-align: left; /* Aligned left for better flow */
        }

        .tagline {
            font-size: 1.1em;
            color: #666;
            margin-bottom: 30px;
            text-align: left;
        }

        .nav-links {
            text-align: left;
        }
        
        .nav-links a {
            text-decoration: none;
            color: white;
            background-color: #28a745; /* Green for action */
            padding: 10px 15px;
            border-radius: 5px;
            margin-right: 15px;
            transition: background-color 0.3s ease;
            display: inline-block;
            font-weight: 600;
        }

        .nav-links a:hover {
            background-color: #218838;
        }
        
        /* Specific style for Logout button */
        .nav-links .logout-btn { /* Use a class for clarity */
            background-color: #dc3545; /* Red for logout */
        }

        .nav-links .logout-btn:hover {
            background-color: #c82333;
        }

        .dashboard-content {
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <div class="header">
        <h1>🔐 Admin Panel</h1>
    </div>

    <div class="container">
        <div class="welcome-message">
            Welcome Admin, **<%= adminUsername %>**
        </div>

        <p class="tagline">
            Manage Students and System Settings Efficiently.
        </p>

        <div class="dashboard-content">
            <h3>Quick Actions</h3>
            <div class="nav-links">
                <a href="view-all-students.jsp">View All Students</a>
                <a href="logout.jsp" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>

</body>
</html>