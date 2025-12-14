<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>System Error</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa; /* Very light gray background */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }

    .error-card {
        background-color: white;
        padding: 40px;
        width: 100%;
        max-width: 400px;
        text-align: center;
        border-radius: 12px;
        /* Subtle red highlight bar at the top */
        border-top: 5px solid #dc3545; 
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    }

    .icon-large {
        color: #dc3545; /* Bootstrap Red */
        font-size: 3em;
        margin-bottom: 15px;
    }

    h2 {
        color: #dc3545;
        margin-top: 0;
        margin-bottom: 20px;
        font-size: 1.8em;
        font-weight: 700;
    }

    .error-message {
        font-size: 1.1em;
        color: #6c757d; /* Darker gray for readable text */
        margin-bottom: 25px;
        line-height: 1.5;
    }

    .btn-action {
        display: inline-block;
        margin-top: 10px;
        padding: 12px 25px;
        background-color: #dc3545; /* Red button */
        color: white;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        letter-spacing: 0.5px;
        transition: background-color 0.3s ease, transform 0.1s;
    }

    .btn-action:hover {
        background-color: #c82333;
        transform: translateY(-1px);
    }
</style>

</head>
<body>

<div class="error-card">

    <div class="icon-large">
        ❌
    </div>
    
    <h2>Action Failed</h2>

    <%
        String msg = (String) request.getAttribute("msg");
        // Ensure the error message is clear, using a slightly more professional default
        if (msg == null || msg.trim().isEmpty()) {
            msg = "An unexpected error occurred. Please check your inputs and try again.";
        }
    %>

    <p class="error-message"><%= msg %></p>

    <a href="register.jsp" class="btn-action">Return to Registration</a>

</div>

</body>
</html>
