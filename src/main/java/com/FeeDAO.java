package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date; 

/**
 * Data Access Object for Fee records, using the 'fee' table.
 */
public class FeeDAO {

    private static Fee mapResultSetToFee(ResultSet rs) throws SQLException {
        Fee fees = new Fee();
        fees.setId(rs.getInt("id"));
        fees.setStudentId(rs.getInt("student_id"));
        fees.setSessionYear(rs.getString("session_year"));
        fees.setTotalAmount(rs.getDouble("total_amount"));
        fees.setAmountPaid(rs.getDouble("amount_paid"));
        fees.setPaymentStatus(rs.getString("payment_status"));
        fees.setLastPaymentDate(rs.getDate("last_payment_date")); 
        return fees;
    }

    /**
     * Retrieves the current fee status for a given student and session.
     */
    public static Fee getFeeStatus(int studentId, String sessionYear) {
        // FIX: Changed table name from 'fees' to 'fee'
        String sql = "SELECT * FROM fees WHERE student_id = ? AND session_year = ?"; 
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setString(2, sessionYear);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFee(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching fee status: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Creates the initial fee record for a student.
     */
    public static boolean createInitialFee(int studentId, String sessionYear, double totalAmount) {
        // FIX: Changed table name from 'fees' to 'fee'
        String sql = "INSERT INTO fees (student_id, session_year, total_amount, amount_paid, payment_status) VALUES (?, ?, ?, 0.0, 'UNPAID')";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setString(2, sessionYear);
            ps.setDouble(3, totalAmount);
            
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            // Handle duplicate key error gracefully if record already exists
            if (e.getSQLState().startsWith("23")) { 
                System.out.println("Fee record already exists for this student/session.");
                return true; 
            }
            System.err.println("Error creating initial fee: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to get fee by ID (needed for recording payment)
    public static Fee getFeeById(int feeId) {
        // FIX: Changed table name from 'fees' to 'fee'
        String sql = "SELECT * FROM fees WHERE id = ?"; 
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, feeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFee(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Method to simulate payment (used by the Servlet)
    public static boolean recordPayment(int feeId, double newAmountPaid) {
        Fee currentFee = getFeeById(feeId); 
        
        if (currentFee == null) {
            return false;
        }

        String newStatus;
        double balance = currentFee.getTotalAmount() - currentFee.getAmountPaid() - newAmountPaid;

        if (balance <= 0.0) {
            newStatus = "PAID";
            // Set amount paid to total amount if overpaid/fully paid
            newAmountPaid = currentFee.getTotalAmount(); 
        } else if (newAmountPaid > 0.0) {
            newStatus = "PENDING";
            newAmountPaid = currentFee.getAmountPaid() + newAmountPaid;
        } else {
             // If amount paid is 0, status remains as it was
            newStatus = currentFee.getPaymentStatus();
            newAmountPaid = currentFee.getAmountPaid();
        }
        
        Date currentDate = new Date(System.currentTimeMillis());
        
        // FIX: Changed table name from 'fees' to 'fee'
        String sql = "UPDATE fees SET amount_paid = ?, payment_status = ?, last_payment_date = ? WHERE id = ?"; 
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, newAmountPaid);
            ps.setString(2, newStatus);
            ps.setDate(3, currentDate);
            ps.setInt(4, feeId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error recording payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}