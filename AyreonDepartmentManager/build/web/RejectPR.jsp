<%-- 
    Document   : RejectPR
    Created on : 24 Feb, 2018, 9:28:24 AM
    Author     : Jimil
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="ayreonstyle.css">
        <title>Ayreon - Reject PR</title>
    </head>
    <body>
        <div class="container">
            
            <%!
                int prnumber = 0;
            %>
            <%
                prnumber = Integer.parseInt(application.getAttribute("PR Number").toString());
                session.setAttribute("PR Number", prnumber);
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                PreparedStatement stmt = c.prepareStatement("select requestedby from requisitiondtls where prnumber = ?");
                stmt.setInt(1, prnumber);
                ResultSet rs = stmt.executeQuery();
                String toAdd = "";
                while(rs.next()) {
                    toAdd = rs.getString("requestedby");
                }
                session.setAttribute("Contact",toAdd);
                stmt = c.prepareStatement("update requisitiondtls set status = 4 where prnumber = ?");
                stmt.setInt(1,prnumber);
                stmt.executeUpdate();
                c.close();
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
                <form>
                    <center>
                        <br>
                        <b>Remarks : </b> 
                            <textarea rows="2" cols="50" placeholder="Please enter your remarks for the PR." name="remarks" required>
                            </textarea>
                        <br><br>
                        <button type="submit" class="submit1" formaction="RejectMail.jsp">Confirm</button>
                        <br>
                        <br>
                    </center>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
