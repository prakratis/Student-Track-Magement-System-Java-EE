package com;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin") 
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = new Admin(username, password);
        boolean isValid = AdminDAO.validate(admin);

        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", username); 
            

            response.sendRedirect("admin-dashboard.jsp"); 
            
      
            return; 
        } else {
            request.setAttribute("loginError", "Invalid Admin Credentials.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }
    }
}