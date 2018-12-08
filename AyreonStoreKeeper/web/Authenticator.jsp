<%-- 
    Document   : Authenticator
    Created on : 18 Mar, 2018, 9:20:42 PM
    Author     : Jimil
--%>

<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="logo.png">
        <link rel="stylesheet" href="ayreonstyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Welcome</title>
    </head>
    <body>
<%
    HashMap storekeeperdtls = new HashMap();
    storekeeperdtls.put("storekeeper1@gmail.com", "1580020");
    storekeeperdtls.put("storekeeper2@gmail.com", "1580026");
    storekeeperdtls.put("storekeeper3@gmail.com", "1580045");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if(!storekeeperdtls.containsKey(username) || !password.equals(storekeeperdtls.get(username).toString())) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
    } 
    else if (password.equals(storekeeperdtls.get(username).toString())) {
        session.setAttribute("username", username);
%>
<jsp:forward page="Welcome.jsp"></jsp:forward>
<%
    }
%>
    </body>
</html>

