<%-- 
    Document   : LogDelivery
    Created on : 19 Mar, 2018, 1:02:24 PM
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
        <title>Ayreon - Log Delivery</title>
    </head>
    <body>
        <%
            int ponumber, orderid = 0, vendorcode = 0;
            int top = 0;
            String[] materialnames = new String[]{"","",""};
            int[] materialquantity = new int[]{0,0,0};
            int[] materialid = new int[]{0,0,0};
            int[] current = new int[]{0,0,0};
            ponumber = Integer.parseInt(request.getParameter("ponumberdropdown"));
            session.setAttribute("PO Number", ponumber);
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
            PreparedStatement stmt = c.prepareStatement("select orderid,approvedvendor from podtls where ponumber = ?");
            stmt.setInt(1, ponumber);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()) {
                orderid = rs.getInt("orderid");
                vendorcode = rs.getInt("approvedvendor");
            }
            c.commit();
            stmt = c.prepareStatement("select materialnumber, materialquantity from orderdtls where orderid = ?");
            stmt.setInt(1, orderid);
            rs = stmt.executeQuery();
            while(rs.next()) {
                materialid[top] = rs.getInt("materialnumber");
                materialquantity[top] = rs.getInt("materialquantity");
                top++;
            }
            c.commit();
            for(int j = 0; j < top; j++) {
                stmt = c.prepareStatement("select materialname from mara where materialnumber = ?");
                stmt.setInt(1, materialid[j]);
                rs = stmt.executeQuery();
                while(rs.next()) {
                    materialnames[j] = rs.getString("materialname");
                }
            }
            c.commit();
            stmt = c.prepareStatement("select currentquantity from deliverydtls where ponumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stmt.setInt(1, ponumber);
            rs = stmt.executeQuery();
            rs.last();
            int rows = rs.getRow();
            rs.beforeFirst();
            if(rows == 0) {
                for(int i = 0; i < top; i++) {
                    current[i] = 0;
                }
            } else {
                int j = 0;
                while(rs.next()) {
                    current[j] = rs.getInt("currentquantity");
                    j++;
                }
            }
            session.setAttribute("Order ID", orderid);
            session.setAttribute("Material Count", top);
            session.setAttribute("Material Names", materialnames);
            session.setAttribute("Material Quantity", materialquantity);
            session.setAttribute("Delivered By", vendorcode);
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
                <form method="post" action="StoreLog.jsp">
                    <center>
                        <br>
                        <br>
                        <b>PO Number : <input type="text" name="ponumber" value="<%=ponumber%>" disabled="yes"></b><br><br>
                        <b>Vendor ID : <input type="text" name="vendorid" value="<%=vendorcode%>" disabled="yes"></b><br><br> 
                        <b>Material Details : </b><br><br>
                        <table class="tableborder">
                            <tr>
                                <th>Name</th>
                                <th>Total Quantity</th>
                                <th>Current Quantity</th>
                                <th>Quantity Received</th>
                                <th>Faulty Pieces</th>
                            </tr>
                            <%
                                for(int j = 0; j < top; j++) {
                            %>
                            <tr>
                                <td><%=materialnames[j]%></td>
                                <td><%=materialquantity[j]%></td>
                                <td><%=current[j]%></td>
                                <%
                                    if(rows == 0) {
                                %>
                                <td><input type="number" name="receivedquantity" max = "<%=materialquantity[j]%>" required></td>
                                <%
                                    } else {
                                %>
                                <td><input type="number" name="receivedquantity" max = "<%=materialquantity[j]-current[j]%>" required></td>
                                <%
                                    }
                                %>
                                <td><input type="number" name="faulty" placeholder="Enter 0 if none" required></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <br>
                        <br>
                        <b>Chalan Number : </b><input type="text" name="chalan" required><br><br>
                        <b>Delivery Date : </b><input type="text" name="deliverydate" placeholder="dd/mm/yyyy" required>
                        <br>
                        <br>
                        <input type="submit" value="submit" class="submit1">
                        <br>
                        <br>
                    </center>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
