<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@ include file="navbar.jsp" %>

<div class="container">
    <h1 align="center">Welcome to Fashion Boutique</h1>
    <p align="center">Latest trendy fashion available</p>
    <p align="center">Join our fashion family! 🤍 Sign up for our newsletter to get a first look at new arrivals, style tips from our team, and exclusive treats just for you. Because at Fashion Boutique, you’re more than a customer—you’re our greatest inspiration.</p>
</div>
<div class="announce">
	<marquee>25% off on H&M denim jackets.!!!!!    </marquee>
</div>

<script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>