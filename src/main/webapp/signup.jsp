<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.sql.*"%>
<%

    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    String message = ""; 

    if (username != null && email != null && password != null) {
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/Boutique";
            String uname = "postgres";
            String pass = "khitish@123";
            
            Connection conn = DriverManager.getConnection(url, uname, pass);
             
            String sql = "INSERT INTO users(username, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            
            int result = ps.executeUpdate();
            
            ps.close();
            conn.close();

            if(result > 0) {
                
                response.sendRedirect("login.jsp?msg=success");
                return;
            } else {
                message = "Signup Failed!";
            }
        } catch(Exception e) {
            message = "Error: " + e.getMessage();
        }   
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

<div class="container" align="center" style='width:40%; margin-top:50px;'>
    <h2>Signup</h2>

    <%-- Display Status Message --%>
    <% if(!message.equals("")) { %>
        <p style="color:red;"><%= message %></p>
    <% } %>

    <form method="post" action="signup.jsp" onsubmit="return validateSignup()">
        <input type="text" id="susername" placeholder="Username" name="username" required><br><br>
        <input type="email" id="email" placeholder="Email" name="email" required><br><br>
        <input type="password" id="spassword" placeholder="Password" name="password" required><br><br>
        <button type="submit">Sign up</button>
    </form>
    
    <p>Already have an account? <a href="login.jsp" style='text-decoration:none;'>Login</a></p>
</div>

<script src="script.js"></script>
</body>
</html>
