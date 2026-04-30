<%@ page import="java.util.*, java.sql.*" %>
<%
    // Get user from session links to login.jsp
    String user = (String) session.getAttribute("user");
    
    // Redirect to login if user is not logged in
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Boutique","postgres","khitish@123");

    // 2. Logic: Add to Cart
    if(request.getParameter("cart") != null){
        PreparedStatement ps = con.prepareStatement("INSERT INTO cart(product_name, price, username) SELECT name, price, ? FROM product WHERE name=?");
        ps.setString(1, user);
        ps.setString(2, request.getParameter("cart"));
        ps.executeUpdate();
        response.sendRedirect("product.jsp"); 
        return;
    }

    // 3. Logic: Add to Wishlist
    if(request.getParameter("wish") != null){
        PreparedStatement ps = con.prepareStatement("INSERT INTO wishlist(product_name, username) VALUES(?, ?)");
        ps.setString(1, request.getParameter("wish"));
        ps.setString(2, user);
        ps.executeUpdate();
        response.sendRedirect("product.jsp"); 
        return;
    }

    // 4. Logic: Buy Now (Adds to cart first then goes to payment)
    if(request.getParameter("buy") != null){
        PreparedStatement ps = con.prepareStatement("INSERT INTO cart(product_name, price, username) SELECT name, price, ? FROM product WHERE name=?");
        ps.setString(1, user);
        ps.setString(2, request.getParameter("buy"));
        ps.executeUpdate();
        response.sendRedirect("payment.jsp"); 
        return;
    }

    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM product");
%>
<!DOCTYPE html>
<html>
<head><title>Products</title><link rel="stylesheet" href="style.css"></head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container">
	<h2 style="text-align:center; margin:40px 0;">Our Collection</h2>
	<div style="display:flex; flex-wrap:wrap; gap:20px; justify-content:center;">
	<% while(rs.next()){ %>
        <div style="width:230px; height:420px; display:flex; flex-direction:column; background:rgb(149, 149, 149); padding:15px; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.1);">
            <img src="<%= rs.getString("image_url") %>" style="width:100%; height:150px; object-fit:cover; border-radius:8px;">
            <div style="margin-top:10px;">
                <h3 style="font-size:1.1em; margin-bottom:5px; height:45px; overflow:hidden;"><%= rs.getString("name") %></h3>
                <p style="font-weight:bold; color:#2c3e50;"><%= rs.getInt("price") %></p>
            </div>
            <div style="display:flex; flex-direction:column; gap:8px; margin-top:auto;">
                <form method="post">
                    <input type="hidden" name="cart" value="<%= rs.getString("name") %>">
                    <button style="width:100%; padding:8px; background:rgb(72, 72, 72); color:white; border:none; cursor:pointer; border-radius:4px;">Add to Cart</button>
                </form>
                <form method="post">
                    <input type="hidden" name="wish" value="<%= rs.getString("name") %>">
                    <button style="width:100%; padding:8px; background:rgb(72, 72, 72); color:white; border:none; cursor:pointer; border-radius:4px;">Wishlist</button>
                </form>
                <form method="post">
                    <input type="hidden" name="buy" value="<%= rs.getString("name") %>">
                    <button style="width:100%; padding:8px; background:rgb(35, 107, 33); color:white; border:none; cursor:pointer; border-radius:4px;">Buy Now</button>
                </form>
            </div>
        </div>
    <% } con.close(); %>
    </div>
</div>
</body>
</html>
