<%-- 
    Document   : GetVendors
    Created on : 26 Feb, 2018, 1:06:25 PM
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
        <title>Ayreon - Vendor Details</title>
    </head>
    <body> 
        <div class="container">

            <%!
                int ponumber = 0;
                String materialcategory;
                int vendorcode1 = 0;
                int vendorcode2 = 0;
                int vendorcode3 = 0;
                int[] codes = new int[3];
                String[] vendordes = new String[3];
                String[] vendoraddr = new String[3];
                String[] vendoremail = new String[3];
            %>
            <%
                ponumber = Integer.parseInt(application.getAttribute("PO Number").toString());
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                PreparedStatement stmt = c.prepareStatement("select materialcategory from podtls where ponumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, ponumber);
                ResultSet categorydtls = stmt.executeQuery();
                while(categorydtls.next()) {
                    materialcategory = categorydtls.getString("materialcategory");
                }
                application.setAttribute("Material Category", materialcategory);
                categorydtls.beforeFirst();
                stmt = c.prepareStatement("select vendor1code, vendor2code, vendor3code from categorymaster where category = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setString(1, materialcategory);
                ResultSet vendordtls = stmt.executeQuery();
                while(vendordtls.next()) {
                    vendorcode1 = vendordtls.getInt("vendor1code");
                    vendorcode2 = vendordtls.getInt("vendor2code");
                    vendorcode3 = vendordtls.getInt("vendor3code");
                }
                codes[0] = vendorcode1;
                codes[1] = vendorcode2;
                codes[2] = vendorcode3;
                vendordtls.beforeFirst();
                vendordtls = null;
                int top = 0;
                for(int i = 0; i < 3; i++) {
                    stmt = c.prepareStatement("select vendordescription,vendoraddress,vendoremail from vendordtls where vendorcode = ?");
                    stmt.setInt(1, codes[i]);
                    vendordtls = stmt.executeQuery();
                    while(vendordtls.next()) {
                        vendordes[top] = vendordtls.getString("vendordescription");
                        vendoraddr[top] = vendordtls.getString("vendoraddress");
                        vendoremail[top] = vendordtls.getString("vendoremail");
                        top++;
                    }
                }
                application.setAttribute("Vendor Email", vendoremail);
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
                    <form method="post" action="MailConfig.jsp">
                        <h2>Vendor Details</h2><br><br>
                        <h4>Material Category : <%=materialcategory%></h4>
                        <table class ="tableborder">
                            <tr>
                                <th>Vendor Code</th>
                                <th>Vendor Description</th>
                                <th>Vendor Address</th>
                                <th>Vendor Email</th>
                            </tr>
                            <%
                                for(int i = 0; i < top; i++) {
                            %>
                            <tr>
                                <td><%=codes[i]%></td>
                                <td><%=vendordes[i]%></td>
                                <td><%=vendoraddr[i]%></td>
                                <td><%=vendoremail[i]%></td>
                            </tr>
                            <%
                                }
                                c.close();
                            %>
                        </table>
                        <br>
                        <br>
                        <input type ="submit" class="submit1" value="Confirm">
                        <br>
                        <br>
                    </form>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>