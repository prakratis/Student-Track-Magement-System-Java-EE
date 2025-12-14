package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private static final String INSERT_SQL = "INSERT INTO student (name, age, class_name, session_year, username, password, photo, admission_status) VALUES (?,?,?,?,?,?,?,?)";
    private static final String CHECK_USERNAME_SQL = "SELECT * FROM student WHERE username=?";

    // Student Registration
    public static boolean registerStudent(Student s) {
        // 1. Check if username already exists
        try (Connection conCheck = DBConnection.getConnection();
             PreparedStatement psCheck = conCheck.prepareStatement(CHECK_USERNAME_SQL)) {
            
            psCheck.setString(1, s.getUsername());
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    return false; // Username already exists
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // 2. Insert new student record
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_SQL)) {

            ps.setString(1, s.getName());
            ps.setInt(2, s.getAge());
            ps.setString(3, s.getClassName());
            ps.setString(4, s.getSessionYear());
            ps.setString(5, s.getUsername());
            ps.setString(6, s.getPassword());
            
            // FIX: Use setBytes for LONGBLOB data
            if (s.getPhoto() != null) {
                ps.setBytes(7, s.getPhoto()); 
            } else {
                ps.setNull(7, java.sql.Types.LONGVARBINARY);
            }
            
            ps.setString(8, s.getAdmissionStatus());

            ps.executeUpdate(); // Line 35 based on previous errors
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ----------------------------------------------------------------------
    // Student Login
    // ----------------------------------------------------------------------
    
    /**
     * Attempts to log in a student by checking username and password.
     * @return The Student object if login is successful, otherwise returns null.
     */
    public static Student login(String username, String password) {
        String sql = "SELECT * FROM student WHERE username = ? AND password = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Login successful, populate the Student object
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setName(rs.getString("name"));
                    student.setAge(rs.getInt("age"));
                    student.setClassName(rs.getString("class_name"));
                    student.setSessionYear(rs.getString("session_year"));
                    student.setUsername(rs.getString("username"));
                    student.setPassword(rs.getString("password")); 
                    student.setAdmissionStatus(rs.getString("admission_status"));
                    
                    // Note: Photo data is not loaded here for performance
                    
                    return student;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; 
    }

    // ----------------------------------------------------------------------
    // Admin Management Methods
    // ----------------------------------------------------------------------
    
    // Fetch all students (excluding photo for performance)
    public static List<Student> getAllStudents() {
        List<Student> studentList = new ArrayList<>();
        // Select all columns EXCEPT 'photo' for faster retrieval
        String sql = "SELECT id, name, age, class_name, session_year, username, admission_status, password FROM student ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setAge(rs.getInt("age"));
                s.setClassName(rs.getString("class_name"));
                s.setSessionYear(rs.getString("session_year"));
                s.setUsername(rs.getString("username"));
                s.setPassword(rs.getString("password")); 
                s.setAdmissionStatus(rs.getString("admission_status"));
                
                studentList.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return studentList;
    }

    // Update status for Approve/Reject
    public static boolean updateStatus(int studentId, String status) {
        String sql = "UPDATE student SET admission_status = ? WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, studentId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete student
    public static boolean deleteStudent(int studentId) {
        String sql = "DELETE FROM student WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 // CRITICAL FIX: Method for ImageServlet to stream the photo
    public static byte[] getStudentPhoto(int studentId) {
        String sql = "SELECT photo FROM student WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBytes("photo");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; 
    }
}


