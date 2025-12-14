<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f2f5; /* Light background */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .registration-card {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            color: #28a745; /* Green header */
            margin-bottom: 30px;
            font-size: 2em;
            text-align: center;
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

        /* Styling for all form inputs */
        .input-group input:not([type="submit"]),
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
            border-color: #28a745; /* Focus green */
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        
        /* Specific styling for file input to look cleaner */
        input[type="file"] {
            padding: 10px;
            border: 1px dashed #ced4da;
            background-color: #f8f9fa;
        }

        button[type="submit"] {
            width: 100%;
            padding: 14px;
            background-color: #28a745; /* Submit green */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s;
            margin-top: 15px;
        }

        button[type="submit"]:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<div class="registration-card">
    
    <h2>📝 Student Registration</h2>
    
    <form action="register" method="post" enctype="multipart/form-data">
        
        <div class="input-group">
            <label for="name">Name:</label>
            <input name="name" id="name" type="text" required>
        </div>
        
        <div class="input-group">
            <label for="age">Age:</label>
            <input name="age" id="age" type="number" min="1" required>
        </div>
        
        <div class="input-group">
            <label for="username">Username (Login ID):</label>
            <input name="username" id="username" type="text" required>
        </div>
        
        <div class="input-group">
            <label for="password">Password:</label>
            <input name="password" id="password" type="password" required>
        </div>
        
        <div class="input-group">
            <label for="className">Class/Grade:</label>
            <input name="className" id="className" type="text">
        </div>
        
        <div class="input-group">
            <label for="sessionYear">Session Year:</label>
            <input name="sessionYear" id="sessionYear" type="text" placeholder="e.g., 2024-2025" required>
        </div>
        
        <div class="input-group">
            <label for="photo">Upload Photo (Image File):</label>
            <input type="file" name="photo" id="photo" accept="image/*">
        </div>
        
        <button type="submit">Complete Registration</button>
    </form>
</div>

</body>
</html>
