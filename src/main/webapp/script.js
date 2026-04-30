
function addedToCart(product) {
    alert(product + " added to cart!");
}

function addedToWishlist(product) {
    alert(product + " added to wishlist!");
}

function buyNow(product) {
    alert("Proceeding to buy: " + product);
}

function validateLogin() {
    let user = document.getElementById("username").value;
    let pass = document.getElementById("password").value;

    if (user === "" || pass === "") {
        alert("Please fill all fields!");
        return false;
    }

    if (pass.length < 4) {
        alert("Password must be at least 4 characters");
        return false;
    }

    return true;
}

function validateSignup() {
    let user = document.getElementById("susername").value;
    let email = document.getElementById("email").value;
    let pass = document.getElementById("spassword").value;

    if (user === "" || email === "" || pass === "") {
        alert("All fields are required!");
        return false;
    }

    if (!email.includes("@")) {
        alert("Enter valid email!");
        return false;
    }

    if (pass.length < 4) {
        alert("Password must be at least 4 characters");
        return false;
    }

    return true;
}

function toggleMenu() {
    let menu = document.getElementById("navLinks");

    if (menu.style.display === "block") {
        menu.style.display = "none";
    } else {
        menu.style.display = "block";
    }
}

