package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {


    public static boolean validate(Admin admin) {
       
        String sql = "SELECT * FROM ADMIN WHERE username = ? AND password = ?";
        
        // Ensure your database has an ADMIN table matching these columns!
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getPassword());

            ResultSet rs = ps.executeQuery();
            
            // If rs.next() is true, a matching user was found, and validation succeeds.
            return rs.next(); 

        } catch (SQLException e) {
            System.err.println("Admin Login SQL Error: ");
            e.printStackTrace();
            return false;
        }
    }
}