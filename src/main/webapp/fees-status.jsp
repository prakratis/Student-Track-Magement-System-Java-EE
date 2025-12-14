<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Fee" %>
<%@ page import="com.FeeDAO" %>
<%@ page import="com.Student" %>
<% 
    // Security check: Ensure student is logged in
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("student-login.jsp");
        return;
    }
    
    // Get the session year from the logged-in student object
    String currentSession = student.getSessionYear();
    
    // 1. Fetch the Fee record
    Fee currentFee = FeeDAO.getFeeStatus(student.getId(), currentSession);
    
    // --- Step 2: If no fee record exists, create a mock initial fee ---
    if (currentFee == null) {
        // Set a default fee amount for demonstration
        double defaultTotalFee = 15000.00;
        // Assume student.getId() and student.getSessionYear() are available
        boolean created = FeeDAO.createInitialFee(student.getId(), currentSession, defaultTotalFee);
        
        if (created) {
            // Re-fetch the newly created fee record
            currentFee = FeeDAO.getFeeStatus(student.getId(), currentSession);
        } else {
            // Fallback object if creation failed
            currentFee = new Fee();
            currentFee.setTotalAmount(defaultTotalFee);
            currentFee.setAmountPaid(0.0);
            currentFee.setPaymentStatus("ERROR_DB");
        }
    }

    // Determine CSS class for status display
    String statusClass = "text-gray-600 font-bold";
    if (currentFee.getPaymentStatus().equalsIgnoreCase("PAID")) {
        statusClass = "text-green-600 font-bold";
    } else if (currentFee.getPaymentStatus().equalsIgnoreCase("UNPAID")) {
        statusClass = "text-red-600 font-bold";
    } else if (currentFee.getPaymentStatus().equalsIgnoreCase("PENDING")) {
        statusClass = "text-yellow-600 font-bold";
    }
    
    // Handle status message display from FeeStatusServlet redirects
    String paymentSuccessMsg = "Payment recorded successfully! Your balance is now fully paid.";
    String noFeeRecordMsg = "Error: Fee record not found. Please contact administration.";
    String invalidFeeIDMsg = "Error: Invalid fee ID format.";
    String internalErrorMsg = "Error: An internal system error occurred.";
    String paymentDBFailedMsg = "Error: Database update failed during payment processing.";
    String unauthorizedAccessMsg = "Error: Unauthorized access attempt detected.";


    String statusParam = request.getParameter("status");
    String msgParam = request.getParameter("msg");
    
    // Display status messages based on query parameters
    String displayMessage = null;
    String messageType = "success"; // default type
    
    if ("paymentSuccess".equals(statusParam)) {
        displayMessage = paymentSuccessMsg;
    } else if ("error".equals(statusParam)) {
        messageType = "error";
        if ("NoFeeRecord".equals(msgParam)) {
            displayMessage = noFeeRecordMsg;
        } else if ("InvalidFeeID".equals(msgParam)) {
            displayMessage = invalidFeeIDMsg;
        } else if ("InternalError".equals(msgParam)) {
            displayMessage = internalErrorMsg;
        } else if ("PaymentDBFailed".equals(msgParam)) {
            displayMessage = paymentDBFailedMsg;
        } else if ("UnauthorizedAccess".equals(msgParam)) {
            displayMessage = unauthorizedAccessMsg;
        } else {
            displayMessage = "An unknown error occurred.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Fees Status</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="bg-white p-8 rounded-xl shadow-2xl w-full max-w-md">
        <h2 class="text-3xl font-extrabold text-indigo-700 mb-6 border-b pb-2">Fee Status for <%= student.getName() %></h2>

        <!-- Status/Error Messages -->
        <% if (displayMessage != null) { %>
            <div class="<%= messageType.equals("success") ? "bg-green-100 border-green-500 text-green-700" : "bg-red-100 border-red-500 text-red-700" %> border-l-4 p-4 rounded-lg mb-4" role="alert">
                <p class="font-bold"><%= messageType.equals("success") ? "Success!" : "Error!" %></p>
                <p><%= displayMessage %></p>
            </div>
        <% } %>
        <!-- End Status/Error Messages -->

        <div class="space-y-4 text-gray-700">
            <p><span class="font-semibold">Session:</span> <%= currentFee.getSessionYear() %></p>
            <p><span class="font-semibold">Total Fee Amount:</span> ₹ <%= String.format("%,.2f", currentFee.getTotalAmount()) %></p>
            <p><span class="font-semibold">Amount Paid:</span> ₹ <%= String.format("%,.2f", currentFee.getAmountPaid()) %></p>
            <p class="text-lg"><span class="font-semibold">Balance Due:</span> <span class="text-red-500 font-bold">₹ <%= String.format("%,.2f", currentFee.getAmountDue()) %></span></p>
            <p class="text-xl pt-2"><span class="font-semibold">Payment Status:</span> <span class="<%= statusClass %>"><%= currentFee.getPaymentStatus() %></span></p>
            
            <% if (currentFee.getLastPaymentDate() != null) { %>
                <p class="text-sm text-gray-500">Last Payment Date: <%= currentFee.getLastPaymentDate().toString() %></p>
            <% } %>
        </div>

        <div class="mt-8 pt-4 border-t">
            <% 
                // Only show payment option if a balance is due (amount due > 0)
                if (currentFee.getAmountDue() > 0 && currentFee.getId() != 0) { 
            %>
                <form action="FeeStatusServlet" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="mockPay">
                    <input type="hidden" name="feeId" value="<%= currentFee.getId() %>">
                    
                    <div class="bg-yellow-50 border-l-4 border-yellow-400 p-3 rounded-lg">
                        <p class="text-sm text-yellow-800 font-medium">Mock Payment: This simulates paying the remaining balance now.</p>
                    </div>

                    <button type="submit" 
                            class="w-full bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-4 rounded-lg transition duration-200 shadow-md transform hover:scale-105 disabled:opacity-50"
                            >
                        Pay Remaining Balance (₹ <%= String.format("%,.2f", currentFee.getAmountDue()) %>)
                    </button>
                </form>
            <% } else if (currentFee.getPaymentStatus().equalsIgnoreCase("PAID")) { %>
                 <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg" role="alert">
                    <p class="font-bold">Payment Complete!</p>
                    <p>All fees for the <%= currentFee.getSessionYear() %> session are paid in full.</p>
                </div>
            <% } %>

            <a href="student-dashboard.jsp" class="block mt-4 text-center text-indigo-600 hover:text-indigo-800 font-medium">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>