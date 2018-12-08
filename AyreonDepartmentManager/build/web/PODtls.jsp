<%-- 
    Document   : PODtls
    Created on : 24 Feb, 2018, 11:03:57 AM
    Author     : Jimil
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - PO Details</title>
    </head>
    <body>
        <div class="container">

            <%
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("select ponumber from podtls where status != 3 and status != 5");
            %>
            <header>
                <h1>AYREON</h1>
            </header>
  
            <nav>
                <ul>
                    <li><a href="ViewPR.jsp">View PR</a></li>
                    <li><a href="PODtls.jsp">View PO</a></li>
                </ul>
            </nav>

            <article>
                <center>
                    <form method = "POST" action = "StorePO.jsp">
                        <h2>Purchase Order Details</h2><br><br>
                        PO Number : &nbsp;&nbsp;&nbsp;
                        <select name = "ponumberdropdown"> 
                            <%
                                while(rs.next()) {
                            %>
                            <option><%=rs.getInt("ponumber")%></option>
                            <%
                                }
                                c.close();
                            %>
                        </select>
                        <br>
                        <br>
                        &nbsp;&nbsp;&nbsp;<input type = "submit" value = "Get PO Details" class = "submit1">
                        <br>
                        <br>
                    </form>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
