<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Student" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Security check logic remains untouched
    HttpSession session1 = request.getSession(false);
    
    Student stu = (Student) session1.getAttribute("student");
    
    // FIX: Redirect to the correct, existing unified login page (common-login.jsp)
    if (stu == null) { 
        // Redirect to the unified login page
        response.sendRedirect("common-login.jsp"); 
        return; 
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile: <%= stu.getName() %></title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6; /* Light, clean background */
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }

        .profile-card {
            background-color: white;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-top: 5px solid #28a745; /* Green header line */
        }

        h2 {
            color: #007bff;
            font-size: 2em;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .profile-picture {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #007bff; /* Blue ring around the photo */
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
        }

        .details-list {
            list-style: none;
            padding: 0;
            margin-bottom: 30px;
            text-align: left;
        }

        .details-list li {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            font-size: 1.1em;
        }

        .details-list li:last-child {
            border-bottom: none;
        }

        .details-list b {
            display: inline-block;
            width: 130px;
            color: #555;
            font-weight: 600;
        }

        /* Status Color Coding */
        .status-APPROVED { color: #28a745; font-weight: bold; }
        .status-REJECTED { color: #dc3545; font-weight: bold; }
        .status-PENDING { color: #ffc107; font-weight: bold; }

        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c757d; /* Gray for navigation */
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }
    </style>
</head>

<body>
<div class="profile-card">

    <h2>👤 My Profile</h2>
    
    <img 
        src="ImageServlet?id=<%= stu.getId() %>" 
        alt="Student Profile Photo" 
        class="profile-picture"
    >

    <ul class="details-list">
        <li><b>Name:</b> <%= stu.getName() %></li>
        <li><b>Age:</b> <%= stu.getAge() %></li>
        <li><b>Class:</b> <%= stu.getClassName() %></li>
        <li><b>Session:</b> <%= stu.getSessionYear() %></li>
        <li>
            <b>Admission Status:</b> 
            <span class="status-<%= stu.getAdmissionStatus() %>">
                <%= stu.getAdmissionStatus() %>
            </span>
        </li>
    </ul>

    <a href="student-dashboard.jsp" class="back-btn">← Back to Dashboard</a>

</div>
</body>
</html>
