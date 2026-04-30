<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Boutique","postgres","khitish@123");
    
    PreparedStatement ps = con.prepareStatement("SELECT SUM(price) FROM cart WHERE username=?");
    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();
    
    int total = 0; 
    if(rs.next()) total = rs.getInt(1);
%>
<!DOCTYPE html>
<html>
<head><title>Payment</title><link rel="stylesheet" href="style.css"></head>
<body>
<%@ include file="navbar.jsp" %>
<div style="text-align:center; margin-top:50px;">
    <h2>Payment Details for <%= user %></h2>
    <table border="1" style="width:70%; margin:auto; border-collapse:collapse;">
        <tr style="background:black; color:white;">
            <th style="padding:10px;">Description</th>
            <th style="padding:10px;">Amount</th>
        </tr>
        <tr>
            <td style="padding:10px;">Total Order Value</td>
            <td style="padding:10px;"><%= total %></td>
        </tr>
    </table>
    <button style="margin-top:20px; padding:10px 20px; background:green; color:white; border:none; cursor:pointer;" onclick="alert('Payment Successful!')">Pay Now</button>
</div>
</body>
</html>
<% con.close(); %>
