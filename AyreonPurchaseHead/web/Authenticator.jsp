<%-- 
    Document   : Authenticator
    Created on : 18 Jan, 2018, 3:14:33 PM
    Author     : Project
--%>

<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authenticator - Ayreon</title>
    </head>
    <body>
        <%
            HashMap hm = new HashMap();
            hm.put("RAJ","1580020");
            hm.put("SAKSHI","1580026");
            hm.put("JIMIL","1580045");
            String username = request.getParameter("username").toUpperCase().trim();
            String password = request.getParameter("password").trim();
            session.setAttribute("Username", username);
            HashMap userdtls = new HashMap();
            userdtls.put("RAJ", "rajjoshi0008@gmail.com");
            userdtls.put("SAKSHI","sakshimore1188@gmail.com");
            userdtls.put("JIMIL","shahjimil35@gmail.com");
            username = session.getAttribute("Username").toString();
            String requestedby = userdtls.get(username).toString();
            session.setAttribute("Requested By", requestedby);
            if(!(hm.containsKey(username) || hm.containsValue(password))) {
        %>
        <jsp:forward page = "Login.jsp"/>
        <%
            }
            else if(hm.containsKey(username) && password.equals(hm.get(username))) {
        %>
        <jsp:forward page = "Welcome.jsp"/>
        <%
            }
            else {
        %>
        <jsp:forward page = "Login.jsp"/>
        <%
            } 
        %>
    </body>
</html>
