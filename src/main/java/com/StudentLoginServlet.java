package com;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

@WebServlet("/student-login")
public class StudentLoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            Student stu = StudentDAO.login(username, password);
            if (stu != null) {
                HttpSession session = req.getSession();
                session.setAttribute("student", stu);
                resp.sendRedirect("student-dashboard.jsp");
            } else {
                resp.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
