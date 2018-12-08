<%-- 
    Document   : Logout
    Created on : 18 Mar, 2018, 9:21:51 PM
    Author     : Jimil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if(session != null) {
                session.invalidate();
            }
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
    </body>
</html>

