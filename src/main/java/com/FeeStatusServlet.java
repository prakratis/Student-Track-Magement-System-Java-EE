package com;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FeeStatusServlet")
public class FeeStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles the mock payment submission from fees-status.jsp.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Student student = (Student) session.getAttribute("student");

        // 1. Authorization check
        if (student == null) {
            response.sendRedirect("common-login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String feeIdStr = request.getParameter("feeId");

        if ("mockPay".equals(action) && feeIdStr != null) {
            try {
                // Get the fee record identifier (feeId is now used for fetching)
                int feeId = Integer.parseInt(feeIdStr);
                
                // Fetch the fee status based on the ID passed from the form
                Fee currentFee = FeeDAO.getFeeById(feeId);
                
                if (currentFee == null) {
                    response.sendRedirect("fees-status.jsp?status=error&msg=NoFeeRecord");
                    return;
                }
                
                // CRITICAL SECURITY CHECK: Ensure the fee record belongs to the logged-in student
                if (currentFee.getStudentId() != student.getId()) {
                    response.sendRedirect("fees-status.jsp?status=error&msg=UnauthorizedAccess");
                    return;
                }
                
                // MOCK PAYMENT LOGIC: Set the new paid amount to the full total amount to simulate paying the balance
                double fullAmount = currentFee.getTotalAmount();
                
                // Update the database record using FeeDAO.recordPayment()
                boolean success = FeeDAO.recordPayment(currentFee.getId(), fullAmount);

                if (success) {
                    // Redirect back with a success message flag
                    response.sendRedirect("fees-status.jsp?status=paymentSuccess");
                } else {
                    response.sendRedirect("fees-status.jsp?status=error&msg=PaymentDBFailed");
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("fees-status.jsp?status=error&msg=InvalidFeeID");
            } catch (Exception e) {
                 e.printStackTrace();
                response.sendRedirect("fees-status.jsp?status=error&msg=InternalError");
            }
        } else {
            // No valid action provided, just reload the page
            response.sendRedirect("fees-status.jsp");
        }
    }
}