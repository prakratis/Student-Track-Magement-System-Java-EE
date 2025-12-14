<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6; /* Light background */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 380px;
            text-align: center;
        }

        h2 {
            color: #007bff;
            margin-bottom: 30px;
            font-size: 1.8em;
        }
        
        /* New: Styling for error message */
        .error-message {
            color: #dc3545; /* Red text */
            background-color: #f8d7da; /* Light red background */
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
            text-align: center;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        .input-group input[type="text"],
        .input-group input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box; 
            font-size: 1em;
            transition: border-color 0.3s;
        }

        .input-group input:focus {
            border-color: #007bff;
            outline: none;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff; /* Blue button */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>🔒 Admin Login</h2>
    
    <%
        // Get message passed from the servlet (if login failed)
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
        <p class="error-message">⚠️ <%= msg %></p>
    <%
        }
    %>

    <form action="adminLogin" method="post">
        
        <div class="input-group">
            <label for="username">Username:</label>
            <input name="username" id="username" type="text" required>
        </div>

        <div class="input-group">
            <label for="password">Password:</label>
            <input name="password" id="password" type="password" required>
        </div>
        
        <button type="submit">Log In</button>
    </form>
</div>

</body>
</html>