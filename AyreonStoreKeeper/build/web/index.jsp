<%-- 
    Document   : index
    Created on : 18 Mar, 2018, 9:19:59 PM
    Author     : Jimil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8">
        <title>Ayreon - Login</title>
        <link rel="icon" href="logo.png">
        <link rel="stylesheet" href="style.css">
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
    </head>
    <body>
        <div class="loginBox">
            <img src="logo.png" class="user">
            <h2>Ayreon Login</h2>
            <form method="post" action="Authenticator.jsp">
                <p>Username : </p>
                <input type="text" name="username" placeholder="Enter Email" required>
                <p>Password : </p>
                <input type="password" name="password" placeholder="Enter your password" required>
                <input type="submit" name="submitbutton" value="Sign In">
            </form>
        </div>
    </body>
</html>