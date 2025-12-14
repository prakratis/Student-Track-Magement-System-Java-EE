<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Successful</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f4f8; /* Soft, light background */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        color: #333;
    }
    
    .success-card {
        background-color: white;
        padding: 40px;
        width: 100%;
        max-width: 400px;
        text-align: center;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        border-top: 5px solid #28a745; /* Green accent for success */
    }
    
    .icon-large {
        color: #28a745; /* Success Green */
        font-size: 4em;
        margin-bottom: 15px;
    }

    h2 {
        color: #28a745;
        margin-bottom: 25px;
        font-size: 2.2em;
        font-weight: 700;
    }
    
    .status-message {
        margin-top: 5px;
        font-size: 1.1em;
        color: #555;
        line-height: 1.6;
    }

    .info-box {
        background-color: #e9f5ff; /* Light blue info box */
        color: #007bff;
        border: 1px solid #cce5ff;
        padding: 15px;
        margin-top: 25px;
        border-radius: 8px;
        font-weight: 600;
    }

    .login-btn {
        display: block;
        margin-top: 30px;
        padding: 14px;
        background-color: #4f46e5; /* Purple primary button */
        color: white;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        font-size: 1.1em;
        transition: background-color 0.3s ease, transform 0.1s;
    }
    .login-btn:hover {
        background-color: #4338ca;
        transform: translateY(-1px);
    }
</style>

</head>
<body>

<div class="success-card">
    
    <div class="icon-large">
        ✅
    </div>

    <h2>Registration Successful!</h2>
    
    <p class="status-message">
        Your account has been created successfully.
    </p>

    <div class="info-box">
        **Next Step:** Please wait until the **ADMIN** reviews and **approves** your admission application. You will be notified upon approval.
    </div>

    <a href="student-login.jsp" class="login-btn">Proceed to Login Page</a>
</div>

</body>
</html>