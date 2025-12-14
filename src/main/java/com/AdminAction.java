package com;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

@WebServlet("/AdminAction")
public class AdminAction extends HttpServlet {

	private static final long serialVersionUID = -4613183548399932043L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            int id = Integer.parseInt(req.getParameter("id"));

            if ("APPROVE".equalsIgnoreCase(action)) {
                StudentDAO.updateStatus(id, "YES");
            } else if ("REJECT".equalsIgnoreCase(action)) {
                StudentDAO.updateStatus(id, "NO");
            } else if ("DELETE".equalsIgnoreCase(action)) {
                StudentDAO.deleteStudent(id);
            }

            resp.sendRedirect("admin-panel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
