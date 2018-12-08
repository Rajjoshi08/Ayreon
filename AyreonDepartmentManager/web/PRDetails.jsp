<%-- 
    Document   : PRDetails
    Created on : 23 Feb, 2018, 6:43:07 PM
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
        <title>Ayreon - PR Details</title>
    </head>
    <body>
        <div class="container">

            <%!
                int prnumber = 0;
                int orderid = 0;
                int[] materialnumber = new int[3];
                int[] orderedquantity = new int[3];
                int[] currentquantity = new int[3];
                int[] maxquantity = new int[3];
            %>
            <%
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                prnumber = Integer.parseInt(request.getParameter("prnumberdropdown").toString());
                application.setAttribute("PR Number", prnumber);
                PreparedStatement stmt = c.prepareStatement("select * from requisitiondtls where prnumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, prnumber);
                ResultSet prdetails = stmt.executeQuery();
                while(prdetails.next()) {
                    orderid = prdetails.getInt("orderid");
                }
                prdetails.first();
                stmt = c.prepareStatement("select materialnumber,materialquantity from orderdtls where orderid = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, orderid);
                ResultSet orderdtls = stmt.executeQuery();
                int top = 0;
                while(orderdtls.next()) {
                    materialnumber[top] = orderdtls.getInt("materialnumber");
                    orderedquantity[top] = orderdtls.getInt("materialquantity");
                    top++;
                }
                orderdtls.beforeFirst();
                ResultSet quantitydtls = null;
                for(int i = 0; i < top; i++) {
                    stmt = c.prepareStatement("select currentquantity,maxquantity from mara where materialnumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    stmt.setInt(1,materialnumber[i]);
                    quantitydtls = stmt.executeQuery();
                    while(quantitydtls.next()) {
                        currentquantity[i] = quantitydtls.getInt("currentquantity");
                        maxquantity[i] = quantitydtls.getInt("maxquantity");
                    }
                    quantitydtls.beforeFirst();
                }
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
                    <form action = "AcceptPR.jsp" method = "POST">
                        <h2>Requisition Details</h2><br>
                        <table class = "tableborder" id = "prdtls" name = "prdtls">
                            <tr>
                                <th>PR Number</th>
                                <th>Requested By</th>
                                <th>Description</th>
                                <th>Request Date</th>
                                <th>Material Category</th>
                                <th>Estimated Value</th>
                            </tr>
                            <%
                                while(prdetails.isFirst()) {
                            %>
                            <tr>    
                                <td><%= prdetails.getInt("prnumber")%></td>
                                <td><%= prdetails.getString("requestedby")%></td>
                                <td><%= prdetails.getString("description")%></td>
                                <td><%= prdetails.getDate("requestdate")%></td>
                                <td><%= prdetails.getString("materialcategory")%></td>
                                <td><%= prdetails.getInt("estimatedvalue")%></td>
                                <% 
                                    prdetails.next();
                                %>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <br>
                        <h4>Material Details : </h4>
                        <table class = "tableborder" id = "prdtls" name = "prdtls">
                            <tr>
                                <th>Material Number</th>
                                <th>Quantity Ordered</th>
                                <th>Current Quantity</th>
                                <th>Maximum Quantity</th>
                            </tr>
                            <%
                                for(int j = 0; j < top; j++) {
                            %>
                            <tr>
                                <td><%=materialnumber[j]%></td>
                                <td><%=orderedquantity[j]%></td>
                                <td><%=currentquantity[j]%></td>
                                <td><%=maxquantity[j]%></td>
                            </tr>
                            <%
                                }
                                c.close();
                            %>
                        </table>
                        <br>
                        <br>
                        <button type="submit" class="submit1">Create PO</button>&nbsp;&nbsp;
                        <button type="submit" class="submit1" formaction="RejectPR.jsp">Reject PR</button>
                        <br>
                        <br>
                    </form>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
