package com;

import java.io.IOException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ImageServlet")
@MultipartConfig(maxFileSize = 16177215)
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String sid = req.getParameter("id");
        if (sid == null || sid.isEmpty()) {
            return; 
        }

        try {
            int id = Integer.parseInt(sid);
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT photo, photo_type FROM student WHERE id=?"
            );
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                byte[] data = rs.getBytes("photo");
                String type = rs.getString("photo_type"); 

                if (data != null) {
                    if (type == null) type = "image/jpeg";

                    resp.setContentType(type);
                    resp.setContentLength(data.length);

                    OutputStream os = resp.getOutputStream();
                    os.write(data);
                    os.flush();
                }
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


