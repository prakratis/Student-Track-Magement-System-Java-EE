<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Student" %>
<%
    // Session check is critical for security
    Student stu = (Student) session.getAttribute("student");
    if (stu == null) { 
        // Redirect if student session is invalid (Use common-login.jsp or student-login.jsp as needed)
        response.sendRedirect("student-login.jsp"); 
        return;
    }
    // You might want to pass a message here indicating WHY admin credentials are required
    String actionMessage = (String) request.getAttribute("actionMsg");
    if (actionMessage == null) actionMessage = "Please verify your request with Admin credentials.";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Confirmation Required</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa; /* Light, neutral background */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }

    .auth-card {
        background-color: white;
        padding: 40px;
        width: 100%;
        max-width: 400px;
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        text-align: center;
        border-top: 5px solid #ffc107; /* Yellow/Orange accent for warning/security */
    }

    h2 {
        color: #dc3545; /* Red for security/warning context */
        margin-bottom: 10px;
        font-size: 1.8em;
    }

    .message-box {
        background-color: #fff3cd; /* Light yellow background */
        color: #856404; /* Dark text */
        border: 1px solid #ffeeba;
        padding: 15px;
        margin-bottom: 25px;
        border-radius: 8px;
        font-weight: 500;
        text-align: left;
        line-height: 1.4;
    }

    .input-field {
        width: 100%;
        padding: 12px;
        margin-top: 15px;
        border: 1px solid #ced4da;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 1em;
    }
    .input-field:focus {
        border-color: #ffc107;
        outline: none;
        box-shadow: 0 0 0 3px rgba(255, 193, 7, 0.25);
    }

    .submit-btn {
        width: 100%;
        padding: 14px;
        margin-top: 30px;
        background-color: #dc3545; /* Red button for confirmation/security */
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 1.1em;
        cursor: pointer;
        font-weight: 600;
        transition: background-color 0.3s ease;
    }
    .submit-btn:hover {
        background-color: #c82333;
    }
</style>
</head>
<body>

<div class="auth-card">

    <h2>🚨 Admin Confirmation</h2>

    <div class="message-box">
        **Action Alert:** This request requires authorization. <%= actionMessage %>
    </div>

    <form action="AdminAuth" method="post">
        <input name="username" class="input-field" placeholder="Admin Username" required>
        <input type="password" name="password" class="input-field" placeholder="Admin Password" required>
        <button type="submit" class="submit-btn">Authorize &amp; Continue</button>
    </form>

</div>

</body>
</html>