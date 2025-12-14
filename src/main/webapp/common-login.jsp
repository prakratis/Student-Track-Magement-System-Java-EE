<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unified Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e9ecef; /* Light gray background */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-box {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            color: #007bff;
            margin-bottom: 25px;
            font-size: 2em;
        }

        /* Error Message Styling */
        .error-message {
            color: #dc3545; /* Red */
            background-color: #f8d7da; /* Light red background */
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
        }

        /* Styling for all form inputs (text, password, select) */
        .input-group input,
        .input-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            box-sizing: border-box; 
            font-size: 1em;
            transition: border-color 0.3s;
        }

        .input-group input:focus,
        .input-group select:focus {
            border-color: #007bff;
            outline: none;
        }

        button[type="submit"] {
            width: 100%;
            padding: 14px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
            transform: translateY(-1px);
        }

        /* Register link styling */
        .register-text {
            margin-top: 30px;
            color: #6c757d;
        }
        
        .register-text a {
            color: #28a745; /* Green link for registration */
            text-decoration: none;
            font-weight: bold;
        }

        .register-text a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<div class="login-box">
    
    <% String msg = (String)request.getAttribute("msg"); %>
    <% if (msg != null) { %>
        <p class="error-message">⚠️ <%= msg %></p>
    <% } %>

    <form action="LoginServlet" method="post">
        <h2>System Login</h2>
        
        <div class="input-group">
            <label for="role">Login As:</label>
            <select name="role" id="role" required>
                <option value="admin">Admin</option>
                <option value="student">Student</option>
            </select>
        </div>

        <div class="input-group">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>
        </div>
        
        <div class="input-group">
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>
        </div>

        <button type="submit">Proceed to Login</button>
    </form>
    
    <p class="register-text">New Student? <a href="register.jsp">Register Here</a></p>

</div>

</body>
</html>