<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Student" %>

<%
    // Security check logic remains untouched
    Student stu = (Student) session.getAttribute("student");
    if (stu == null) {
        // Assuming the student login page is common-login.jsp or student-login.jsp
        response.sendRedirect("common-login.jsp"); 
        return;
    }
    
    // Normalize status for CSS class generation
    String admissionStatus = stu.getAdmissionStatus();
    String cssStatus = admissionStatus.toUpperCase();
    
    // Map YES/NO to standard statuses for reliable CSS application
    if (cssStatus.equals("YES")) {
        cssStatus = "APPROVED";
    } else if (cssStatus.equals("NO")) {
        cssStatus = "PENDING";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Dashboard</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #eef1f5; /* Lighter background */
        margin: 0;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        color: #333;
    }

    .dashboard-card {
        width: 100%;
        max-width: 400px;
        background-color: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        border-top: 5px solid #007bff; /* Blue accent line */
    }

    h2 {
        color: #007bff;
        font-size: 2em;
        margin-bottom: 5px;
        text-align: center;
    }
    
    .welcome-text {
        color: #6c757d;
        font-size: 1.1em;
        margin-bottom: 25px;
        text-align: center;
        border-bottom: 1px dashed #eee;
        padding-bottom: 15px;
    }

    .photo-area {
        text-align: center;
        margin-bottom: 25px;
    }
    .photo-area img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 4px solid #28a745; /* Green ring around photo */
        object-fit: cover;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .info-list {
        list-style: none;
        padding: 0;
        margin-bottom: 30px;
    }

    .info-list li {
        padding: 8px 0;
        border-bottom: 1px solid #f8f9fa;
        font-size: 1.05em;
    }
    .info-list b {
        color: #555;
        font-weight: 600;
        display: inline-block;
        width: 120px;
    }
    
    /* Status Color Coding (Updated for YES/NO data) */
    .status-APPROVED, .status-YES { color: #28a745; font-weight: bold; }
    .status-REJECTED { color: #dc3545; font-weight: bold; }
    .status-PENDING, .status-NO { color: #ffc107; font-weight: bold; }

    .btn-action {
        display: block;
        width: 100%;
        padding: 15px;
        margin-top: 15px;
        color: white;
        border: none;
        font-size: 1.1em;
        border-radius: 8px;
        text-align: center;
        text-decoration: none;
        transition: background-color 0.3s ease, transform 0.1s;
    }
    
    /* Specific button colors */
    .btn-profile { background-color: #007bff; }
    .btn-profile:hover { background-color: #0056b3; transform: translateY(-1px); }

    .btn-fees { background-color: #ffc107; }
    .btn-fees:hover { background-color: #e0a800; transform: translateY(-1px); }

    .btn-study { background-color: #17a2b8; }
    .btn-study:hover { background-color: #138496; transform: translateY(-1px); }

    .btn-logout { 
        background-color: #dc3545; 
        margin-top: 30px; /* Extra space before logout */
    }
    .btn-logout:hover { 
        background-color: #c82333; 
        transform: translateY(-1px);
    }
</style>

</head>
<body>

<div class="dashboard-card">

    <h2>👋 Student Dashboard</h2>
    <p class="welcome-text">Welcome, **<%= stu.getName() %>**!</p>

    <div class="photo-area">
        <img 
            src="ImageServlet?id=<%= stu.getId() %>" 
            alt="Student Profile Photo"
        >
    </div>

    <ul class="info-list">
        <li><b>Class:</b> <%= stu.getClassName() %></li>
        <li><b>Session:</b> <%= stu.getSessionYear() %></li>
        <li>
            <b>Status:</b> 
            <!-- Apply the status class based on the mapped status (APPROVED, PENDING, or original) -->
            <span class="status-<%= cssStatus %>">
                <%= admissionStatus %>
            </span>
        </li>
    </ul>

    <a href="profile.jsp" class="btn-action btn-profile">👤 My Profile</a>
    <a href="fees-status.jsp" class="btn-action btn-fees">💲 Fees Status</a>
    <a href="study-material.jsp" class="btn-action btn-study">📚 Study Material</a>
    
    <a href="logout.jsp" class="btn-action btn-logout">Logout</a>

</div>

</body>
</html>
