<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Student" %>
<%@ page import="com.StudentDAO" %>

<%
    // Ensure the DAO and Student classes are correctly imported and accessible
    // Note: The logic for session check and data fetching remains unchanged and is crucial.
    HttpSession sess = request.getSession(false);

    if (sess == null || sess.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // This assumes StudentDAO.getAllStudents() returns a List<Student>
    List<Student> students = StudentDAO.getAllStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel: All Students</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6;
            color: #333;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
        }

        h2 {
            color: #007bff;
            font-size: 2em;
            margin: 0;
        }

        h3 {
            color: #555;
            margin-top: 30px;
            border-left: 5px solid #28a745;
            padding-left: 10px;
        }

        .logout-link {
            text-decoration: none;
            color: white;
            background-color: #dc3545; /* Red for logout */
            padding: 8px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .logout-link:hover {
            background-color: #c82333;
        }

        /* --- Table Styling --- */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden; /* Ensures border-radius is applied */
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 0.9em;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e9f5ff;
        }

        /* --- Status Color Coding --- */
        .status-APPROVED {
            color: #28a745; /* Green */
            font-weight: bold;
        }

        .status-REJECTED {
            color: #dc3545; /* Red */
            font-weight: bold;
        }

        .status-PENDING {
            color: #ffc107; /* Yellow/Orange */
            font-weight: bold;
        }

        /* --- Action Button Styling --- */
        form {
            display: flex;
            gap: 5px;
        }

        button {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.2s;
            white-space: nowrap; /* Prevents buttons from wrapping */
        }

        button[value="APPROVE"] {
            background-color: #28a745; /* Green */
            color: white;
        }

        button[value="APPROVE"]:hover {
            background-color: #218838;
        }

        button[value="REJECT"] {
            background-color: #dc3545; /* Red */
            color: white;
        }

        button[value="REJECT"]:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <div class="header-section">
        <h2> Admin Panel Dashboard</h2>
        <a href="admin-logout.jsp" class="logout-link">Logout</a>
    </div>

    <h3>All Student Applications</h3>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Class</th>
                <th>Session</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Student s : students) {
                    // Determine the CSS class based on the status for color coding
                    String statusClass = "status-" + s.getAdmissionStatus(); 
            %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getClassName() %></td>
                <td><%= s.getSessionYear() %></td>
                <td class="<%= statusClass %>">
                    <%= s.getAdmissionStatus() %>
                </td>
                <td>
                    <form action="AdminAction" method="post">
                        <input type="hidden" name="id" value="<%= s.getId() %>">

                        <button type="submit" name="action" value="APPROVE">Approve</button>
                        <button type="submit" name="action" value="REJECT">Reject</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

</body>
</html>


