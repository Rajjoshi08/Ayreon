<%-- 
    Document   : ViewPO
    Created on : 24 Feb, 2018, 10:18:27 AM
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

            <%!
                int ponumber = 0;
                int orderid = 0;
                int[] materialnumber = new int[]{0,0,0};
                int[] orderedquantity = new int[]{0,0,0};
                String[] materialnames = new String[]{" "," "," "};
                String[] materialdes = new String[]{" "," "," "};
                int top;
            %>
            <%
                top = 0;
                ponumber = Integer.parseInt(application.getAttribute("PO Number").toString());
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                PreparedStatement stmt = c.prepareStatement("select * from podtls where ponumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, ponumber);
                ResultSet podtls = stmt.executeQuery();
                while(podtls.next()) {
                    orderid = podtls.getInt("orderid");
                }
                podtls.beforeFirst();
                stmt = c.prepareStatement("select materialnumber, materialquantity from orderdtls where orderid = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, orderid);
                ResultSet orderdtls = stmt.executeQuery();
                while(orderdtls.next()) {
                    materialnumber[top] = orderdtls.getInt("materialnumber");
                    orderedquantity[top] = orderdtls.getInt("materialquantity");
                    top++;
                }
                orderdtls.beforeFirst();
                ResultSet names = null;
                for(int i = 0; i < top; i++) {
                    stmt = c.prepareStatement("select materialname, materialdescription from mara where materialnumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    stmt.setInt(1,materialnumber[i]);
                    names = stmt.executeQuery();
                    while(names.next()) {
                        materialnames[i] = names.getString("materialname");
                        materialdes[i] = names.getString("materialdescription");
                    }
                    names.beforeFirst();
                }
                session.setAttribute("Material Number", materialnumber);
                session.setAttribute("Material Names", materialnames);
                session.setAttribute("Ordered Quantity", orderedquantity);
                session.setAttribute("Material Description", materialdes);
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
                    <form method="post" action="GetVendors.jsp">
                        <h2>PO Details</h2>
                        <br>
                        <br>
                        <table class ="tableborder">
                            <%
                                while(podtls.next()) {
                            %>
                            <tr>
                                <td>PO  Number</td>
                                <td><%=podtls.getInt("ponumber")%></td>
                            </tr>
                            <tr>
                                <td>Requested By</td>
                                <td><%=podtls.getString("requestedby")%></td>
                            </tr>
                            <tr>
                                <td>Description</td>
                                <td><%=podtls.getString("description")%></td>
                            </tr>
                            <tr>
                                <td>Request Date</td>
                                <td><%=podtls.getDate("requestdate")%></td>
                            </tr>
                            <tr>
                                <td>Material Category</td>
                                <td><%=podtls.getString("materialcategory")%></td>
                            </tr>
                            <tr>
                                <td>Estimated Value</td>
                                <td><%=podtls.getInt("estimatedvalue")%></td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td><%=podtls.getInt("status")%></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <br>
                        <h4>Material Details: </h4>
                        <table class ="tableborder">
                            <tr>
                                <th>Number</th>
                                <th>Name</th>
                                <th>Quantity</th>
                            </tr>
                            <%
                                for(int i = 0; i < top; i++) {
                            %>
                            <tr>
                                <td><%=materialnumber[i]%></td>
                                <td><%=materialnames[i]%></td>
                                <td><%=orderedquantity[i]%></td>
                            </tr>
                            <%
                                }
                                c.close();
                            %>
                        </table>
                        <br>
                        <br>
                        <input type ="submit" class ="submit1" value="Send Mail">
                        <br>
                        <br>
                    </form>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>