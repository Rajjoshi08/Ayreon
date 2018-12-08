<%-- 
    Document   : Login
    Created on : 18 Jan, 2018, 2:43:01 PM
    Author     : Project
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html media="all">
    <head>
    <title>Ayreon -Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
     <link rel="icon" 
              type="image/png" 
              href="logo.png">
    </head>
    <body background = "coral" style ="background-repeat: no-repeat; background-size: cover; background-size: 100%; background-position: center;background: linear-gradient(to right, #FD7272 0% , #B71540 100%);font-family: sans-serif;">
        <div class="login">
        <img src="logo.png" class="logo">
            <h1>Ayreon</h1>
            <form action="Authenticator.jsp" method="post">
                <p>Username:</p>
                &nbsp;&nbsp;&nbsp;<input type="text" placeholder="enter username" name="username" required>
                <p>Password:</p> 
                &nbsp;&nbsp;&nbsp;<input type="password" placeholder="enter password" name="password" required><br><br>
                <center><input type="submit" value="Login"> &nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset"></center>
            </form>
    </body>
    </div>
</html>
 