<%-- 
    Document   : Logout
    Created on : 15 Jan, 2018, 1:35:13 PM
    Author     : Project
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            response.setContentType("text/html;charset=UTF-8");
            HttpSession ses = request.getSession(false);
            ses.invalidate();
        %>
        <jsp:forward page = "Login.jsp"/>
    </body>
</html>
