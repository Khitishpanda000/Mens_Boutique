# 👗 Boutique Management System

A dynamic **Java Web Application** for an online boutique store. This project implements a full e-commerce workflow—from user registration to a simulated checkout—using JSP, JDBC, and PostgreSQL.

## ✨ Key Features
*   **User Authentication:** Secure Signup and Login with session-based tracking.
*   **Product Gallery:** Dynamic display of boutique items with real-time price and image rendering.
*   **Wishlist Management:** Save favorite items for later and move them directly to the cart.
*   **Shopping Cart:** Add or remove items before purchase with automatic total price calculation.
*   **Payment Flow:** Dedicated payment summary page showing total order value.
*   **Responsive UI:** Clean, centered layouts with client-side JavaScript validation.

## 🛠️ Technology Stack
*   **Language:** Java (JSP)
*   **Database:** PostgreSQL
*   **Web Server:** Apache Tomcat (v9.0 or higher)
*   **Frontend:** HTML5, CSS3, JavaScript
*   **Driver:** JDBC (PostgreSQL Driver)

## 🗄️ Database Setup
Run the following SQL commands in your PostgreSQL environment to set up the `Boutique` database:

```sql
CREATE DATABASE Boutique;

-- User Accounts
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Product Catalog
CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    image_url TEXT
);

-- Shopping Cart
CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price INT,
    username VARCHAR(50)
);

-- User Wishlist
CREATE TABLE wishlist (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    username VARCHAR(50)
);
```

## 🚀 Installation & Setup
1.  **Clone the Repository:** Download the project files into your IDE (Eclipse/IntelliJ) or your Tomcat `webapps` folder.
2.  **Add Database Driver:** Ensure the `postgresql-42.x.x.jar` file is placed in your project's `WEB-INF/lib` directory.
3.  **Configure Database:** 
    *   Open the JSP files.
    *   Locate the `DriverManager.getConnection` line.
    *   Update the username (`postgres`) and password (`khitish@123`) to match your local PostgreSQL credentials.
4.  **Run:** Start your Tomcat server and navigate to `http://localhost:8080/ProjectName/login.jsp`.

## 📂 File Overview
*   `login.jsp` / `signup.jsp` - User entry and registration.
*   `product.jsp` - Browse and add items to cart/wishlist.
*   `wishlist.jsp` - View and manage saved items.
*   `cart.jsp` - View and remove items before checkout.
*   `payment.jsp` - Order summary and total calculation.
*   `navbar.jsp` - Shared navigation menu across all pages.
