package com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.charset.StandardCharsets;

// FIX: Changing the mapping from "/RegisterServlet" to "/register" to match the URL in your form/error.
@WebServlet("/register")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)  // 50MB
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Utility method to safely get parameter value from a Part (for text fields)
    private String getPartValue(jakarta.servlet.http.Part part) throws IOException {
        if (part == null) return null;
        // Using a Reader for text to ensure correct character encoding
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
            StringBuilder value = new StringBuilder();
            char[] buffer = new char[1024];
            for (int length; (length = reader.read(buffer)) > 0;) {
                value.append(buffer, 0, length);
            }
            return value.toString().trim(); 
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Retrieve ALL non-file fields using getPartValue()
            String name = getPartValue(request.getPart("name"));
            String ageStr = getPartValue(request.getPart("age"));
            String className = getPartValue(request.getPart("className")); // CORRECTLY pulls Class Name
            String sessionYear = getPartValue(request.getPart("sessionYear"));
            String username = getPartValue(request.getPart("username"));
            String password = getPartValue(request.getPart("password"));
            
            Part photoPart = request.getPart("photo");

            int age = 0;
            if (ageStr != null && !ageStr.isEmpty()) {
                age = Integer.parseInt(ageStr);
            }

            Student s = new Student();
            s.setName(name);
            s.setAge(age);
            s.setClassName(className);
            s.setSessionYear(sessionYear);
            s.setUsername(username);
            s.setPassword(password);
            s.setAdmissionStatus("NO"); 

            if (photoPart != null && photoPart.getSize() > 0) {
                try (InputStream is = photoPart.getInputStream()) {
                    s.setPhoto(is.readAllBytes()); 
                    s.setPhotoType(photoPart.getContentType()); 
                }
            } else {
                s.setPhoto(null);
                s.setPhotoType(null);
            }

            if (StudentDAO.registerStudent(s)) {
                response.sendRedirect("success.jsp");
            } else {
                request.setAttribute("errorMsg", "Registration failed. Username may already exist.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Invalid age entered.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "An internal error occurred during registration. Check server logs.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}