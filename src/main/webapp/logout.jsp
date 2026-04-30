<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        if (session != null) {
        session.invalidate();
    }
   
    request.setAttribute("success", "Logged out successfully");
%>
<jsp:forward page="login.jsp" />
