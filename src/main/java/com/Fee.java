package com;

import java.sql.Date;

/**
 * Model class for the Fee record.
 * Represents a single record in the 'fees' database table.
 */
public class Fee {

    // --- 1. Fields ---
    private int id;
    private int studentId;
    private String sessionYear;
    private double totalAmount; // Using double for currency
    private double amountPaid;
    private String paymentStatus;
    private Date lastPaymentDate; // Using java.sql.Date for compatibility with JDBC

    // --- 2. Constructor ---
    public Fee() {}

    // --- 3. Getters ---
    public int getId() {
        return id;
    }

    public int getStudentId() {
        return studentId;
    }

    public String getSessionYear() {
        return sessionYear;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    /**
     * @return The remaining balance due (Total Amount - Amount Paid).
     */
    public double getAmountDue() {
        // Correctly calculates the remaining balance
        return totalAmount - amountPaid;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public Date getLastPaymentDate() {
        return lastPaymentDate;
    }

    // --- 4. Setters ---
    public void setId(int id) {
        this.id = id;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setSessionYear(String sessionYear) {
        this.sessionYear = sessionYear;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }

    /**
     * CRITICAL: Setter for the payment status (e.g., PAID, UNPAID, PENDING).
     */
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public void setLastPaymentDate(Date lastPaymentDate) {
        this.lastPaymentDate = lastPaymentDate;
    }
}