<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Boutique","postgres","khitish@123");

    // MOVE FROM WISHLIST TO CART
    if(request.getParameter("move") != null){
        String pName = request.getParameter("move");
        
        // 1. Insert into cart
        PreparedStatement movePs = con.prepareStatement("INSERT INTO cart(product_name, price, username) SELECT name, price, ? FROM product WHERE name=?");
        movePs.setString(1, user);
        movePs.setString(2, pName);
        movePs.executeUpdate();
        
        // 2. Remove from wishlist
        PreparedStatement delPs = con.prepareStatement("DELETE FROM wishlist WHERE product_name=? AND username=?");
        delPs.setString(1, pName);
        delPs.setString(2, user);
        delPs.executeUpdate();
        
        response.sendRedirect("wishlist.jsp"); return;
    }
    
    // DELETE FROM WISHLIST
    if(request.getParameter("del") != null){
        PreparedStatement ps = con.prepareStatement("DELETE FROM wishlist WHERE id=? AND username=?");
        ps.setInt(1, Integer.parseInt(request.getParameter("del")));
        ps.setString(2, user);
        ps.executeUpdate();
        response.sendRedirect("wishlist.jsp"); return;
    }

    PreparedStatement ps = con.prepareStatement("SELECT * FROM wishlist WHERE username=?");
    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head><title>Wishlist</title><link rel="stylesheet" href="style.css"></head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container">
    <h2 style="text-align:center; margin-top:30px;">Your Wishlist</h2>
    <div style="width:70%; margin:auto;">
    <% while(rs.next()){ %>
    <div style="display:flex; justify-content:space-between; align-items:center; padding:15px; border-bottom:1px solid #ccc; background:#fff; border-radius:5px;">
        <span style="font-weight:bold;"><%= rs.getString("product_name") %></span>
        <div>
            <form method="post" style="display:inline;">
                <input type="hidden" name="move" value="<%= rs.getString("product_name") %>">
                <button style="background:green; color:white; padding:8px 12px; border:none; cursor:pointer; border-radius:4px;">Add to Cart</button>
            </form>
            <form method="post" style="display:inline;">
                <input type="hidden" name="del" value="<%= rs.getInt("id") %>">
                <button style="background:red; color:white; padding:8px 12px; border:none; cursor:pointer; border-radius:4px; margin-left:5px;">Remove</button>
            </form>
        </div>
    </div>
    <% } %>
    </div>
</div>
</body>
</html>
<% con.close(); %>
