<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Login</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f4f8; /* Very light, soft background */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        color: #333;
    }

    .login-card {
        background: white;
        padding: 40px;
        width: 100%;
        max-width: 380px;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        text-align: center;
        border-top: 5px solid #4f46e5; /* Purple accent line */
    }

    h2 {
        color: #4f46e5; /* Main Purple */
        margin-bottom: 30px;
        font-size: 2em;
    }

    /* Input Styling */
    .input-field {
        width: 100%;
        padding: 14px;
        margin-top: 15px;
        border: 1px solid #d1d5db; /* Light gray border */
        border-radius: 8px;
        font-size: 1em;
        box-sizing: border-box;
        transition: border-color 0.3s, box-shadow 0.3s;
    }
    .input-field:focus {
        border-color: #4f46e5;
        outline: none;
        box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2);
    }

    /* Button Styling */
    .login-btn {
        width: 100%;
        padding: 14px;
        margin-top: 25px;
        background-color: #4f46e5;
        color: white;
        font-size: 1.1em;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        transition: background-color 0.3s ease, transform 0.1s;
    }
    .login-btn:hover {
        background-color: #4338ca;
        transform: translateY(-1px);
    }
    
    /* Message/Error Styling */
    .error-msg {
        color: #dc3545; /* Red for error */
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 5px;
        font-weight: 500;
        display: <%= request.getAttribute("msg") == null ? "none" : "block" %>;
    }

    /* Registration Link */
    .register-link {
        margin-top: 20px;
        font-size: 1em;
        color: #6c757d;
    }
    .register-link a {
        color: #28a745; /* Green for new registration link */
        text-decoration: none;
        font-weight: 600;
    }
    .register-link a:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<div class="login-card">
    <h2>🎓 Student Portal Login</h2>

    <%-- Dynamically show/hide the message box --%>
    <p class="error-msg">
        <%= request.getAttribute("msg") == null ? "" : request.getAttribute("msg") %>
    </p>

    <form action="StudentLoginServlet" method="post">
        <input type="text" name="username" class="input-field" placeholder="Username" required>
        <input type="password" name="password" class="input-field" placeholder="Password" required>
        <button type="submit" class="login-btn">Secure Login</button>
    </form>

    <p class="register-link">Don't have an account? <a href="register.jsp">Register Here</a></p>
</div>

</body>
</html>
