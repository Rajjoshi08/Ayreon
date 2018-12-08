<%-- 
    Document   : VendorSelection
    Created on : 10 Mar, 2018, 10:43:53 AM
    Author     : Jimil
--%>

<%@page import="java.sql.*"%>
<%@page import="java.io.StringReader"%>
<%@page import="java.io.StreamTokenizer"%>
<%@page import="java.io.Reader"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Vendor Selection</title>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
    </head>
    <body>
        <%!
            Reader reader;
            StreamTokenizer tokenizer;
        %>
        <%!
            public int optimumcostindexfind(int[] cost) {
                int index = 0;
                for(int i = 1; i < cost.length; i++) {
                    if(cost[i] < cost[index]) {
                        index = i;
                    }
                }
                return index;
            }
            public int optimumdtimeindexfind(int[] dtime) {
                int index = 0;
                for(int i = 1; i < dtime.length; i++) {
                    if(dtime[i] < dtime[index]) {
                        index = i;
                    }
                }
                return index;
            }
            public int optimumwarrantyindexfind(int[] warranty) {
                int index = 0;
                for(int i = 1; i < warranty.length; i++) {
                    if(warranty[i] > warranty[index]) {
                        index = i;
                    }
                }
                return index;
            }
            public int findoptimum(int optimumcostindex, int[] cost) {
                int largest = 0;
                for(int i = 1; i < cost.length; i++) {
                    if(cost[i] > largest) {
                        largest = i;
                    }
                }
                for(int i = 0; i < 3; i++) {
                    if(i != optimumcostindex && i != largest) {
                        return i;
                    }
                }
                return 0;
            }
        %>
        <%
            int ponumber = Integer.parseInt(session.getAttribute("PO Number").toString());
            int top = 0;
            int[] cost = new int[]{0,0,0};
            int[] dtime = new int[]{0,0,0};
            int[] warranty = new int[]{0,0,0};
            int[] optimumcost = new int[]{0,0,0};
            int[] optimumdtime = new int[]{0,0,0};
            int[] optimumwarranty = new int[]{0,0,0};
            int optimumcostindex = 0;
            int optimumdtimeindex = 0;
            int optimumwarrantyindex = 0;
            int vendor1count = 0;
            int vendor2count = 0;
            int vendor3count = 0;
            HashMap messageMap = new HashMap();
            Enumeration e = session.getAttributeNames();
            while (e.hasMoreElements()) {
                String name = (String)e.nextElement();
                if(name.contains("AyreonVendor")) {
                    messageMap.put(name, session.getAttribute(name));
                }
            }
            Map<String, String> map = new TreeMap<String, String>(messageMap); 
            Set set2 = map.entrySet();
            Iterator iterator2 = set2.iterator();
            while(iterator2.hasNext()) {
                Map.Entry me2 = (Map.Entry)iterator2.next();
                String str = me2.getValue().toString();
                reader = new StringReader(str);
                tokenizer = new StreamTokenizer(reader);
                int count = 0;
                while(tokenizer.nextToken()!=StreamTokenizer.TT_EOF){
                    count++;
                    if(tokenizer.ttype==StreamTokenizer.TT_NUMBER){
                        if(count == 4) {
                            cost[top] = (int)tokenizer.nval;
                        }
                        else if(count == 8) {
                            dtime[top] = (int)tokenizer.nval;
                        }
                        else if(count == 11) {
                            warranty[top] = (int)tokenizer.nval;
                        }
                    }
                }
                top++;
            }
            optimumcostindex = optimumcostindexfind(cost);
            optimumcost[optimumcostindex] = 1;
            if(optimumcostindex == 0) {
                vendor1count++;
            }else if(optimumcostindex == 1) {
                vendor2count++;
            }else if(optimumcostindex == 2) {
                vendor3count++;
            }
            optimumdtimeindex = optimumdtimeindexfind(dtime);
            optimumdtime[optimumdtimeindex] = 1;
            if(optimumdtimeindex == 0) {
                vendor1count++;
            }else if(optimumdtimeindex == 1) {
                vendor2count++;
            }else if(optimumdtimeindex == 2) {
                vendor3count++;
            }
            optimumwarrantyindex = optimumwarrantyindexfind(warranty);
            optimumwarranty[optimumwarrantyindex] = 1;
            if(optimumwarrantyindex == 0) {
                vendor1count++;
            }else if(optimumwarrantyindex == 1) {
                vendor2count++;
            }else if(optimumwarrantyindex == 2) {
                vendor3count++;
            }
            int optimum = 0;
            if(vendor1count == vendor2count && vendor2count == vendor3count) {
                optimum = findoptimum(optimumcostindex,cost) + 1;
            }else if(vendor1count > vendor2count) {
                if(vendor1count > vendor3count) {
                    optimum = 1;
                }else {
                    optimum = 3;
                }
            }else {
                if(vendor2count > vendor3count) {
                    optimum = 2;
                }else {
                    
                    optimum = 3;
                }
            }
            String vendorcategory = session.getAttribute("Vendor Category").toString();
            String vendorcode = "";
            if(vendorcategory.equals("Furniture & Fixture")) {
                vendorcode = "5100" + optimum;
            } else if(vendorcategory.equals("IT")) {
                vendorcode = "5200" + optimum;
            } else if(vendorcategory.equals("Network Equipment")) {
                vendorcode = "5300" + optimum;
            } else if(vendorcategory.equals("Office Equipment")) {
                vendorcode = "5400" + optimum;
            }
            session.setAttribute("Optimum Vendor Code", vendorcode);
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
            PreparedStatement stmt = c.prepareStatement("select vendorcode,vendordescription,vendoraddress,vendoremail from vendordtls where vendorcode = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            stmt.setInt(1, Integer.valueOf(vendorcode));
            ResultSet vendordtls = stmt.executeQuery();
            while(vendordtls.next()) {
                session.setAttribute("Optimum Vendor Email", vendordtls.getString("vendoremail"));
            }
            vendordtls.beforeFirst();
            c.commit();
            stmt = c.prepareStatement("update podtls set approvedvendor = ? where ponumber = ?");
            stmt.setInt(1, Integer.valueOf(vendorcode));
            stmt.setInt(2, ponumber);
            stmt.executeUpdate();
            c.commit();
            stmt = c.prepareStatement("insert into tenderdtls values(?,?,?,?)");
            stmt.setInt(1, ponumber);
            stmt.setInt(2, cost[optimum-1]);
            stmt.setInt(3,dtime[optimum-1]);
            stmt.setInt(4, warranty[optimum-1]);
            stmt.executeUpdate();
            c.commit();
            session.setAttribute("Optimum Cost", cost[optimum-1]);
            session.setAttribute("Optimum Dtime", dtime[optimum-1]);
            session.setAttribute("Optimum Warranty", warranty[optimum-1]);
        %>
        
        <div class="container">

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
                        <form method="post" action="ConfirmOrder.jsp">
                            <h1>Most Optimum Vendor</h1>
                            <table class="tableborder">
                                <%
                                    while(vendordtls.next()) {
                                %>
                                <tr>
                                    <th>Vendor Code : </th>
                                    <td><%=vendordtls.getInt("vendorcode")%></td>
                                </tr>
                                <tr>
                                    <th>Vendor Description : </th>
                                    <td><%=vendordtls.getString("vendordescription")%></td>
                                </tr>
                                <tr>
                                    <th>Vendor Address : </th>
                                    <td><%=vendordtls.getString("vendoraddress")%></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <th>Cost : </th>
                                    <td><%=cost[optimum-1]%> Rs.</td>
                                </tr>
                                <tr>
                                    <th>Delivery Time : </th>
                                    <td><%=dtime[optimum-1]%> days</td>
                                </tr>
                                <tr>
                                    <th>Warranty : </th>
                                    <td><%=warranty[optimum-1]%> months</td>
                                </tr>
                            </table>
                            <br>
                            <input type="submit" value="Confirm Order" class="submit1">
                            <br>
                            <br>
                        </form>
                    </center>
                </article>
                                
                <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
