<%-- 
    Document   : SelectPO
    Created on : 19 Mar, 2018, 12:52:21 PM
    Author     : Jimil
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="logo.png">
        <link rel="stylesheet" href="ayreonstyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Select PO</title>
    </head>
    <body>
        <%
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
            Statement stmt = c.createStatement();
            ResultSet podtls = stmt.executeQuery("select ponumber from podtls where status = 3");
        %>
        <div class="container">

            <header>
                <h1>AYREON</h1>
            </header>
  
            <nav>
                <ul>
                    <li><a href="SelectPO.jsp">Log Delivery</a></li>
                    <li><a href="Logout.jsp">Log Out</a></li>
                </ul>
            </nav>

            <article>
                <center>
                    <form method="post" action="LogDelivery.jsp">
                        <h1>Select PO Number : </h1>
                        <br>
                        PO Number : 
                        <select name="ponumberdropdown">
                            <%
                                while(podtls.next()) {
                            %>
                            <option><%=podtls.getInt("ponumber")%></option>
                            <%
                                }
                            %>
                        </select>
                        <br>
                        <br>
                        <input type="submit" value="submit" class="submit1">
                        <br>
                        <br>
                    </form>
                    <br>
                    <br>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
