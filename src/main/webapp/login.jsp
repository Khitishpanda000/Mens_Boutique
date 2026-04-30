<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    
    if(session.getAttribute("user") != null) {
        response.sendRedirect("home.jsp");
        return;
    }

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if(username != null && password != null){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/Boutique";
            conn = DriverManager.getConnection(url, "postgres", "khitish@123");

            
            String sql = "SELECT username FROM users WHERE username=? AND password=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if(rs.next()){
                session.setAttribute("user", username);
                response.sendRedirect("home.jsp"); 
                return;
            } else {
                request.setAttribute("error", "Invalid username or password.");
            }
        } catch(Exception e){
            request.setAttribute("error", "Database error: " + e.getMessage());
        } finally {
            rs.close();
            ps.close();
            conn.close(); 
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container" align="center" style="width:40%; margin-top:50px;">
    <h2>Login</h2>

   
    <% if(request.getAttribute("error") != null) { %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } %>

    <form method="post" action="login.jsp"> 
        <input type="text" id="username" name="username" placeholder="Username" required><br><br>
        <input type="password" id="password" name="password" placeholder="Password" required><br><br>
        <button type="submit">Login</button>
    </form>

    <p>New User? <a href="signup.jsp" style="text-decoration:none;">Signup here</a></p>
</div>

<script src="script.js"></script>
</body>
</html>
