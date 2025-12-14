<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 != null) {
        session1.invalidate(); // Invalidates the session
    }
    // FIX: Redirect all logged-out users to the unified login page
    response.sendRedirect("common-login.jsp"); 
%>