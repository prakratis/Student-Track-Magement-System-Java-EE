package com;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        try {
            if ("admin".equalsIgnoreCase(role)) {

                // FIX 1: Delegate admin check to the database using AdminDAO
                Admin admin = new Admin(username, password);
                if (AdminDAO.validate(admin)) {
                    
                    // FIX 2: Set the correct session attribute name ("admin")
                    session.setAttribute("admin", username); 
                    
                    // FIX 3: Redirect to the correct dashboard file name (admin-dashboard.jsp)
                    response.sendRedirect("admin-dashboard.jsp"); 
                    
                    // CRITICAL FIX 4: Must return after sendRedirect
                    return; 
                } else {
                    request.setAttribute("msg", "❌ Invalid admin credentials");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }

            } else if ("student".equalsIgnoreCase(role)) {

                Student student = StudentDAO.login(username, password);

                if (student == null) {
                    request.setAttribute("msg", "❌ Invalid username or password");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return; // Added return
                } else if ("NO".equalsIgnoreCase(student.getAdmissionStatus())) { // Use "NO" to match your default DB setting
                    request.setAttribute("msg", "⛔ Admission not approved yet");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return; // Added return
                } else {
                    session.setAttribute("student", student);
                    response.sendRedirect("student-dashboard.jsp");
                    return; // CRITICAL FIX: Must return after sendRedirect
                }
            } else {
                request.setAttribute("msg", "❌ Invalid role selected");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return; // Added return
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "❌ An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return; // Added return
        }
    }
}
