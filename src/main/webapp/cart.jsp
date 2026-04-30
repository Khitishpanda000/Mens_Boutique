<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Boutique","postgres","khitish@123");

    if(request.getParameter("remove") != null){
        PreparedStatement ps = con.prepareStatement("DELETE FROM cart WHERE id=? AND username=?");
        ps.setInt(1, Integer.parseInt(request.getParameter("remove")));
        ps.setString(2, user);
        ps.executeUpdate();
        response.sendRedirect("cart.jsp"); return;
    }

    PreparedStatement ps = con.prepareStatement("SELECT * FROM cart WHERE username=?");
    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();
    int total = 0;
%>
<!DOCTYPE html>
<html>
<head><title>Your Cart</title><link rel="stylesheet" href="style.css"></head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container">
    <h2 style="text-align:center; margin-top:30px;">Your Shopping Cart</h2>
    <table border="1" style="width:80%; margin:auto; text-align:center; border-collapse:collapse; background:white;">
        <tr style="background:#f2f2f2;">
            <th style="padding:15px;">Product Name</th>
            <th style="padding:15px;">Price</th>
            <th style="padding:15px;">Action</th>
        </tr>
        <% while(rs.next()){ 
            total += rs.getInt("price"); 
        %>
        <tr>
            <td style="padding:12px;"><%= rs.getString("product_name") %></td>
            <td style="padding:12px;"><%= rs.getInt("price") %></td>
            <td style="padding:12px;">
                <form method="post">
                    <input type="hidden" name="remove" value="<%= rs.getInt("id") %>">
                    <button style="background:red; color:white; border:none; padding:8px 12px; cursor:pointer; border-radius:4px;">Remove</button>
                </form>
            </td>
        </tr>
        <% } %>
        <tr style="background:#f9f9f9; font-size:1.2em;">
            <td><b>Grand Total</b></td>
            <td colspan="2"><b><%= total %></b></td>
        </tr>
    </table>
    <div style="text-align:center; margin-bottom:50px;">
        <form action="payment.jsp">
            <button style="margin-top:20px; padding:12px 30px; background:green; color:white; border:none; cursor:pointer; font-size:16px; border-radius:5px;">Proceed to Checkout</button>
        </form>
    </div>
</div>
</body>
</html>
<% con.close(); %>
