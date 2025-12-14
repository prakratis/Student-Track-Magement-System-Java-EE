<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.StudentDAO" %>
<%@ page import="com.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Security check
    HttpSession session2 = request.getSession(false);
    if (session2 == null || session2.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // Fetch the list of students
    List<Student> students = StudentDAO.getAllStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin: Manage All Students</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 30px;
            background-color: #eef1f5; /* Light background */
            color: #333;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 3px solid #007bff;
        }

        h2 {
            color: #007bff;
            font-size: 2.2em;
            margin: 0;
        }

        .nav-links a {
            text-decoration: none;
            color: #007bff;
            padding: 8px 12px;
            border: 1px solid #007bff;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-left: 10px;
        }

        .nav-links a:hover {
            background-color: #007bff;
            color: white;
        }
        
        h3 {
            color: #555;
            margin-top: 30px;
            font-size: 1.5em;
        }

        /* --- Table Styling --- */
        table {
            width: 100%;
            border-collapse: separate; /* Use separate to show border-radius */
            border-spacing: 0;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.08);
            border-radius: 8px;
            overflow: hidden; /* Clips content to border-radius */
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
            border-right: 1px solid #eee;
        }
        td:last-child, th:last-child {
            border-right: none;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85em;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e9f5ff;
        }

        /* --- Status Color Coding --- */
        .status-PENDING { color: #ffc107; font-weight: bold; }
        .status-YES { color: #28a745; font-weight: bold; } /* Assuming 'YES' means APPROVED */
        .status-REJECTED { color: #dc3545; font-weight: bold; } 

        /* --- Action Button Styling --- */
        .action-form {
            display: flex;
            gap: 5px;
            align-items: center;
        }

        .action-form button {
            padding: 7px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: 600;
            transition: opacity 0.2s;
        }

        .action-form button:hover {
            opacity: 0.8;
        }

        .btn-approve { background-color: #28a745; color: white; }
        .btn-reject { background-color: #dc3545; color: white; }
        .btn-delete { background-color: #6c757d; color: white; } /* Gray for dangerous action */

        /* No students message */
        .empty-message {
            background-color: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #ffeeba;
        }
    </style>
</head>
<body>

    <div class="header-section">
        <h2>🛠️ Admin Student Management</h2>
        <div class="nav-links">
            <a href="admin-dashboard.jsp">Back to Dashboard</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>

    <h3>Registered Students (<%= students.size() %>)</h3>

    <% if (students.isEmpty()) { %>
        <p class="empty-message">No student applications found in the database. New students need to register first.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Class</th>
                    <th>Session</th>
                    <th>Username</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
         <% 
            for (Student student : students) { 
                String status = student.getAdmissionStatus();
                // Ensure status is not null before checking
                String statusClass = (status != null && status.length() > 0) ? status.toUpperCase() : "PENDING";
         %>
                    <tr>
                        <td><%= student.getId() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getClassName() %></td>
                        <td><%= student.getSessionYear() %></td>
                        <td><%= student.getUsername() %></td>
                        <td>
                            <span class="status-<%= statusClass %>">
                                <%= status %>
                            </span>
                        </td>
                        <td>
                            <form action="AdminAction" method="post" class="action-form">
                                <input type="hidden" name="id" value="<%= student.getId() %>">
                                
                                <%-- Only show APPROVE if status is NOT YES --%>
                                <% if (!"YES".equalsIgnoreCase(status)) { %>
                                    <button type="submit" name="action" value="APPROVE" class="btn-approve">Approve</button>
                                <% } %>

                                <button type="submit" name="action" value="REJECT" class="btn-reject">Reject</button>
                                <button type="submit" name="action" value="DELETE" class="btn-delete" 
                                        onclick="return confirm('Are you sure you want to delete <%= student.getName() %>? This cannot be undone.')">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

</body>
</html>